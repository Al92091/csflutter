import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/alert.dart';

class AlertService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Récupère toutes les alertes du driver connecté
  Future<List<DriverAlert>> fetchAlerts() async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      throw Exception("Utilisateur non connecté");
    }

    final response = await _supabase
        .from('driver_alerts')
        .select()
        .eq('driver_id', user.id)
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .map((json) => DriverAlert.fromJson(json))
        .toList();
  }

  /// Crée une nouvelle alerte
  Future<void> createAlert({
    String? departureCity,
    required int departureRadius,
    String? arrivalCity,
    required int arrivalRadius,
    required bool includeReturnTrip,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      throw Exception("Utilisateur non connecté");
    }

    await _supabase.from('driver_alerts').insert({
      'driver_id': user.id,
      'departure_city': departureCity,
      'departure_radius': departureRadius,
      'arrival_city': arrivalCity,
      'arrival_radius': arrivalRadius,
      'include_return_trip': includeReturnTrip,
    });
  }

  /// Supprime une alerte
  Future<void> deleteAlert(String alertId) async {
    await _supabase.from('driver_alerts').delete().eq('id', alertId);
  }

  /// Active / désactive une alerte
  Future<void> toggleAlert(String alertId, bool isActive) async {
    await _supabase.from('driver_alerts').update({
      'is_active': isActive,
    }).eq('id', alertId);
  }
}
