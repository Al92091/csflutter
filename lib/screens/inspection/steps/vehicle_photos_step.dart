import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/theme.dart';
import '../../../services/inspection_service.dart';
import '../../../utils/image_helper.dart';

class VehiclePhotosStep extends StatefulWidget {
  final Function(List<Map<String, dynamic>>) onPhotosChanged;
  final List<Map<String, dynamic>> initialPhotos;

  /// true = EDL départ, false = EDL arrivée
  final bool isDeparture;

  /// Véhicule électrique => affiche "Kit de recharge"
  final bool isElectricVehicle;

  const VehiclePhotosStep({
    super.key,
    required this.onPhotosChanged,
    required this.initialPhotos,
    required this.isDeparture,
    required this.isElectricVehicle,
  });

  @override
  State<VehiclePhotosStep> createState() => _VehiclePhotosStepState();
}

class _VehiclePhotosStepState extends State<VehiclePhotosStep> {
  final InspectionService _inspectionService = InspectionService();
  final ImagePicker _picker = ImagePicker();

  /// Photos effectivement prises (avec path local)
  /// (obligatoires + optionnelles)
  late List<Map<String, dynamic>> _photos;

  /// Liste canonique des photos attendues (pour la grille)
  late List<Map<String, dynamic>> _requirements;

  /// Séquence d’enchaînement (ordre spécifique départ / arrivée)
  late List<Map<String, dynamic>> _sequence;

  /// Index courant dans _sequence quand on est en mode capture
  int? _currentSequenceIndex;

  /// Fichier capturé en cours de validation (✔️ / ❌)
  File? _capturedFile;

  /// Dégâts en cours pour la photo capturée
  /// ex: { "type": "raye", "size": "moins de 5 cm" }
  List<Map<String, String?>> _currentDamages = [];

  @override
  void initState() {
    super.initState();
    _photos = List<Map<String, dynamic>>.from(widget.initialPhotos);
    _initRequirementsAndSequence();
  }

  void _initRequirementsAndSequence() {
    final all = _inspectionService.getDeparturePhotoRequirements();

    // 1) On garde uniquement les catégories véhicule (ext + roues + int + accessoires)
    final baseRequirements = all.where((req) {
      final category = req['category'] as String;
      if (req['order'] == 24 && !widget.isElectricVehicle) {
        // Kit de recharge uniquement si véhicule électrique
        return false;
      }
      return category == 'exterior' ||
          category == 'wheels' ||
          category == 'interior' ||
          category == 'additional';
    }).toList();

    // 2) Ordre d’enchaînement spécifique selon départ / arrivée
    final List<int> sequenceOrders = widget.isDeparture
        ? <int>[
            // EDL DÉPART
            8, // Face avant
            9, // Pare brise
            5, // Latéral Avant Droit
            7, // Coque rétroviseur Droit
            14, // Roue avant droite
            6, // Latéral Arrière Droit
            18, // Sièges arrière
            13, // Roue arrière droite
            15, // Toit
            4, // Face arrière
            20, // Coffre ouvert
            22, // Roue de secours ou kit de gonflage
            23, // Kit de sécurité
            24, // Kit de recharge (si présent)
            2, // Latéral Arrière Gauche
            12, // Roue arrière gauche
            10, // Coque rétroviseur gauche
            1, // Latéral Avant Gauche
            17, // Sièges avant
            21, // Clés du véhicule
            16, // Tableau de bord complet
          ]
        : <int>[
            // EDL ARRIVÉE
            16, // Tableau de bord complet
            21, // Clés du véhicule
            17, // Sièges avant
            12, // Roue arrière gauche
            10, // Coque rétroviseur gauche
            1, // Latéral Avant Gauche
            8, // Face avant
            9, // Pare-brise
            5, // Latéral Avant Droit
            7, // Coque rétroviseur droit
            14, // Roue avant droite
            6, // Latéral Arrière Droit
            18, // Sièges arrière
            13, // Roue arrière droite
            15, // Toit
            4, // Face arrière
            20, // Coffre ouvert
            22, // Roue de secours ou kit de gonflage
            23, // Kit de sécurité
            24, // Kit de recharge (si présent)
            2, // Latéral Arrière Gauche
          ];

    // 3) Construire la séquence dans l'ordre voulu
    _sequence = [];
    for (final ord in sequenceOrders) {
      final matches = baseRequirements.where((r) => r['order'] == ord);
      _sequence.addAll(matches);
    }

    // 4) Pour la grille et le compteur, on utilise le même ordre que la séquence
    _requirements = List<Map<String, dynamic>>.from(_sequence);
  }

  Future<bool> _isLandscape(File file) async {
    final bytes = await file.readAsBytes();
    final completer = Completer<ui.Image>();
    ui.decodeImageFromList(bytes, (ui.Image img) {
      completer.complete(img);
    });
    final image = await completer.future;
    return image.width >= image.height;
  }

  Future<void> _captureForRequirement(Map<String, dynamic> requirement) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image == null) return;

      final File imageFile = File(image.path);
      final compressed = await ImageHelper.compressImage(imageFile);

      if (compressed == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de la compression de l\'image'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }

      final isValidSize = await ImageHelper.isFileSizeValid(compressed);
      if (!isValidSize) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('L\'image est trop volumineuse (max 5MB)'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }

      final isLandscape = await _isLandscape(compressed);
      if (!isLandscape) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'La photo doit être prise en mode paysage. Merci de recommencer.',
            ),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }

      setState(() {
        _capturedFile = compressed;
        _currentDamages = []; // reset dégâts pour cette photo
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur : ${e.toString()}'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  Future<void> _startCaptureFromRequirement(
    Map<String, dynamic> requirement,
  ) async {
    if (_sequence.isEmpty) return;

    final int indexInSequence = _sequence.indexWhere(
      (r) => r['order'] == requirement['order'],
    );

    if (indexInSequence == -1) return;

    // 🔹 Si une photo existe déjà pour ce requirement,
    // on ouvre la page de confirmation avec cette photo + ses dégâts.
    final existingPhoto = _findPhotoForRequirement(requirement);
    if (existingPhoto != null) {
      final existingPath = existingPhoto['path'] as String?;
      final existingDamagesList =
          (existingPhoto['damages'] as List?)?.map<Map<String, String?>>((d) {
                final map = d as Map;
                return {
                  'type': map['type'] as String?,
                  'size': map['size'] as String?,
                };
              }).toList() ??
              <Map<String, String?>>[];

      setState(() {
        _currentSequenceIndex = indexInSequence;
        _capturedFile = existingPath != null ? File(existingPath) : null;
        _currentDamages = existingDamagesList;
      });

      // pas de lancement caméra ici
      return;
    }

    // 🔹 Sinon comportement normal : on lance la caméra
    setState(() {
      _currentSequenceIndex = indexInSequence;
      _capturedFile = null;
      _currentDamages = [];
    });

    await _captureForRequirement(_sequence[indexInSequence]);
  }

  Future<void> _confirmCurrentPhoto() async {
    if (_currentSequenceIndex == null || _capturedFile == null) return;

    final currentReq = _sequence[_currentSequenceIndex!];
    final file = _capturedFile!;

    setState(() {
      // On remplace la photo existante (si déjà prise)
      _photos.removeWhere(
        (p) =>
            p['order'] == currentReq['order'] && (p['optional_type'] == null),
      );
      _photos.add({
        'order': currentReq['order'],
        'label': currentReq['label'],
        'path': file.path,
        'category': currentReq['category'],
        'optional_type': null,
        'damages': List<Map<String, String?>>.from(_currentDamages),
      });
      _photos.sort((a, b) {
        final ao = (a['order'] ?? 999999) as int;
        final bo = (b['order'] ?? 999999) as int;
        return ao.compareTo(bo);
      });
    });

    widget.onPhotosChanged(_photos);

    final nextIndex = _currentSequenceIndex! + 1;

    if (nextIndex < _sequence.length) {
      final nextReq = _sequence[nextIndex];

      // 🔹 Vérifier si la photo suivante existe déjà
      final existingNextPhoto = _findPhotoForRequirement(nextReq);

      if (existingNextPhoto != null) {
        final existingPath = existingNextPhoto['path'] as String?;
        final existingDamagesList =
            (existingNextPhoto['damages'] as List?)?.map<Map<String, String?>>(
                  (d) {
                    final map = d as Map;
                    return {
                      'type': map['type'] as String?,
                      'size': map['size'] as String?,
                    };
                  },
                ).toList() ??
                <Map<String, String?>>[];

        setState(() {
          _currentSequenceIndex = nextIndex;
          _capturedFile = existingPath != null ? File(existingPath) : null;
          _currentDamages = existingDamagesList;
        });
        // pas de caméra : on affiche la confirmation de la photo déjà prise
      } else {
        // aucune photo → on passe à la suivante en lançant la caméra
        setState(() {
          _currentSequenceIndex = nextIndex;
          _capturedFile = null;
          _currentDamages = [];
        });
        await _captureForRequirement(nextReq);
      }
    } else {
      // fin de séquence
      setState(() {
        _currentSequenceIndex = null;
        _capturedFile = null;
        _currentDamages = [];
      });
    }
  }

  Future<void> _retakeCurrentPhoto() async {
    if (_currentSequenceIndex == null) return;

    setState(() {
      _capturedFile = null;
      _currentDamages = [];
    });

    await _captureForRequirement(_sequence[_currentSequenceIndex!]);
  }

  void _exitCaptureMode() {
    setState(() {
      _currentSequenceIndex = null;
      _capturedFile = null;
      _currentDamages = [];
    });
  }

  Map<String, dynamic>? _findPhotoForRequirement(
    Map<String, dynamic> requirement,
  ) {
    try {
      return _photos.firstWhere(
        (p) =>
            p['order'] == requirement['order'] && (p['optional_type'] == null),
      );
    } catch (_) {
      return null;
    }
  }

  // --- Gestion des dégâts ---

  void _openDamageTypeSheet() {
    if (_capturedFile == null) return;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              const Text(
                'Signaler un dégât',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildDamageTypeTile('raye', 'Rayé'),
              _buildDamageTypeTile('casse', 'Cassé'),
              _buildDamageTypeTile('sale', 'Sale'),
              _buildDamageTypeTile('manquant', 'Manquant'),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDamageTypeTile(String key, String label) {
    return ListTile(
      leading: const Icon(Icons.report_problem_outlined),
      title: Text(label),
      onTap: () {
        Navigator.of(context).pop();
        if (key == 'raye' || key == 'casse') {
          _openDamageSizeSheet(key, label);
        } else {
          _addDamage(key, null);
        }
      },
    );
  }

  void _openDamageSizeSheet(String key, String label) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Text(
                'Taille du dégât ($label)',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildSizeTile(key, 'moins de 5 cm'),
              _buildSizeTile(key, '5 cm à 10 cm'),
              _buildSizeTile(key, '15 cm à 20 cm'),
              _buildSizeTile(key, 'plus de 20 cm'),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSizeTile(String key, String sizeLabel) {
    return ListTile(
      leading: const Icon(Icons.straighten),
      title: Text(sizeLabel),
      onTap: () {
        Navigator.of(context).pop();
        _addDamage(key, sizeLabel);
      },
    );
  }

  void _addDamage(String typeKey, String? size) {
    setState(() {
      _currentDamages.add({
        'type': typeKey,
        'size': size,
      });
    });
  }

  String _damageTypeDisplayLabel(String key, int count) {
    switch (key) {
      case 'raye':
        return count > 1 ? 'éléments rayés' : 'élément rayé';
      case 'casse':
        return count > 1 ? 'éléments cassés' : 'élément cassé';
      case 'sale':
        return count > 1 ? 'éléments sales' : 'élément sale';
      case 'manquant':
        return count > 1 ? 'éléments manquants' : 'élément manquant';
      default:
        return 'dégâts';
    }
  }

  Widget _buildDamagesSummary() {
    if (_currentDamages.isEmpty) {
      return const SizedBox.shrink();
    }

    final Map<String, int> counts = {};
    for (final d in _currentDamages) {
      final key = d['type'] ?? 'autre';
      counts[key] = (counts[key] ?? 0) + 1;
    }

    final parts = counts.entries.map((e) {
      final label = _damageTypeDisplayLabel(e.key, e.value);
      return '${e.value} $label';
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          parts.join('   •   '),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppTheme.errorColor,
          ),
        ),
      ),
    );
  }

  // --- Photos optionnelles (dégâts / éléments additionnels) ---

  Future<void> _addOptionalPhoto(String optionalType) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );
      if (image == null) return;

      final File imageFile = File(image.path);
      final compressed = await ImageHelper.compressImage(imageFile);

      if (compressed == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de la compression de l\'image'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }

      final isValidSize = await ImageHelper.isFileSizeValid(compressed);
      if (!isValidSize) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('L\'image est trop volumineuse (max 5MB)'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }

      // (optionnel) imposer paysage ici aussi si besoin

      final indexForType =
          _photos.where((p) => p['optional_type'] == optionalType).length + 1;

      final label = optionalType == 'degats'
          ? 'Photo dégâts $indexForType'
          : 'Élément additionnel $indexForType';

      setState(() {
        _photos.add({
          'order': null,
          'label': label,
          'path': compressed.path,
          'category': 'optional',
          'optional_type': optionalType,
        });
      });

      widget.onPhotosChanged(_photos);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Photo optionnelle ajoutée'),
          backgroundColor: AppTheme.successColor,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur : ${e.toString()}'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  void _removeOptionalPhoto(Map<String, dynamic> photo) {
    setState(() {
      _photos.remove(photo);
    });
    widget.onPhotosChanged(_photos);
  }

  List<Map<String, dynamic>> get _optionalPhotos =>
      _photos.where((p) => p['optional_type'] != null).toList();

  @override
  Widget build(BuildContext context) {
    // Mode "preview + ✔️ / ❌" si on a une capture en cours
    if (_currentSequenceIndex != null && _capturedFile != null) {
      final currentReq = _sequence[_currentSequenceIndex!];

      // Calcul du prochain label éventuel
      String? nextLabel;
      final nextIndex = _currentSequenceIndex! + 1;
      if (nextIndex < _sequence.length) {
        nextLabel = _sequence[nextIndex]['label'] as String;
      }

      return Stack(
        children: [
          Column(
            children: [
              // On laisse de la place pour le label en haut
              const SizedBox(height: 72),

              // Bouton "Signaler Dégâts" centré, avant la photo
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: _openDamageTypeSheet,
                    icon: const Icon(Icons.report_problem_outlined),
                    label: const Text('Signaler Dégâts'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Center(
                  child: Image.file(
                    _capturedFile!,
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
              ),

              // Résumé des dégâts (sous la photo)
              _buildDamagesSummary(),

              // Texte "Photo suivante : ..."
              if (nextLabel != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Photo suivante : $nextLabel',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ❌ Reprendre
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.errorColor,
                        minimumSize: const Size(140, 48),
                      ),
                      onPressed: _retakeCurrentPhoto,
                      icon: const Icon(Icons.close),
                      label: const Text('Reprendre'),
                    ),
                    // ✔️ Valider (VERT)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.successColor,
                        minimumSize: const Size(140, 48),
                      ),
                      onPressed: _confirmCurrentPhoto,
                      icon: const Icon(Icons.check),
                      label: const Text('Valider'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Label en petit en haut à gauche
          Positioned(
            top: 24,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                currentReq['label'] as String,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Bouton retour (vers la grille) en haut à droite
          Positioned(
            top: 16,
            right: 8,
            child: IconButton(
              onPressed: _exitCaptureMode,
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    }

    // Sinon : mode grille classique
    final takenCount = _photos
        .where((p) => p['optional_type'] == null)
        .length; // uniquement photos obligatoires
    final totalCount = _requirements.length;

    final optionalPhotos = _optionalPhotos;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Photos du véhicule',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Prenez des photos claires de l\'extérieur, de l\'intérieur et des accessoires du véhicule',
            style: TextStyle(
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.photo_camera,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Progression',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$takenCount / $totalCount photos',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                CircularProgressIndicator(
                  value: totalCount == 0 ? 0 : takenCount / totalCount,
                  backgroundColor: Colors.white,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _requirements.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final requirement = _requirements[index];
              final photo = _findPhotoForRequirement(requirement);
              final hasPhoto = photo != null;
              final String? photoPath =
                  hasPhoto ? photo!['path'] as String? : null;

              return GestureDetector(
                onTap: () {
                  _startCaptureFromRequirement(requirement);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: hasPhoto
                          ? AppTheme.successColor
                          : Colors.grey.shade300,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: hasPhoto && photoPath != null
                              ? Image.file(
                                  File(photoPath),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                )
                              : Container(
                                  color: AppTheme.backgroundColor,
                                  child: const Icon(
                                    Icons.add_a_photo,
                                    size: 48,
                                    color: AppTheme.textHint,
                                  ),
                                ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Text(
                              requirement['label'] as String,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              (requirement['required'] ?? true)
                                  ? 'Obligatoire'
                                  : 'Optionnel',
                              style: TextStyle(
                                fontSize: 11,
                                color: (requirement['required'] ?? true)
                                    ? AppTheme.warningColor
                                    : AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          // --- Section photos optionnelles ---
          const Text(
            'Photos supplémentaires (optionnel)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vous pouvez ajouter des photos libres de dégâts ou d\'éléments additionnels.',
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _addOptionalPhoto('degats'),
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  label: const Text('Ajouter photo dégâts'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () =>
                      _addOptionalPhoto('elements_additionnels'),
                  icon: const Icon(Icons.add_photo_alternate),
                  label: const Text('Éléments additionnels'),
                ),
              ),
            ],
          ),
          if (optionalPhotos.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: optionalPhotos.map((p) {
                final path = p['path'] as String?;
                final optType = p['optional_type'] as String?;
                final label = p['label'] as String? ?? '';

                final typeLabel =
                    optType == 'degats' ? 'Dégâts' : 'Éléments additionnels';

                return SizedBox(
                  width: 110,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: path != null
                                ? Image.file(
                                    File(path),
                                    width: 110,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 110,
                                    height: 80,
                                    color: AppTheme.backgroundColor,
                                  ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: InkWell(
                              onTap: () => _removeOptionalPhoto(p),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  Icons.close,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        typeLabel,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppTheme.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                size: 16,
                color: AppTheme.warningColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Assurez-vous que toutes les photos obligatoires sont prises en mode paysage.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.warningColor.withOpacity(0.9),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}