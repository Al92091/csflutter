import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/theme.dart';
import '../../../utils/image_helper.dart';

class DriverPhotoStep extends StatefulWidget {
  final Function(String) onPhotoTaken;
  final String? initialPhotoPath;

  const DriverPhotoStep({
    super.key,
    required this.onPhotoTaken,
    this.initialPhotoPath,
  });

  @override
  State<DriverPhotoStep> createState() => _DriverPhotoStepState();
}

class _DriverPhotoStepState extends State<DriverPhotoStep> {
  final ImagePicker _picker = ImagePicker();
  String? _photoPath;

  @override
  void initState() {
    super.initState();
    _photoPath = widget.initialPhotoPath;
  }

  @override
  void didUpdateWidget(covariant DriverPhotoStep oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialPhotoPath != widget.initialPhotoPath) {
      setState(() {
        _photoPath = widget.initialPhotoPath;
      });
    }
  }

  Future<void> _takePicture() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 85,
      );

      if (photo != null) {
        // Compress image
        final compressed = await ImageHelper.compressImage(File(photo.path));
        
        if (compressed != null) {
          setState(() => _photoPath = compressed.path);
          widget.onPhotoTaken(compressed.path);
        }
      }
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur: ${e.toString()}'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.person_pin_circle,
            size: 80,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(height: 24),
          const Text(
            'Photo du convoyeur',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'Prenez une photo de vous avec le véhicule en arrière-plan pour confirmer votre présence.',
            style: TextStyle(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          
          if (_photoPath != null) ...[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.successColor, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(_photoPath!),
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: AppTheme.successColor),
                SizedBox(width: 8),
                Text(
                  'Photo enregistrée',
                  style: TextStyle(
                    color: AppTheme.successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ] else ...[
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: AppTheme.backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.textHint,
                  style: BorderStyle.solid,
                  width: 2,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt,
                    size: 64,
                    color: AppTheme.textHint,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Aucune photo',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
          
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _takePicture,
              icon: const Icon(Icons.camera_alt),
              label: Text(
                _photoPath != null ? 'Reprendre la photo' : 'Prendre la photo',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
