import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/theme.dart';
import '../../../services/inspection_service.dart';
import '../../../utils/image_helper.dart';

class ExteriorPhotosStep extends StatefulWidget {
  final Function(List<Map<String, dynamic>>) onPhotosChanged;
  final List<Map<String, dynamic>> initialPhotos;

  const ExteriorPhotosStep({
    super.key,
    required this.onPhotosChanged,
    required this.initialPhotos,
  });

  @override
  State<ExteriorPhotosStep> createState() => _ExteriorPhotosStepState();
}

class _ExteriorPhotosStepState extends State<ExteriorPhotosStep> {
  final InspectionService _inspectionService = InspectionService();
  final ImagePicker _picker = ImagePicker();
  
  late List<Map<String, dynamic>> _photos;
  late List<Map<String, dynamic>> _photoRequirements;

  @override
  void initState() {
    super.initState();
    _photos = List.from(widget.initialPhotos);
    _photoRequirements = _inspectionService.getDeparturePhotoRequirements()
        .where((req) => req['category'] == 'exterior' || req['category'] == 'wheels')
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
          'category': 'exterior', // ✅ Ajout du champ category
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
            'Photos extérieures',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Prenez des photos claires de l\'extérieur du véhicule',
            style: TextStyle(
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          
          // Progress
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.photo_camera, color: AppTheme.primaryColor),
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
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                CircularProgressIndicator(
                  value: takenCount / totalCount,
                  backgroundColor: Colors.white,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Photo grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemCount: _photoRequirements.length,
            itemBuilder: (context, index) {
              final requirement = _photoRequirements[index];
              final hasPhoto = _hasPhoto(requirement['order']);
              final photoPath = _getPhotoPath(requirement['order']);

              return GestureDetector(
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
                              requirement['label'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Icon(
                              hasPhoto ? Icons.check_circle : Icons.camera_alt,
                              size: 16,
                              color: hasPhoto ? AppTheme.successColor : AppTheme.textSecondary,
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
                    'Toutes les photos sont obligatoires. Cliquez sur une photo pour la reprendre.',
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
