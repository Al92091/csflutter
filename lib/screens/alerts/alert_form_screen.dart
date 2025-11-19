import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../services/alert_service.dart';

class AlertFormScreen extends StatefulWidget {
  const AlertFormScreen({super.key});

  @override
  State<AlertFormScreen> createState() => _AlertFormScreenState();
}

class _AlertFormScreenState extends State<AlertFormScreen> {
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
          content: Text("Vous devez renseigner au moins une ville"),
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
          content: Text("Alerte créée avec succès !"),
          backgroundColor: AppTheme.successColor,
        ),
      );

      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur : ${e.toString()}"),
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
        title: const Text("Nouvelle alerte"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              "Ville de départ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _departureCityController,
              decoration: const InputDecoration(
                labelText: "Ville de départ (optionnel)",
                prefixIcon: Icon(Icons.circle, color: AppTheme.successColor),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),

            const Text(
              "Rayon de recherche (départ)",
              style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
            ),
            DropdownButtonFormField<int>(
              value: _departureRadius,
              items: _radiusOptions.map((r) {
                return DropdownMenuItem(
                  value: r,
                  child: Text(r == 0 ? "Ville exacte" : "$r km"),
                );
              }).toList(),
              onChanged: (value) => setState(() => _departureRadius = value ?? 0),
            ),
            const SizedBox(height: 32),

            const Text(
              "Ville d'arrivée",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _arrivalCityController,
              decoration: const InputDecoration(
                labelText: "Ville d'arrivée (optionnel)",
                prefixIcon: Icon(Icons.location_on, color: AppTheme.errorColor),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),

            const Text(
              "Rayon de recherche (arrivée)",
              style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
            ),
            DropdownButtonFormField<int>(
              value: _arrivalRadius,
              items: _radiusOptions.map((r) {
                return DropdownMenuItem(
                  value: r,
                  child: Text(r == 0 ? "Ville exacte" : "$r km"),
                );
              }).toList(),
              onChanged: (value) => setState(() => _arrivalRadius = value ?? 0),
            ),
            const SizedBox(height: 32),

            if (bothCitiesFilled)
              SwitchListTile(
                title: const Text("Inclure le trajet retour"),
                subtitle: const Text(
                    "Soyez également notifié pour les trajets inverses"),
                value: _includeReturnTrip,
                onChanged: (v) => setState(() => _includeReturnTrip = v),
                activeColor: AppTheme.primaryColor,
              ),

            const SizedBox(height: 24),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text("Créer l'alerte"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
