import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';
import 'package:path_provider/path_provider.dart';
import '../../../config/theme.dart';

class SignatureStep extends StatefulWidget {
  /// onSignaturesChanged(etatDesLieuxPhotoPath, driverSignaturePath, contactSignaturePath)
  final Function(String?, String?, String?) onSignaturesChanged;

  final String? initialEtatDesLieuxPhoto;
  final String? initialDriverSignature;
  final String? initialContactSignature;

  const SignatureStep({
    super.key,
    required this.onSignaturesChanged,
    this.initialEtatDesLieuxPhoto,
    this.initialDriverSignature,
    this.initialContactSignature,
  });

  @override
  State<SignatureStep> createState() => _SignatureStepState();
}

class _SignatureStepState extends State<SignatureStep> {
  final SignatureController _driverController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  final SignatureController _contactController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  final ImagePicker _picker = ImagePicker();

  String? _etatDesLieuxPhotoPath;
  String? _driverSignaturePath;
  String? _contactSignaturePath;

  @override
  void initState() {
    super.initState();
    _etatDesLieuxPhotoPath = widget.initialEtatDesLieuxPhoto;
    _driverSignaturePath = widget.initialDriverSignature;
    _contactSignaturePath = widget.initialContactSignature;
  }

  @override
  void dispose() {
    _driverController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Future<void> _takeEtatDesLieuxPhoto() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image == null) return;

      setState(() {
        _etatDesLieuxPhotoPath = image.path;
      });

      widget.onSignaturesChanged(
        _etatDesLieuxPhotoPath,
        _driverSignaturePath,
        _contactSignaturePath,
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

  Future<void> _saveDriverSignature() async {
    if (_driverController.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez signer avant de valider'),
          backgroundColor: AppTheme.warningColor,
        ),
      );
      return;
    }

    try {
      final signature = await _driverController.toPngBytes();
      if (signature == null) return;

      final directory = await getTemporaryDirectory();
      final path =
          '${directory.path}/driver_signature_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(path);
      await file.writeAsBytes(signature);

      setState(() {
        _driverSignaturePath = path;
      });

      widget.onSignaturesChanged(
        _etatDesLieuxPhotoPath,
        _driverSignaturePath,
        _contactSignaturePath,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signature du convoyeur enregistrée'),
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

  Future<void> _saveContactSignature() async {
    if (_contactController.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Veuillez faire signer le contact avant de valider',
          ),
          backgroundColor: AppTheme.warningColor,
        ),
      );
      return;
    }

    try {
      final signature = await _contactController.toPngBytes();
      if (signature == null) return;

      final directory = await getTemporaryDirectory();
      final path =
          '${directory.path}/contact_signature_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(path);
      await file.writeAsBytes(signature);

      setState(() {
        _contactSignaturePath = path;
      });

      widget.onSignaturesChanged(
        _etatDesLieuxPhotoPath,
        _driverSignaturePath,
        _contactSignaturePath,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signature du contact enregistrée'),
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Signatures',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ajoutez la photo du contrat de convoyage tamponné, puis signez ainsi que le contact au départ',
            style: TextStyle(
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 24),

          // ----- PHOTO CONTRAT DE CONVOYAGE -----
          Text(
            'Photo contrat de convoyage tamponné',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _etatDesLieuxPhotoPath != null
                    ? AppTheme.successColor
                    : AppTheme.textHint,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                  child: _etatDesLieuxPhotoPath != null
                      ? ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Image.file(
                            File(_etatDesLieuxPhotoPath!),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.camera_alt_outlined,
                              size: 40,
                              color: AppTheme.textHint,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Prenez une photo du contrat de convoyage tamponné',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Ajoutez le contrat de convoyage tamponné',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: _takeEtatDesLieuxPhoto,
                        icon: const Icon(Icons.photo_camera, size: 18),
                        label: const Text('Prendre une photo'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ----- SIGNATURE CONVOYEUR -----
          _buildSignatureSection(
            title: 'Signature du convoyeur',
            controller: _driverController,
            savedPath: _driverSignaturePath,
            onClear: () {
              _driverController.clear();
              setState(() => _driverSignaturePath = null);
              widget.onSignaturesChanged(
                _etatDesLieuxPhotoPath,
                null,
                _contactSignaturePath,
              );
            },
            onSave: _saveDriverSignature,
            color: AppTheme.primaryColor,
          ),

          const SizedBox(height: 24),

          // ----- SIGNATURE CONTACT -----
          _buildSignatureSection(
            title: 'Signature du contact',
            controller: _contactController,
            savedPath: _contactSignaturePath,
            onClear: () {
              _contactController.clear();
              setState(() => _contactSignaturePath = null);
              widget.onSignaturesChanged(
                _etatDesLieuxPhotoPath,
                _driverSignaturePath,
                null,
              );
            },
            onSave: _saveContactSignature,
            color: AppTheme.secondaryColor,
          ),

          const SizedBox(height: 24),

          // Info box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.warningColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.warningColor.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppTheme.warningColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Les deux signatures sont obligatoires. Utilisez votre doigt pour signer sur l\'écran.',
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

  Widget _buildSignatureSection({
    required String title,
    required SignatureController controller,
    required String? savedPath,
    required VoidCallback onClear,
    required VoidCallback onSave,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  savedPath != null ? AppTheme.successColor : AppTheme.textHint,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                ),
                child: savedPath != null
                    ? ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        child: Image.file(
                          File(savedPath),
                          fit: BoxFit.contain,
                        ),
                      )
                    : Signature(
                        controller: controller,
                        backgroundColor: Colors.grey[50]!,
                      ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    if (savedPath != null)
                      Expanded(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.check_circle,
                              color: AppTheme.successColor,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Signature enregistrée',
                              style: TextStyle(
                                color: AppTheme.successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Expanded(
                        child: Text(
                          'Signez dans la zone ci-dessus',
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    TextButton.icon(
                      onPressed: onClear,
                      icon: const Icon(Icons.clear, size: 18),
                      label: const Text('Effacer'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppTheme.errorColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (savedPath == null)
                      ElevatedButton.icon(
                        onPressed: onSave,
                        icon: const Icon(Icons.check, size: 18),
                        label: const Text('Valider'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
