import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../services/alert_service.dart';

class CreateAlertScreen extends StatefulWidget {
  const CreateAlertScreen({super.key});

  @override
  State<CreateAlertScreen> createState() => _CreateAlertScreenState();
}

class _CreateAlertScreenState extends State<CreateAlertScreen> {
  final _formKey = GlobalKey<FormState>();
  final _departureCityController = TextEditingController();
  final _arrivalCityController = TextEditingController();
  final AlertService _alertService = AlertService();

  int _departureRadius = 0;
  int _arrivalRadius = 0;
  bool _includeReturnTrip = false;
  bool _isSubmitting = false;

  final List<int> _radiusOptions = [0, 10, 25, 50, 100];

  @override
  void dispose() {
    _departureCityController.dispose();
    _arrivalCityController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final departureCity = _departureCityController.text.trim();
    final arrivalCity = _arrivalCityController.text.trim();

    if (departureCity.isEmpty && arrivalCity.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vous devez renseigner au moins une ville'),
          backgroundColor: AppTheme.warningColor,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await _alertService.createAlert(
        departureCity: departureCity.isEmpty ? null : departureCity,
        departureRadius: _departureRadius,
        arrivalCity: arrivalCity.isEmpty ? null : arrivalCity,
        arrivalRadius: _arrivalRadius,
        includeReturnTrip: _includeReturnTrip,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Alerte créée avec succès !'),
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
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bothCitiesFilled = _departureCityController.text.trim().isNotEmpty &&
        _arrivalCityController.text.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer une alerte'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Info card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: AppTheme.primaryColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Soyez notifié dès qu\'une mission correspond à vos critères',
                      style: TextStyle(
                        color: AppTheme.primaryColor.withOpacity(0.9),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Departure city
            const Text(
              'Ville de départ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _departureCityController,
              decoration: const InputDecoration(
                labelText: 'Ville de départ (optionnel)',
                hintText: 'Ex: Paris',
                prefixIcon: Icon(Icons.circle, color: AppTheme.successColor),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),

            // Departure radius
            const Text(
              'Rayon de recherche pour le départ',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<int>(
              value: _departureRadius,
              decoration: const InputDecoration(
                labelText: 'Rayon (km)',
              ),
              items: _radiusOptions.map((radius) {
                return DropdownMenuItem(
                  value: radius,
                  child: Text(radius == 0 ? 'Ville exacte' : '$radius km'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _departureRadius = value ?? 0);
              },
            ),
            const SizedBox(height: 32),

            // Arrival city
            const Text(
              'Ville d\'arrivée',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _arrivalCityController,
              decoration: const InputDecoration(
                labelText: 'Ville d\'arrivée (optionnel)',
                hintText: 'Ex: Lyon',
                prefixIcon: Icon(Icons.location_on, color: AppTheme.errorColor),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),

            // Arrival radius
            const Text(
              'Rayon de recherche pour l\'arrivée',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<int>(
              value: _arrivalRadius,
              decoration: const InputDecoration(
                labelText: 'Rayon (km)',
              ),
              items: _radiusOptions.map((radius) {
                return DropdownMenuItem(
                  value: radius,
                  child: Text(radius == 0 ? 'Ville exacte' : '$radius km'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _arrivalRadius = value ?? 0);
              },
            ),
            const SizedBox(height: 32),

            // Return trip option
            if (bothCitiesFilled) ...[
              SwitchListTile(
                title: const Text('Inclure le trajet retour'),
                subtitle: const Text(
                  'Soyez également notifié pour les trajets dans le sens inverse',
                ),
                value: _includeReturnTrip,
                onChanged: (value) {
                  setState(() => _includeReturnTrip = value);
                },
                activeColor: AppTheme.primaryColor,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 24),
            ],

            // Submit button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Créer l\'alerte',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
