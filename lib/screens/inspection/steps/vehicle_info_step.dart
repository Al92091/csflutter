import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/theme.dart';
import '../../../utils/validators.dart';
import '../../../utils/image_helper.dart';

class VehicleInfoStep extends StatefulWidget {
  final Function(int, int, String?) onDataChanged; // ✅ mileage et fuelLevel toujours requis
  final int? initialMileage;
  final int? initialFuelLevel;
  final String? initialDashboardPath;

  const VehicleInfoStep({
    super.key,
    required this.onDataChanged,
    this.initialMileage,
    this.initialFuelLevel,
    this.initialDashboardPath,
  });

  @override
  State<VehicleInfoStep> createState() => _VehicleInfoStepState();
}

class _VehicleInfoStepState extends State<VehicleInfoStep> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  late TextEditingController _mileageController;
  int _fuelLevel = 50;
  String? _dashboardPhotoPath;

  @override
  void initState() {
    super.initState();
    _mileageController = TextEditingController(
      text: widget.initialMileage?.toString() ?? '',
    );
    _fuelLevel = widget.initialFuelLevel ?? 50;
    _dashboardPhotoPath = widget.initialDashboardPath;
  }

  @override
  void dispose() {
    _mileageController.dispose();
    super.dispose();
  }

  /// 🔄 Met à jour les données dans le parent
  void _updateData() {
    final mileage = int.tryParse(_mileageController.text);
    if (mileage != null) {
      widget.onDataChanged(mileage, _fuelLevel, _dashboardPhotoPath);
    }
  }

  /// ✅ Validation obligatoire avant de continuer
  bool validateAndSave() {
    if (_formKey.currentState?.validate() ?? false) {
      _updateData();
      return true;
    }
    return false;
  }

  Future<void> _takeDashboardPhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (photo != null) {
        final compressed = await ImageHelper.compressImage(File(photo.path));

        if (compressed != null) {
          setState(() => _dashboardPhotoPath = compressed.path);
          _updateData();
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(
                Icons.dashboard,
                size: 80,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Informations du véhicule',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Mileage obligatoire
            TextFormField(
              controller: _mileageController,
              decoration: const InputDecoration(
                labelText: 'Kilométrage',
                prefixIcon: Icon(Icons.speed),
                suffixText: 'km',
              ),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  Validators.validateNumber(value, 'Kilométrage'),
              onChanged: (_) => _updateData(),
              onFieldSubmitted: (_) => _updateData(), // ✅ validation si Enter
            ),
            const SizedBox(height: 24),

            // Fuel Level
            const Text(
              'Niveau de carburant',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.local_gas_station,
                    color: AppTheme.primaryColor),
                Expanded(
                  child: Slider(
                    value: _fuelLevel.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 20,
                    label: '$_fuelLevel%',
                    onChanged: (value) {
                      setState(() => _fuelLevel = value.round());
                      _updateData();
                    },
                  ),
                ),
                Text(
                  '$_fuelLevel%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Dashboard Photo
            const Text(
              'Photo du tableau de bord',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            if (_dashboardPhotoPath != null) ...[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.successColor, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(_dashboardPhotoPath!),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ] else ...[
              Container(
                width: double.infinity,
                height: 200,
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
                      size: 48,
                      color: AppTheme.textHint,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Aucune photo',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: _takeDashboardPhoto,
                icon: const Icon(Icons.camera_alt),
                label: Text(
                  _dashboardPhotoPath != null
                      ? 'Reprendre la photo'
                      : 'Prendre la photo',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
