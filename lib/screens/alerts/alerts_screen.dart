// lib/screens/alerts/alerts_screen.dart

import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../models/alert.dart';
import '../../services/alert_service.dart';
import '../../widgets/loading_indicator.dart';
import 'alert_form_screen.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  final AlertService _alertService = AlertService();
  List<DriverAlert> _alerts = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadAlerts();
  }

  Future<void> _loadAlerts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final alerts = await _alertService.fetchAlerts();
      setState(() {
        _alerts = alerts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteAlert(String alertId) async {
    try {
      await _alertService.deleteAlert(alertId);
      _loadAlerts();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur : ${e.toString()}"),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  Future<void> _toggleAlert(DriverAlert alert) async {
    try {
      await _alertService.toggleAlert(alert.id, !alert.isActive);
      _loadAlerts();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur : ${e.toString()}"),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes alertes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAlerts,
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AlertFormScreen()),
          );
          if (result == true) {
            _loadAlerts();
          }
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingIndicator(message: "Chargement des alertes...");
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline,
                size: 64, color: AppTheme.errorColor),
            const SizedBox(height: 16),
            Text("Erreur", style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppTheme.textSecondary),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadAlerts,
              child: const Text("Réessayer"),
            ),
          ],
        ),
      );
    }

    if (_alerts.isEmpty) {
      return const Center(
        child: Text("Aucune alerte enregistrée"),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadAlerts,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _alerts.length,
        itemBuilder: (context, index) {
          final alert = _alerts[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(
                "${alert.departureCity ?? '-'} → ${alert.arrivalCity ?? '-'}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Rayon départ: ${alert.departureRadius ?? 0} km | "
                "Rayon arrivée: ${alert.arrivalRadius ?? 0} km\n"
                "Retour inclus: ${alert.includeReturnTrip ? "Oui" : "Non"}",
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Switch(
                    value: alert.isActive,
                    onChanged: (_) => _toggleAlert(alert),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: AppTheme.errorColor),
                    onPressed: () => _deleteAlert(alert.id),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
