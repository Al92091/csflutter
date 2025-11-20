import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/constants.dart';
import '../models/mission.dart';
import 'supabase_service.dart';
import 'driver_price_calculator.dart';

class MissionService {
  final SupabaseClient _client = SupabaseService.client;

  /// 🔹 Récupérer les missions disponibles (pas encore réservées)
  Future<List<Mission>> fetchAvailableMissions() async {
final response = await _client
    .from('missions')
    .select('''
      *,
      group_orders(
        id,
        group_order_type,
        status
      ),
      vehicle_models(image_url),
      customer_profile:profiles!missions_customer_id_fkey(company_logo_url)
    ''')
    .eq('status', AppConstants.statusRechercheDriver)
    .order('pickup_datetime', ascending: true);

return (response as List).map((json) {
  return Mission.fromJson({
    ...json,
    'vehicle_image_url': json['vehicle_models']?['image_url'],
    'company_logo_url': json['customer_profile']?['company_logo_url'],
    'distance_mission': json['distance_mission'],
    'reserved_driver_price': json['reserved_driver_price'],

    // 🔥 flatten du type du group order
    'group_order_type': json['group_orders']?['group_order_type'],
  });
}).toList();
  }

  /// 🔹 Récupérer les missions du driver connecté
  Future<List<Mission>> fetchMyMissions() async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) throw Exception('User not authenticated');

    final response = await _client
        .from('missions')
        .select('*, vehicle_models(image_url), customer_profile:profiles!missions_customer_id_fkey(company_logo_url)')
        .eq('driver_id', userId)
        .order('pickup_datetime', ascending: true);

    return (response as List).map((json) {
      return Mission.fromJson({
        ...json,
        'vehicle_image_url': json['vehicle_models']?['image_url'],
        'company_logo_url': json['customer_profile']?['company_logo_url'],
        'distance_mission': json['distance_mission'],
        'reserved_driver_price': json['reserved_driver_price'], // ✅ prix réservé
      });
    }).toList();
  }

  /// 🔹 Réserver une mission et enregistrer le `reserved_driver_price`
  Future<void> bookMission(String missionId, double reservedPrice) async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) throw Exception('User not authenticated');

    await _client.from('missions').update({
      'driver_id': userId,
      'status': AppConstants.statusAcceptee,
      'missionstatusdriver': AppConstants.missionAcceptee,
      'reserved_driver_price': reservedPrice, // ✅ prix figé en base
    }).eq('id', missionId);
  }

  /// 🔹 Récupérer une mission par ID
  Future<Mission> getMissionById(String missionId) async {
    final response = await _client
        .from('missions')
        .select('*, vehicle_models(image_url), customer_profile:profiles!missions_customer_id_fkey(company_logo_url)')
        .eq('id', missionId)
        .single();

    return Mission.fromJson({
      ...response,
      'vehicle_image_url': response['vehicle_models']?['image_url'],
      'company_logo_url': response['customer_profile']?['company_logo_url'],
      'distance_mission': response['distance_mission'],
      'reserved_driver_price': response['reserved_driver_price'], // ✅ ajouté
    });
  }

  /// 🔹 Mettre à jour le statut d'une mission (inspection, clôture, etc.)
  Future<void> updateMissionStatus(
    String missionId,
    String status,
    String missionStatusDriver,
  ) async {
    await _client.from('missions').update({
      'status': status,
      'missionstatusdriver': missionStatusDriver,
    }).eq('id', missionId);
  }

  /// 🔹 Catégoriser les missions (Mes Missions)
  Map<String, List<Mission>> categorizeMissions(List<Mission> missions) {
    final now = DateTime.now();

    final toClose = missions
        .where((m) => m.missionStatusDriver == AppConstants.termineeDriver)
        .toList();

    final inProgress = missions
        .where((m) => m.missionStatusDriver == AppConstants.enCoursDriver)
        .toList();

    final upcoming = missions
        .where((m) =>
            m.missionStatusDriver == AppConstants.missionAcceptee &&
            m.pickupDatetime != null &&
            m.pickupDatetime!.isAfter(now))
        .toList();

    final history = missions
        .where((m) => m.missionStatusDriver == AppConstants.clotureeDriver)
        .toList();

    return {
      'toClose': toClose,
      'inProgress': inProgress,
      'upcoming': upcoming,
      'history': history,
    };
  }
}
