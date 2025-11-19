import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/theme.dart';
import '../../../services/inspection_service.dart';
import '../../../utils/image_helper.dart';

class InteriorPhotosStep extends StatefulWidget {
  final Function(List<Map<String, dynamic>>) onPhotosChanged;
  final List<Map<String, dynamic>> initialPhotos;

  const InteriorPhotosStep({
    super.key,
    required this.onPhotosChanged,
    required this.initialPhotos,
  });

  @override
  State<InteriorPhotosStep> createState() => _InteriorPhotosStepState();
}

class _InteriorPhotosStepState extends State<InteriorPhotosStep> {
  final InspectionService _inspectionService = InspectionService();
  final ImagePicker _picker = ImagePicker();
  
  late List<Map<String, dynamic>> _photos;
  late List<Map<String, dynamic>> _photoRequirements;

  @override
  void initState() {
    super.initState();
    _photos = List.from(widget.initialPhotos);
    _photoRequirements = _inspectionService.getDeparturePhotoRequirements()
        .where((req) => req['category'] == 'interior' || req['category'] == 'additional')
        .toList();
  }

  Future<void> _takePhoto(Map<String, dynamic> requirement) async {
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

      final isValid = await ImageHelper.isFileSizeValid(compressed);
      if (!isValid) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('L\'image est trop volumineuse (max 5MB)'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }

      setState(() {
        _photos.removeWhere((p) => p['order'] == requirement['order']);
        _photos.add({
          'order': requirement['order'],
          'label': requirement['label'],
          'path': compressed.path,
          'category': 'interior', // ✅ Ajout du champ category
        });
        _photos.sort((a, b) => a['order'].compareTo(b['order']));
      });

      widget.onPhotosChanged(_photos);
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

  bool _hasPhoto(int order) {
    return _photos.any((p) => p['order'] == order);
  }

  String? _getPhotoPath(int order) {
    try {
      return _photos.firstWhere((p) => p['order'] == order)['path'];
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final takenCount = _photos.length;
    final totalCount = _photoRequirements.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Photos intérieures et accessoires',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Prenez des photos de l\'intérieur et des accessoires du véhicule',
            style: TextStyle(
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          
          // Progress
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.photo_library, color: AppTheme.secondaryColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Progression',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$takenCount / $totalCount photos',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                CircularProgressIndicator(
                  value: takenCount / totalCount,
                  backgroundColor: Colors.white,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.secondaryColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Photo list (vertical layout for better readability)
          ...(_photoRequirements.map((requirement) {
            final hasPhoto = _hasPhoto(requirement['order']);
            final photoPath = _getPhotoPath(requirement['order']);

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => _takePhoto(requirement),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: hasPhoto ? AppTheme.successColor : AppTheme.textHint,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Photo preview or placeholder
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundColor,
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(10),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(10),
                          ),
                          child: hasPhoto && photoPath != null
                              ? Image.file(
                                  File(photoPath),
                                  fit: BoxFit.cover,
                                )
                              : const Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: AppTheme.textHint,
                                ),
                        ),
                      ),
                      
                      // Label and status
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                requirement['label'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    hasPhoto ? Icons.check_circle : Icons.camera_alt,
                                    size: 16,
                                    color: hasPhoto
                                        ? AppTheme.successColor
                                        : AppTheme.textSecondary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    hasPhoto ? 'Photo prise' : 'À photographier',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: hasPhoto
                                          ? AppTheme.successColor
                                          : AppTheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      // Arrow icon
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.chevron_right,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList()),
          
          const SizedBox(height: 16),

          // Info box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.warningColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.warningColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppTheme.warningColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Toutes les photos sont obligatoires. Cliquez sur une ligne pour (re)prendre la photo.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.warningColor.withOpacity(0.9),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
