// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/theme.dart';
import '../../config/constants.dart';
import '../../models/mission.dart';
import '../../models/inspection_report.dart';
import '../../services/mission_service.dart';
import '../../services/inspection_service.dart';
import '../../utils/formatters.dart';
import '../../widgets/loading_indicator.dart';
import '../inspection/inspection_flow_screen.dart';
import 'package:carswift_driver/services/driver_price_calculator.dart';
import 'mission_reservation_screen.dart';

class MissionDetailScreen extends StatefulWidget {
  final String missionId;
  final bool isAvailable;

  const MissionDetailScreen({
    super.key,
    required this.missionId,
    required this.isAvailable,
  });

  @override
  State<MissionDetailScreen> createState() => _MissionDetailScreenState();
}

class _MissionDetailScreenState extends State<MissionDetailScreen> {
  final MissionService _missionService = MissionService();
  final InspectionService _inspectionService = InspectionService();

  Mission? _mission;
  bool _isLoading = true;
  bool _isBooking = false;
  String? _errorMessage;
  bool _navigationLaunched = false;

  // État pour les inspections
  bool _hasDepartureInspection = false;
  bool _hasArrivalInspection = false;
  int? _departureMileage;
  int? _departureFuelLevel;

  // =====================================================
  // INITIALISATION
  // =====================================================

  @override
  void initState() {
    super.initState();
    _loadMission();
    _loadNavigationState();
    _loadInspectionStatus();
  }

  Future<void> _loadNavigationState() async {
    final prefs = await SharedPreferences.getInstance();
    final launched =
        prefs.getBool('navigation_launched_${widget.missionId}') ?? false;
    setState(() => _navigationLaunched = launched);
  }

  // =====================================================
  // CHARGEMENT DES INSPECTIONS
  // =====================================================

  Future<void> _loadInspectionStatus() async {
    try {
      final departure = await _inspectionService.getInspectionReportForMission(
        widget.missionId,
        AppConstants.inspectionDeparture,
      );

      final arrival = await _inspectionService.getInspectionReportForMission(
        widget.missionId,
        AppConstants.inspectionArrival,
      );

      if (!mounted) return;

      setState(() {
        _hasDepartureInspection = departure != null;
        _hasArrivalInspection = arrival != null;

        if (departure != null) {
          _departureMileage = departure.mileage;
          _departureFuelLevel = departure.fuelLevel;
        }
      });
    } catch (e) {
      // On log juste, pas d'UI spéciale
      debugPrint('Erreur chargement inspections: $e');
    }
  }

  // =====================================================
  // NAVIGATION GPS
  // =====================================================

  Future<void> _launchNavigation(String address) async {
    final encoded = Uri.encodeComponent(address);
    final Uri googleMapsUri = Uri.parse("google.navigation:q=$encoded");
    final Uri wazeUri = Uri.parse("waze://?q=$encoded&navigate=yes");
    final Uri appleMapsUri = Uri.parse("http://maps.apple.com/?daddr=$encoded");

    try {
      bool launched = false;

      if (await canLaunchUrl(wazeUri)) {
        launched = await launchUrl(
          wazeUri,
          mode: LaunchMode.externalApplication,
        );
      } else if (await canLaunchUrl(googleMapsUri)) {
        launched = await launchUrl(
          googleMapsUri,
          mode: LaunchMode.externalApplication,
        );
      } else if (await canLaunchUrl(appleMapsUri)) {
        launched = await launchUrl(
          appleMapsUri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw Exception("Aucune application GPS trouvée sur ce téléphone");
      }

      if (launched) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('navigation_launched_${widget.missionId}', true);
        if (mounted) setState(() => _navigationLaunched = true);
      }
    } catch (e) {
      debugPrint("Erreur GPS : $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Impossible d'ouvrir le GPS : $e")),
      );
    }
  }

  // =====================================================
  // CHARGEMENT & RÉSERVATION DE MISSION
  // =====================================================

  Future<void> _loadMission() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final mission = await _missionService.getMissionById(widget.missionId);
      setState(() {
        _mission = mission;
        _isLoading = false;

        // On synchronise les flags avec les IDs présents sur la mission
        _hasDepartureInspection = _hasDepartureInspection ||
            (mission.departureInspectionId != null);
        _hasArrivalInspection =
            _hasArrivalInspection || (mission.arrivalInspectionId != null);
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _bookMission() async {
    if (_mission == null) return;
    setState(() => _isBooking = true);

    try {
      final calculator = DriverPriceCalculator();
      final options = <String, bool>{
        'document_management': _mission!.documentManagement ?? false,
        'basic_handover': _mission!.basicHandover ?? false,
        'comfort_handover': _mission!.comfortHandover ?? false,
        'basic_washing': _mission!.basicWashing ?? false,
        'standard_washing': _mission!.standardWashing ?? false,
        'premium_washing': _mission!.premiumWashing ?? false,
        'w_garage': _mission!.wGarage ?? false,
        'electric_vehicle': _mission!.electricVehicle ?? false,
      };

      final isReturn = (_mission!.isReturnMission ?? false) ||
          (_mission!.missionType == 'livraison_reprise');

      final driverStatus =
          await calculator.getCurrentDriverStatus() ?? 'active_beginner';

      final reservedPrice = await calculator.calculateFinalDriverPrice(
        distanceKm: (_mission!.distanceMission ?? 0).toDouble(),
        driverStatus: driverStatus,
        options: options,
        isReturnMission: isReturn,
      );

      await _missionService.bookMission(_mission!.id, reservedPrice);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mission réservée avec succès !'),
          backgroundColor: AppTheme.successColor,
        ),
      );

      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur : ${e.toString()}'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    } finally {
      if (mounted) setState(() => _isBooking = false);
    }
  }

  // =====================================================
  // OUTILS
  // =====================================================

  void _startInspection(String inspectionType) {
    if (_mission == null) return;
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (_) => InspectionFlowScreen(
              mission: _mission!,
              inspectionType: inspectionType,
            ),
          ),
        )
        .then((_) {
          _loadMission();
          _loadInspectionStatus();
        });
  }

  int _roundSite(double value) {
    final euros = value.floor();
    final cents = ((value * 100).floor()) % 100;
    return (cents >= 51) ? (euros + 1) : euros;
  }

  String? _formatTravelTime(dynamic travelTime) {
    if (travelTime == null) return null;
    try {
      final totalMinutes = travelTime is int
          ? travelTime
          : int.tryParse(travelTime.toString()) ?? 0;
      final hours = totalMinutes ~/ 60;
      final minutes = totalMinutes % 60;
      if (hours == 0) return "${minutes} min";
      return "${hours}h${minutes.toString().padLeft(2, '0')}";
    } catch (_) {
      return null;
    }
  }

  // =====================================================
  // BUILD INTERFACE PRINCIPALE
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_mission?.missionNumber ?? 'Détails')),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildUnifiedPrice() {
    if (_mission == null) return const SizedBox();

    if (_mission!.reservedDriverPrice != null) {
      final rounded = _roundSite(_mission!.reservedDriverPrice!);
      return Text(
        '${rounded}€',
        style: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    final calculator = DriverPriceCalculator();
    final options = <String, bool>{
      'document_management': _mission!.documentManagement ?? false,
      'basic_handover': _mission!.basicHandover ?? false,
      'comfort_handover': _mission!.comfortHandover ?? false,
      'basic_washing': _mission!.basicWashing ?? false,
      'standard_washing': _mission!.standardWashing ?? false,
      'premium_washing': _mission!.premiumWashing ?? false,
      'w_garage': _mission!.wGarage ?? false,
      'electric_vehicle': _mission!.electricVehicle ?? false,
    };

    final isReturn = (_mission!.isReturnMission ?? false) ||
        (_mission!.missionType == 'livraison_reprise');

    return FutureBuilder<double>(
      future: () async {
        final driverStatus =
            await calculator.getCurrentDriverStatus() ?? 'active_beginner';
        return calculator.calculateFinalDriverPrice(
          distanceKm: (_mission!.distanceMission ?? 0).toDouble(),
          driverStatus: driverStatus,
          options: options,
          isReturnMission: isReturn,
        );
      }(),
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done || !snap.hasData) {
          return const Text(
            '...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          );
        }
        final rounded = _roundSite(snap.data!);
        return Text(
          '${rounded}€',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }

  String _formatVehicleType(String type) {
    if (type.startsWith("utilitaire")) {
      final size = type.replaceAll("utilitaire", "");
      return "Utilitaire ${size}m³";
    }
    return type;
  }

  String _mapLocationType(String? code) {
    switch (code) {
      case "rdv_particulier":
        return "Chez un Particulier";
      case "agence_concession":
        return "Agence/Concession";
      case "parc_auto":
        return "Parc Auto";
      case "societe":
        return "Société";
      default:
        return "";
    }
  }

  Future<void> _launchPhone(String phone) async {
    final url = 'tel:$phone';
    try {
      final success = await launchUrlString(
        url,
        mode: LaunchMode.externalNonBrowserApplication,
      );
      if (!success) {
        debugPrint("Impossible d'ouvrir le composeur pour $phone");
      }
    } catch (e) {
      debugPrint("Erreur lors de l'ouverture du composeur : $e");
    }
  }

  Widget _buildBody() {
    if (_isLoading) return const LoadingIndicator(message: 'Chargement...');
    if (_errorMessage != null || _mission == null) {
      return Center(
        child: Text("Erreur: ${_errorMessage ?? 'Mission introuvable'}"),
      );
    }

    final isReserved = _mission!.reservedDriverPrice != null;

    // Conditions d’affichage du bloc Kilométrage & Carburant :
    // - EDL de départ présent (via mission OU via table inspection_reports)
    // - EDL d’arrivée absent (via mission ET table inspection_reports)
    final bool showKmFuelBlock =
        (_mission!.departureInspectionId != null || _hasDepartureInspection) &&
            (_mission!.arrivalInspectionId == null &&
                !_hasArrivalInspection);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête mission
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  _mission!.missionNumber,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                _buildUnifiedPrice(),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Section Itinéraire
          _buildSection(
            'Itinéraire',
            Icons.route,
            [
              _buildItineraryItem(
                'Départ',
                _mission!.departureAddress,
                _mapLocationType(_mission!.departureLocationType),
                _mission!.departurePlaceName,
                Icons.circle,
                AppTheme.successColor,
              ),
              SizedBox(height: 16),
              _buildItineraryItem(
                'Arrivée',
                _mission!.arrivalAddress,
                _mapLocationType(_mission!.arrivalLocationType),
                _mission!.arrivalPlaceName,
                Icons.location_on,
                AppTheme.errorColor,
                estimatedTravelTime:
                    _formatTravelTime(_mission!.estimatedTravelTime),
              ),
            ],
          ),

          // SECTION : DATES
          _buildSection(
            'Dates',
            Icons.calendar_today,
            [
              if (!isReserved) ...[
                _buildInfoRow(
                  'Disponible dès',
                  Formatters.formatDateTime(_mission!.availabilityStart),
                ),
                _buildInfoRow(
                  'Deadline',
                  Formatters.formatDateTime(_mission!.deliveryDeadline),
                ),
              ] else ...[
                _buildInfoRow(
                  'Départ dès',
                  Formatters.formatDateTime(_mission!.pickupDatetime),
                ),
                _buildInfoRow(
                  'Arrivée à',
                  Formatters.formatDateTime(_mission!.deliveryDatetime),
                ),
              ],
            ],
          ),

          // SECTION : CONTACTS
          if (isReserved)
            _buildSection(
              'Contacts',
              Icons.contact_phone,
              [
                if (_mission!.departureContactName != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Contact au départ : ${_mission!.departureContactName!}",
                      ),
                      InkWell(
                        onTap: () =>
                            _launchPhone(_mission!.departureContactPhone!),
                        child: Text(
                          _mission!.departureContactPhone ?? "",
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 12),
                if (_mission!.arrivalContactName != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Contact à l'arrivée : ${_mission!.arrivalContactName!}",
                      ),
                      InkWell(
                        onTap: () =>
                            _launchPhone(_mission!.arrivalContactPhone!),
                        child: Text(
                          _mission!.arrivalContactPhone ?? "",
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),

          // SECTION : VÉHICULE
          _buildSection(
            'Véhicule',
            Icons.directions_car,
            [
              _buildInfoRow('Type', _formatVehicleType(_mission!.vehicleType)),
              if (_mission!.distanceMission != null)
                _buildInfoRow(
                  'Distance',
                  Formatters.formatDistance(_mission!.distanceMission),
                ),
              if (isReserved && _mission!.vehicleRegistration != null)
                _buildInfoRow(
                  'N° d\'immatriculation',
                  _mission!.vehicleRegistration!,
                ),
              if (isReserved && _mission!.vehicleChassisNumber != null)
                _buildInfoRow(
                  'N° de châssis',
                  _mission!.vehicleChassisNumber!,
                ),
              if (_mission!.vehicleTransmission != null)
                _buildInfoRow(
                  'Boîte de vitesses',
                  _mission!.vehicleTransmission!,
                ),
              if (_mission!.vehicleSeats != null)
                _buildInfoRow(
                  'Nombre de sièges',
                  _mission!.vehicleSeats.toString(),
                ),
              if (_mission!.vehicleImageUrl != null &&
                  _mission!.vehicleImageUrl!.isNotEmpty) ...[
                SizedBox(height: 12),
                Center(
                  child: Image.network(
                    _mission!.vehicleImageUrl!,
                    height: 160,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ],
          ),

          // SECTION : OPTIONS
          if (_hasOptions(excludeFuel: true))
            _buildSection(
              'Options',
              Icons.add_circle_outline,
              [
                if (_mission!.documentManagement ?? false)
                  _buildOptionChip('Gestion documentaire'),
                if (_mission!.basicHandover ?? false)
                  _buildOptionChip('Mise en main basique'),
                if (_mission!.comfortHandover ?? false)
                  _buildOptionChip('Mise en main confort'),
                if (_mission!.wGarage ?? false)
                  _buildOptionChip('Plaque W garage Requise'),
                if (_mission!.basicWashing ?? false)
                  _buildOptionChip('Lavage Basique'),
                if (_mission!.standardWashing ?? false)
                  _buildOptionChip('Lavage Standard'),
                if (_mission!.premiumWashing ?? false)
                  _buildOptionChip('Lavage Premium'),
                if (_mission!.electricVehicle ?? false)
                  _buildOptionChip('Véhicule électrique'),
              ],
            ),

          // SECTION : GESTION DU CARBURANT
          if (_mission!.fuelManagement != null &&
              _mission!.fuelManagement != 'pas_de_remise')
            _buildSection(
              'Gestion du Carburant',
              Icons.local_gas_station,
              [
                if (_mission!.fuelManagement == 'remise_niveau')
                  _buildOptionChip('Remise au même niveau'),
                if (_mission!.fuelManagement == 'plein')
                  _buildOptionChip('Remettre le plein'),
              ],
            ),

          // NOUVELLE SECTION : KILOMÉTRAGE & CARBURANT
          if (showKmFuelBlock) _buildKmFuelSection(),

          // SECTION : NOTES POUR LE CONVOYEUR
          if (isReserved &&
              _mission!.vehicleNotes != null &&
              _mission!.vehicleNotes!.trim().isNotEmpty)
            _buildSection(
              'Notes pour le convoyeur',
              Icons.note_alt,
              [
                Text(
                  _mission!.vehicleNotes!,
                  style: TextStyle(fontSize: 15, height: 1.4),
                ),
              ],
            ),

          SizedBox(height: 100),
        ],
      ),
    );
  }

  // =====================================================
  // SOUS-COMPOSANTS D'INTERFACE
  // =====================================================

  Widget _buildItineraryItem(
    String label,
    String address,
    String locationType,
    String? placeName,
    IconData icon,
    Color color, {
    String? estimatedTravelTime,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (locationType.isNotEmpty)
                Text("Type de lieu : $locationType",
                    style: TextStyle(fontSize: 12)),
              if (placeName != null)
                Text(placeName,
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              SizedBox(height: 4),
              Text(
                address,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              if (estimatedTravelTime != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    "Temps de trajet estimé : $estimatedTravelTime",
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(icon, color: AppTheme.primaryColor),
          SizedBox(width: 8),
          Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ]),
        SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: AppTheme.textSecondary)),
          Text(value, style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildOptionChip(String label) {
    return Padding(
      padding: EdgeInsets.only(right: 8, bottom: 8),
      child: Chip(
        label: Text(label),
        backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
        labelStyle: TextStyle(
          color: AppTheme.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  bool _hasOptions({bool excludeFuel = false}) {
    final m = _mission!;
    return (m.documentManagement ?? false) ||
        (m.basicHandover ?? false) ||
        (m.comfortHandover ?? false) ||
        (m.wGarage ?? false) ||
        (m.basicWashing ?? false) ||
        (m.standardWashing ?? false) ||
        (m.premiumWashing ?? false) ||
        (m.electricVehicle ?? false) ||
        (!excludeFuel &&
            (m.fuelManagement != null && m.fuelManagement != 'pas_de_remise'));
  }

  // Gauge carburant lecture seule
  Widget _buildFuelGauge(double level) {
  // clamp() retourne un num → on force en double
  final double clamped = level.clamp(0, 100).toDouble();

  return Slider(
    value: clamped,
    min: 0.0,          // double
    max: 100.0,        // double
    divisions: 20,
    label: '${clamped.round()}%',
    onChanged: null,   // lecture seule
  );
}


  // Bloc Kilométrage & Carburant
  Widget _buildKmFuelSection() {
    final mission = _mission!;
    final distance = mission.distanceMission ?? 0.0;
    final mileage = _departureMileage;
    final fuelManagement = mission.fuelManagement;
    final customerType = mission.customerType; // 'customer_business' / 'customer_individual'

    if (mileage == null) {
      // Pas de données fiables => on n'affiche rien
      return SizedBox.shrink();
    }

    double coef;
    if (customerType == 'customer_business') {
      coef = 1.1;
    } else if (customerType == 'customer_individual') {
      coef = 1.2;
    } else {
      coef = 1.1;
    }

    final includedKm = (distance * coef).round();
    final maxOdometer = mileage + includedKm;

    final int fuelLevel = (_departureFuelLevel ?? 0).toInt();

    final List<Widget> children = [];

    // Ligne kilométrage (version corrigée)
children.add(
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "km maximum autorisé sur le compteur",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      SizedBox(height: 4),
      Text(
        "$maxOdometer km",
        style: TextStyle(
          color: Colors.red,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  ),
);

children.add(SizedBox(height: 16));


    // Bloc carburant
    String fuelText = '';
    Widget fuelGauge = SizedBox.shrink();

    if (fuelManagement == 'pas_de_remise') {
      fuelText = 'Ne pas remettre de carburant si possible';
    } else if (fuelManagement == 'remise_niveau') {
      fuelText = 'Remettre le carburant à $fuelLevel%';
      fuelGauge = _buildFuelGauge(fuelLevel.toDouble());
    } else if (fuelManagement == 'plein') {
      fuelText = 'Remettre le plein de carburant';
      fuelGauge = _buildFuelGauge(100.0);
    }

    children.add(
      Text(
        'Carburant',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    children.add(SizedBox(height: 4));

    if (fuelText.isNotEmpty) {
      children.add(
        Text(
          fuelText,
          style: TextStyle(
            color: AppTheme.textSecondary,
          ),
        ),
      );
    }

    if (fuelGauge is! SizedBox) {
      children.add(SizedBox(height: 12));
      children.add(fuelGauge);
    }

    return _buildSection(
      'Kilométrage & Carburant',
      Icons.local_gas_station,
      children,
    );
  }

  // =====================================================
  // BARRE INFÉRIEURE (BOUTONS)
  // =====================================================

  Widget? _buildBottomBar() {
    if (_mission == null) return null;

    // Bouton GPS si mission en cours et GPS pas encore lancé
    if (_mission!.missionStatusDriver == "en_cours" && !_navigationLaunched) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () => _launchNavigation(_mission!.arrivalAddress),
              icon: Icon(Icons.navigation),
              label: Text("Aller à la destination"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ),
        ),
      );
    }

    // Bouton de réservation pour missions disponibles
    if (widget.isAvailable) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: (_isBooking || _mission == null)
              ? null
              : () async {
                  setState(() => _isBooking = true);

                  // On ouvre l'écran de réservation
                  final result = await Navigator.of(context).push<bool>(
                    MaterialPageRoute(
                      builder: (_) => MissionReservationScreen(
                        mission: _mission!,
                      ),
                    ),
                  );

                  // Si la réservation a réussi dans l'écran enfant
                  if (result == true) {
                    await _loadMission(); // rafraîchir les infos
                    if (!mounted) return;
                    // On revient à la liste en indiquant que quelque chose a changé
                    Navigator.of(context).pop(true);
                  } else {
                    if (mounted) {
                      setState(() => _isBooking = false);
                    }
                  }
                },
              child: _isBooking
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Réserver cette mission',
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ),
        ),
      );
    }

    // Boutons inspection départ / arrivée
    final canStartDeparture = _mission!.canStartDepartureInspection();
    final canStartArrival = _mission!.canStartArrivalInspection();
    if (!canStartDeparture && !canStartArrival) return null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (canStartDeparture)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () =>
                      _startInspection(AppConstants.inspectionDeparture),
                  icon: Icon(Icons.play_arrow),
                  label: Text("Commencer l'état des lieux de départ"),
                ),
              ),
            if (canStartArrival) ...[
              if (canStartDeparture) SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () =>
                      _startInspection(AppConstants.inspectionArrival),
                  icon: Icon(Icons.play_arrow),
                  label: Text("Commencer l'état des lieux d'arrivée"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.secondaryColor,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
