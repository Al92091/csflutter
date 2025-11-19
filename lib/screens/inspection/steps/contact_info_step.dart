import 'package:flutter/material.dart';
import '../../../config/theme.dart';
import '../../../utils/validators.dart';
import '../../../services/location_service.dart';

class ContactInfoStep extends StatefulWidget {
  final Function(String?, String?, String?) onDataChanged;
  final String? initialFirstName;
  final String? initialLastName;
  final String? initialPhone;

  const ContactInfoStep({
    super.key,
    required this.onDataChanged,
    this.initialFirstName,
    this.initialLastName,
    this.initialPhone,
  });

  @override
  State<ContactInfoStep> createState() => _ContactInfoStepState();
}

class _ContactInfoStepState extends State<ContactInfoStep> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.initialFirstName);
    _lastNameController = TextEditingController(text: widget.initialLastName);
    _phoneController = TextEditingController(text: widget.initialPhone);

    // Vérifie immédiatement la localisation
    Future.microtask(() async {
      final ok = await LocationService.ensureServiceAndPermission();
      if (!ok && mounted) {
        _showLocationRequiredDialog();
      }
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _updateData() {
    widget.onDataChanged(
      _firstNameController.text.trim().isNotEmpty ? _firstNameController.text.trim() : null,
      _lastNameController.text.trim().isNotEmpty ? _lastNameController.text.trim() : null,
      _phoneController.text.trim().isNotEmpty ? _phoneController.text.trim() : null,
    );
  }

  void _showLocationRequiredDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Localisation requise'),
        content: const Text(
          'La géolocalisation est obligatoire pour effectuer les états des lieux. '
          'Veuillez autoriser l\'accès à votre position.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Annuler'),
          ),
          TextButton(
            child: const Text('Réessayer'),
            onPressed: () async {
              final ok = await LocationService.ensureServiceAndPermission();
              if (ok && context.mounted) {
                Navigator.of(context).pop(); // ferme la popup si autorisé
              }
            },
          ),
        ],
      ),
    );
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
                Icons.contact_phone,
                size: 80,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Informations du contact',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Renseignez les coordonnées de la personne qui remet ou reçoit le véhicule.',
              style: TextStyle(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'Prénom (optionnel)',
                prefixIcon: Icon(Icons.person),
              ),
              onChanged: (_) => _updateData(),
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Nom (optionnel)',
                prefixIcon: Icon(Icons.person_outline),
              ),
              onChanged: (_) => _updateData(),
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Téléphone (optionnel)',
                prefixIcon: Icon(Icons.phone),
                hintText: '06 12 34 56 78',
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return Validators.validatePhone(value);
                }
                return null;
              },
              onChanged: (_) => _updateData(),
            ),
            
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.warningColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.warningColor.withOpacity(0.3),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppTheme.warningColor,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Ces informations sont facultatives mais recommandées pour faciliter le contact.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
