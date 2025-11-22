import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/constants.dart';
import 'supabase_service.dart';

class PickupSlot {
  final DateTime pickupDatetime; // en local (Europe/Paris)

  PickupSlot(this.pickupDatetime);
}

class DeliverySlot {
  final DateTime deliveryDatetime; // en local (Europe/Paris)
  final bool isSameDay;

  DeliverySlot({
    required this.deliveryDatetime,
    required this.isSameDay,
  });
}

class ValidationResult {
  final bool isValid;
  final String? errorCode;
  final String? errorMessage;

  ValidationResult({
    required this.isValid,
    this.errorCode,
    this.errorMessage,
  });
}

class MissionReservationService {
  final SupabaseClient _client = SupabaseService.client;

  /// Récupère les créneaux de pickup disponibles pour une mission
  Future<List<PickupSlot>> getAvailablePickupSlots({
    required String missionId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    // On envoie seulement la partie date au format YYYY-MM-DD
    final dateFormatter = DateFormat('yyyy-MM-dd');

    final response = await _client.rpc(
      'get_available_pickup_slots',
      params: {
        'p_mission_id': missionId,
        'p_start_date': dateFormatter.format(startDate),
        'p_end_date': dateFormatter.format(endDate),
      },
    );

    if (response == null) return [];

    final list = response as List;

    return list.map((raw) {
      final rawStr = raw['pickup_datetime'].toString();
      final utc = DateTime.parse(rawStr); // valeur en UTC
      final local = utc.toLocal(); // convertie en Europe/Paris (configurée dans main.dart)
      return PickupSlot(local);
    }).toList();
  }

  /// Récupère les créneaux de delivery possibles pour un pickup donné
  Future<List<DeliverySlot>> getAvailableDeliverySlots({
    required String missionId,
    required DateTime pickupDatetimeLocal,
  }) async {
    // On renvoie en UTC vers le backend
    final utcPickup = pickupDatetimeLocal.toUtc();

    final response = await _client.rpc(
      'get_available_delivery_slots',
      params: {
        'p_mission_id': missionId,
        'p_pickup_datetime': utcPickup.toIso8601String(),
      },
    );

    if (response == null) return [];

    final list = response as List;

    return list.map((raw) {
      final rawStr = raw['delivery_datetime'].toString();
      final utc = DateTime.parse(rawStr);
      final local = utc.toLocal();
      final isSameDay = raw['is_same_day'] == true;
      return DeliverySlot(
        deliveryDatetime: local,
        isSameDay: isSameDay,
      );
    }).toList();
  }

  /// Valide une combinaison pickup/delivery côté backend
  Future<ValidationResult> validateReservationTimes({
    required String missionId,
    required DateTime pickupDatetimeLocal,
    required DateTime deliveryDatetimeLocal,
  }) async {
    final utcPickup = pickupDatetimeLocal.toUtc();
    final utcDelivery = deliveryDatetimeLocal.toUtc();

    final response = await _client.rpc(
      'validate_reservation_times',
      params: {
        'p_mission_id': missionId,
        'p_pickup_datetime': utcPickup.toIso8601String(),
        'p_delivery_datetime': utcDelivery.toIso8601String(),
      },
    );

    if (response == null || (response as List).isEmpty) {
      // Si jamais le RPC renvoie quelque chose de vide, on considère valide
      return ValidationResult(isValid: true);
    }

    final Map raw = (response as List).first as Map;

    final bool isValid = raw['is_valid'] == true;
    final String? errorCode = raw['error_code']?.toString();
    final String? errorMessage = raw['error_message']?.toString();

    return ValidationResult(
      isValid: isValid,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }

  /// Réserve définitivement la mission (avec prix, driver_id, horaires…)
  Future<void> reserveMission({
    required String missionId,
    required DateTime pickupDatetimeLocal,
    required DateTime deliveryDatetimeLocal,
    required double reservedDriverPrice,
  }) async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) {
      throw Exception('Utilisateur non authentifié');
    }

    final utcPickup = pickupDatetimeLocal.toUtc();
    final utcDelivery = deliveryDatetimeLocal.toUtc();

    final response = await _client
        .from('missions')
        .update({
          'driver_id': userId,
          'status': AppConstants.statusAcceptee,
          'missionstatusdriver': AppConstants.missionAcceptee,
          'pickup_datetime': utcPickup.toIso8601String(),
          'delivery_datetime': utcDelivery.toIso8601String(),
          'reserved_driver_price': reservedDriverPrice,
        })
        .eq('id', missionId)
       .eq('id', missionId)
      .select();

  // Optionnel : garder ce check pour détecter un cas très bizarre
  if (response == null || (response as List).isEmpty) {
    throw Exception("Impossible de mettre à jour la mission.");
  }
}
}
