import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../../config/constants.dart';
import '../../models/mission.dart';
import '../../models/inspection_report.dart';
import '../../services/inspection_service.dart';
import '../../services/location_service.dart';
import '../../services/mission_service.dart';
import '../../services/local_inspection_storage_service.dart';

import 'steps/driver_photo_step.dart';
import 'steps/contact_info_step.dart';
import 'steps/vehicle_info_step.dart';
import 'steps/vehicle_photos_step.dart';
import 'steps/signature_step.dart';
import 'steps/expenses_step.dart';

class InspectionFlowScreen extends StatefulWidget {
  final Mission mission;
  final String inspectionType;

  const InspectionFlowScreen({
    super.key,
    required this.mission,
    required this.inspectionType,
  });

  @override
  State<InspectionFlowScreen> createState() => _InspectionFlowScreenState();
}

class _InspectionFlowScreenState extends State<InspectionFlowScreen> {
  final PageController _pageController = PageController();
  final InspectionService _inspectionService = InspectionService();
  final MissionService _missionService = MissionService();

  // key pour valider VehicleInfoStep
  final GlobalKey _vehicleStepKey = GlobalKey();

  int _currentStep = 0;
  bool _isSubmitting = false;

  // Données collectées
  String? _driverPhotoPath;
  String? _contactFirstName;
  String? _contactLastName;
  String? _contactPhone;
  int? _mileage;
  int? _fuelLevel;
  String? _dashboardPhotoPath;

  // Nouvelle liste fusionnée pour toutes les photos véhicule
  List<Map<String, dynamic>> _vehiclePhotos = [];

  // Signatures + photo contrat / état des lieux
  String? _etatDesLieuxPhotoPath;
  String? _driverSignaturePath;
  String? _contactSignaturePath;

  // Localisation
  double? _latitude;
  double? _longitude;

  // Frais (EDL arrivée)
  double? _fuelExpense;
  String? _fuelExpensePhotoPath;
  double? _tollExpense;
  String? _tollExpensePhotoPath;
  bool _skipExpenses = false;

  bool get _isDepartureInspection =>
      widget.inspectionType == AppConstants.inspectionDeparture;

  bool get _isElectricVehicle => widget.mission.electricVehicle == true;

  // Helper: convertir un fichier en base64
  Future<String?> _fileToBase64(String? filePath) async {
    if (filePath == null || filePath.isEmpty) return null;
    try {
      final bytes = await File(filePath).readAsBytes();
      return 'data:image/jpeg;base64,${base64Encode(bytes)}';
    } catch (e) {
      print("Erreur conversion base64: $e");
      return null;
    }
  }

  List<Widget> get _steps {
    final steps = <Widget>[
      DriverPhotoStep(
        onPhotoTaken: (path) {
          setState(() => _driverPhotoPath = path);
        },
        initialPhotoPath: _driverPhotoPath,
      ),
    ];

    if (_isDepartureInspection) {
      // EDL de départ :
      // 1. Contact
      // 2. Photos véhicule
      // 3. Infos véhicule
      steps.addAll([
        ContactInfoStep(
          onDataChanged: (firstName, lastName, phone) {
            setState(() {
              _contactFirstName = firstName;
              _contactLastName = lastName;
              _contactPhone = phone;
            });
          },
          initialFirstName: _contactFirstName,
          initialLastName: _contactLastName,
          initialPhone: _contactPhone,
        ),
        VehiclePhotosStep(
          onPhotosChanged: (photos) {
            setState(() => _vehiclePhotos = photos);
          },
          initialPhotos: _vehiclePhotos,
          isDeparture: true,
          isElectricVehicle: _isElectricVehicle,
        ),
        VehicleInfoStep(
          key: _vehicleStepKey,
          onDataChanged: (mileage, fuelLevel, dashboardPath) {
            setState(() {
              _mileage = mileage;
              _fuelLevel = fuelLevel;
              _dashboardPhotoPath = dashboardPath;
            });
          },
          initialMileage: _mileage,
          initialFuelLevel: _fuelLevel,
          initialDashboardPath: _dashboardPhotoPath,
        ),
      ]);
    } else {
      // EDL d'arrivée :
      // 1. Infos véhicule
      // 2. Frais
      // 3. Photos véhicule
      // 4. Contact
      steps.addAll([
        VehicleInfoStep(
          key: _vehicleStepKey,
          onDataChanged: (mileage, fuelLevel, dashboardPath) {
            setState(() {
              _mileage = mileage;
              _fuelLevel = fuelLevel;
              _dashboardPhotoPath = dashboardPath;
            });
          },
          initialMileage: _mileage,
          initialFuelLevel: _fuelLevel,
          initialDashboardPath: _dashboardPhotoPath,
        ),
        ExpensesStep(
          onDataChanged: (fuelExp, fuelPhoto, tollExp, tollPhoto, skip) {
            setState(() {
              _fuelExpense = fuelExp;
              _fuelExpensePhotoPath = fuelPhoto;
              _tollExpense = tollExp;
              _tollExpensePhotoPath = tollPhoto;
              _skipExpenses = skip;
            });
          },
          initialFuelExpense: _fuelExpense,
          initialFuelExpensePhoto: _fuelExpensePhotoPath,
          initialTollExpense: _tollExpense,
          initialTollExpensePhoto: _tollExpensePhotoPath,
          initialSkip: _skipExpenses,
        ),
        VehiclePhotosStep(
          onPhotosChanged: (photos) {
            setState(() => _vehiclePhotos = photos);
          },
          initialPhotos: _vehiclePhotos,
          isDeparture: false,
          isElectricVehicle: _isElectricVehicle,
        ),
        ContactInfoStep(
          onDataChanged: (firstName, lastName, phone) {
            setState(() {
              _contactFirstName = firstName;
              _contactLastName = lastName;
              _contactPhone = phone;
            });
          },
          initialFirstName: _contactFirstName,
          initialLastName: _contactLastName,
          initialPhone: _contactPhone,
        ),
      ]);
    }

    steps.add(
      SignatureStep(
        onSignaturesChanged:
            (String? etatDesLieuxPhotoPath, String? driverSig, String? contactSig) {
          setState(() {
            _etatDesLieuxPhotoPath = etatDesLieuxPhotoPath;
            _driverSignaturePath = driverSig;
            _contactSignaturePath = contactSig;
          });
        },
        initialEtatDesLieuxPhoto: _etatDesLieuxPhotoPath,
        initialDriverSignature: _driverSignaturePath,
        initialContactSignature: _contactSignaturePath,
      ),
    );

    return steps;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _checkLocation();
    _initDraftIfAny();
  }

  Future<void> _checkLocation() async {
    final granted = await LocationService.ensureServiceAndPermission();
    if (!granted) return;

    final position = await LocationService.getCurrentPosition();
    if (position != null) {
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
    }
  }

  // ---------- Gestion des brouillons locaux ----------

  Map<String, dynamic> _buildDraftData() {
    return {
      'mission_id': widget.mission.id,
      'inspection_type': widget.inspectionType,
      'current_step': _currentStep,
      'driver_photo_path': _driverPhotoPath,
      'contact_first_name': _contactFirstName,
      'contact_last_name': _contactLastName,
      'contact_phone': _contactPhone,
      'mileage': _mileage,
      'fuel_level': _fuelLevel,
      'dashboard_photo_path': _dashboardPhotoPath,
      'vehicle_photos': _vehiclePhotos,
      'etat_des_lieux_photo_path': _etatDesLieuxPhotoPath,
      'driver_signature_path': _driverSignaturePath,
      'contact_signature_path': _contactSignaturePath,
      'latitude': _latitude,
      'longitude': _longitude,
      'fuel_expense': _fuelExpense,
      'fuel_expense_photo_path': _fuelExpensePhotoPath,
      'toll_expense': _tollExpense,
      'toll_expense_photo_path': _tollExpensePhotoPath,
      'skip_expenses': _skipExpenses,
    };
  }

  Future<void> _restoreDraft(Map<String, dynamic> draft) async {
    setState(() {
      _currentStep = (draft['current_step'] ?? 0) is int
          ? draft['current_step'] as int
          : 0;

      _driverPhotoPath = draft['driver_photo_path'] as String?;
      _contactFirstName = draft['contact_first_name'] as String?;
      _contactLastName = draft['contact_last_name'] as String?;
      _contactPhone = draft['contact_phone'] as String?;

      final mileageVal = draft['mileage'];
      if (mileageVal is num) _mileage = mileageVal.toInt();

      final fuelVal = draft['fuel_level'];
      if (fuelVal is num) _fuelLevel = fuelVal.toInt();

      _dashboardPhotoPath = draft['dashboard_photo_path'] as String?;

      final photosList = draft['vehicle_photos'];
      if (photosList is List) {
        _vehiclePhotos = photosList
            .map<Map<String, dynamic>>(
              (e) => Map<String, dynamic>.from(e as Map),
            )
            .toList();
      } else {
        _vehiclePhotos = [];
      }

      _etatDesLieuxPhotoPath =
          draft['etat_des_lieux_photo_path'] as String?;
      _driverSignaturePath =
          draft['driver_signature_path'] as String?;
      _contactSignaturePath =
          draft['contact_signature_path'] as String?;

      final latVal = draft['latitude'];
      if (latVal is num) _latitude = latVal.toDouble();

      final lonVal = draft['longitude'];
      if (lonVal is num) _longitude = lonVal.toDouble();

      final fuelExpVal = draft['fuel_expense'];
      if (fuelExpVal is num) _fuelExpense = fuelExpVal.toDouble();

      _fuelExpensePhotoPath =
          draft['fuel_expense_photo_path'] as String?;

      final tollExpVal = draft['toll_expense'];
      if (tollExpVal is num) _tollExpense = tollExpVal.toDouble();

      _tollExpensePhotoPath =
          draft['toll_expense_photo_path'] as String?;

      _skipExpenses = draft['skip_expenses'] == true;
    });

    // Repositionner le PageView au bon step
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_currentStep >= 0 && _currentStep < _steps.length) {
        _pageController.jumpToPage(_currentStep);
      }
    });
  }

  Future<void> _initDraftIfAny() async {
    final exists = await LocalInspectionStorageService.draftExists(
      widget.mission.id,
    );
    if (!exists) return;
    if (!mounted) return;

    final choice = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Un état des lieux a déjà été commencé'),
        content: const Text(
            'Souhaitez-vous reprendre l\'état des lieux en cours ou recommencer un nouvel état des lieux ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop('restart'),
            child: const Text('Recommencer'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop('resume'),
            child: const Text('Reprendre'),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (choice == 'resume') {
      final draft = await LocalInspectionStorageService.loadDraftInspection(
        widget.mission.id,
      );
      if (draft != null) {
        await _restoreDraft(draft);
      }
    } else if (choice == 'restart') {
      await LocalInspectionStorageService.deleteDraftInspection(
        widget.mission.id,
      );
    }
  }

  Future<void> _handleCancelInspection() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Annuler l\'inspection'),
        content: const Text(
          'Êtes-vous sûr de vouloir annuler l\'inspection en cours ?'
          '\n\nToutes les informations seront sauvegardées localement '
          'pour que vous puissiez reprendre plus tard.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Non'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Oui'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final draftData = _buildDraftData();
      await LocalInspectionStorageService.saveDraftInspection(
        widget.mission.id,
        draftData,
      );
      if (mounted) {
        Navigator.of(context).pop(false);
      }
    }
  }

  void _nextStep() {
    // Validation du step "infos véhicule" quel que soit son index
    final currentWidget = _steps[_currentStep];
    if (currentWidget is VehicleInfoStep) {
      final state = _vehicleStepKey.currentState;
      final isValid = (state as dynamic?)?.validateAndSave() == true;
      if (!isValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez saisir un kilométrage valide.'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }
    }

    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _submitInspection();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Envoi inspection
  Future<void> _submitInspection() async {
    if (_latitude == null || _longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Localisation non disponible'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    if (_mileage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Le kilométrage du véhicule est requis.'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    if (_driverPhotoPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La photo du conducteur est requise.'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    if (_driverSignaturePath == null || _contactSignaturePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Les signatures sont requises.'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // Convertir fichiers → base64
      final driverPhotoBase64 = await _fileToBase64(_driverPhotoPath);
      final dashboardPhotoBase64 =
          await _fileToBase64(_dashboardPhotoPath);
      final driverSignatureBase64 =
          await _fileToBase64(_driverSignaturePath);
      final contactSignatureBase64 =
          await _fileToBase64(_contactSignaturePath);
      final fuelExpensePhotoBase64 =
          await _fileToBase64(_fuelExpensePhotoPath);
      final tollExpensePhotoBase64 =
          await _fileToBase64(_tollExpensePhotoPath);
      final etatDesLieuxPhotoBase64 =
          await _fileToBase64(_etatDesLieuxPhotoPath);

      // Convertir photos véhicule → base64 avec mappage des catégories
      final photosBase64 = <Map<String, dynamic>>[];

      for (final photo in _vehiclePhotos) {
        final base64 = await _fileToBase64(photo['path']);
        if (base64 == null) continue;

        String category = (photo['category'] as String?) ?? '';
        final String? optionalType = photo['optional_type'] as String?;

        // Photos obligatoires "additionnelles" → accessories
        if (category == 'additional') {
          category = 'accessories';
        }
        // Photos optionnelles :
        // - optional_type == 'degats'           → damages
        // - optional_type != 'degats' ou null   → accessories
        else if (category == 'optional') {
          if (optionalType == 'degats') {
            category = 'damages';
          } else {
            category = 'accessories';
          }
        }

        photosBase64.add({
          'photo_data': base64,
          'category': category,
          'label': photo['label'],
          'order_index': photo['order'],
          'optional_type': optionalType,
          'damages': photo['damages'] ?? [],
        });
      }

      final report = InspectionReport(
        missionId: widget.mission.id,
        driverId: widget.mission.driverId!,
        inspectionType: widget.inspectionType,
        driverPhoto: driverPhotoBase64,
        contactFirstName: _contactFirstName ?? '',
        contactLastName: _contactLastName ?? '',
        contactPhone: _contactPhone ?? '',
        mileage: _mileage,
        fuelLevel: _fuelLevel,
        dashboardPhoto: dashboardPhotoBase64,
        photos: photosBase64,
        driverSignature: driverSignatureBase64,
        contactSignature: contactSignatureBase64,
        etatDesLieuxPhoto: etatDesLieuxPhotoBase64,
        latitude: _latitude,
        longitude: _longitude,
        fuelExpense: _fuelExpense,
        fuelExpensePhoto: fuelExpensePhotoBase64,
        tollExpense: _tollExpense,
        tollExpensePhoto: tollExpensePhotoBase64,
      );

      await _inspectionService.submitInspectionReport(report);

      // On supprime le brouillon si tout s'est bien passé
      await LocalInspectionStorageService.deleteDraftInspection(
        widget.mission.id,
      );

      if (widget.inspectionType == AppConstants.inspectionDeparture) {
        // EDL de départ → mission en cours, clôturée côté driver
        await _missionService.updateMissionStatus(
          widget.mission.id,
          AppConstants.statusEnCours,
          AppConstants.clotureeDriver,
        );
      } else {
        // EDL d’arrivée → mission terminée, clôturée côté driver
        await _missionService.updateMissionStatus(
          widget.mission.id,
          AppConstants.statusTerminee,
          AppConstants.clotureeDriver,
        );
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('État des lieux envoyé avec succès !'),
          backgroundColor: AppTheme.successColor,
        ),
      );

      Navigator.of(context).pop(true);
    } catch (e) {
      print('Erreur lors de l\'envoi de l\'inspection: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de l\'envoi de l\'inspection.'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Bouton retour Android
      onWillPop: () async {
        if (_currentStep == 0) {
          // Même comportement que la croix
          await _handleCancelInspection();
        } else {
          _previousStep();
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.inspectionType == AppConstants.inspectionDeparture
                ? 'État des lieux de départ'
                : 'État des lieux d\'arrivée',
          ),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _handleCancelInspection,
          ),
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              LinearProgressIndicator(
                value: (_currentStep + 1) / _steps.length,
                backgroundColor: Colors.grey[200],
                color: AppTheme.primaryColor,
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _steps.length,
                  itemBuilder: (context, index) => _steps[index],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    if (_currentStep > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _isSubmitting ? null : _previousStep,
                          child: const Text('Précédent'),
                        ),
                      ),
                    if (_currentStep > 0) const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _nextStep,
                        child: Text(
                          _currentStep == _steps.length - 1
                              ? 'Terminer'
                              : 'Suivant',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
