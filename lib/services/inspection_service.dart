import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/constants.dart';
import '../models/inspection_report.dart';
import 'supabase_service.dart';

class InspectionService {
  final SupabaseClient _client = SupabaseService.client;

  /// 🔐 S’assure que l’utilisateur a une session valide (refresh forcé si nécessaire)
  Future<void> _ensureAuthenticated() async {
    var session = _client.auth.currentSession;

    // Si pas de session → tentative de refresh
    if (session == null) {
      final res = await _client.auth.refreshSession();
      session = res.session;
    } else {
      // 🔄 refresh systématique pour éviter expiration pendant upload long
      final res = await _client.auth.refreshSession();
      session = res.session;
    }

    if (session == null) {
      throw Exception('Utilisateur non authentifié, veuillez vous reconnecter');
    }
  }

  /// 📤 Upload photo vers Supabase Storage
  Future<String> uploadPhoto(
      File photoFile, String folder, String fileName) async {
    await _ensureAuthenticated();

    final userId = SupabaseService.currentUserId;
    if (userId == null) throw Exception('Utilisateur non authentifié');

    final path = '$folder/$userId/$fileName';

    try {
      // ✅ upload avec remplacement si déjà existant
      await _client.storage
          .from('inspection_photos')
          .upload(path, photoFile, fileOptions: const FileOptions(upsert: true));
    } catch (e) {
      throw Exception("Erreur upload Supabase: $e");
    }

    // ✅ récupérer URL publique
    final publicUrl =
        _client.storage.from('inspection_photos').getPublicUrl(path);

    return publicUrl;
  }

  /// 📤 Upload plusieurs photos en parallèle (plus rapide & fiable)
  Future<List<Map<String, dynamic>>> uploadPhotosBatch(
    List<Map<String, dynamic>> photos,
    String folder,
    String prefix,
  ) async {
    await _ensureAuthenticated();

    final tasks = photos.map((photo) async {
      final url = await uploadPhoto(
        File(photo['path']),
        folder,
        "$prefix${photo['order']}.jpg", // ✅ interpolation correcte
      );
      return {
        'order': photo['order'],
        'label': photo['label'],
        'path': url,
      };
    }).toList();

    return await Future.wait(tasks);
  }

  /// 📡 Envoi du rapport d’inspection via Edge Function
  Future<Map<String, dynamic>> submitInspectionReport(
    InspectionReport report,
  ) async {
    // 🔐 Toujours s'assurer que le token est frais
    await _ensureAuthenticated();

    final session = _client.auth.currentSession;
    if (session == null) throw Exception("Pas de session utilisateur");

    final token = session.accessToken;
    if (token.isEmpty) throw Exception("Pas de jeton d'authentification");

    final response = await http.post(
      Uri.parse(AppConstants.submitInspectionEndpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // ✅ token frais
      },
      body: jsonEncode(report.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Échec envoi inspection: ${response.body}");
    }

    return jsonDecode(response.body);
  }

  /// 📋 Liste des photos obligatoires pour un EDL de départ
  List<Map<String, dynamic>> getDeparturePhotoRequirements() {
    return [
      // 🔹 EXTERIEUR
      {'order': 1, 'label': 'Latéral Avant Gauche', 'category': 'exterior'},
      {'order': 2, 'label': 'Latéral Arrière Gauche', 'category': 'exterior'},
      // 3 : ancienne "Vue 3/4 arrière gauche" → legacy, non utilisée dans les nouveaux flux
      {'order': 4, 'label': 'Face arrière', 'category': 'exterior'},
      {'order': 5, 'label': 'Latéral Avant Droit', 'category': 'exterior'},
      {'order': 6, 'label': 'Latéral Arrière Droit', 'category': 'exterior'},
      {'order': 7, 'label': 'Coque rétroviseur Droit', 'category': 'exterior'},
      {'order': 8, 'label': 'Face avant', 'category': 'exterior'},
      {'order': 9, 'label': 'Pare brise', 'category': 'exterior'},
      {'order': 10, 'label': 'Coque rétroviseur gauche', 'category': 'exterior'},

      // 🔹 ROUES
      {'order': 11, 'label': 'Roue avant gauche', 'category': 'wheels'},
      {'order': 12, 'label': 'Roue arrière gauche', 'category': 'wheels'},
      {'order': 13, 'label': 'Roue arrière droite', 'category': 'wheels'},
      {'order': 14, 'label': 'Roue avant droite', 'category': 'wheels'},
      {'order': 15, 'label': 'Toit', 'category': 'wheels'},

      // 🔹 INTERIEUR
      {'order': 16, 'label': 'Tableau de bord complet', 'category': 'interior'},
      {'order': 17, 'label': 'Sièges avant', 'category': 'interior'},
      {'order': 18, 'label': 'Sièges arrière', 'category': 'interior'},
      // 19 : "Coffre vide" → legacy, non utilisée dans les nouveaux flux
      {'order': 20, 'label': 'Coffre ouvert', 'category': 'interior'},

      // 🔹 ACCESSOIRES / ADDITIONAL
      {'order': 21, 'label': 'Clés du véhicule', 'category': 'additional'},
      {
        'order': 22,
        'label': 'Roue de secours ou kit de gonflage',
        'category': 'additional',
      },
      {'order': 23, 'label': 'Kit de sécurité', 'category': 'additional'},

      // 🔹 Véhicule électrique → optionnel
      {
        'order': 24,
        'label': 'Kit de recharge',
        'category': 'additional',
        'required': false,
      },
    ];
  }

  // ---------------------------------------------------------------------------
  // 🆕 RÉCUPÉRATION D'UN RAPPORT D'INSPECTION POUR UNE MISSION + TYPE
  // ---------------------------------------------------------------------------

  /// Récupère le dernier rapport d'inspection pour une mission donnée
  /// et un type d'EDL donné (ex: AppConstants.inspectionDeparture / Arrival).
  ///
  /// Retourne `null` si aucun rapport trouvé.
  Future<InspectionReport?> getInspectionReportForMission(
    String missionId,
    String inspectionType,
  ) async {
    await _ensureAuthenticated();

    try {
      final data = await _client
          .from('inspection_reports') // ✅ bon nom de table
          .select()
          .eq('mission_id', missionId)
          .eq('inspection_type', inspectionType)
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();

      if (data == null) {
        return null;
      }

      // ⚠️ La table inspection_reports ne contient pas driver_id ni les URLs de photos.
      // On construit donc un InspectionReport "minimal" avec seulement les champs utiles
      // pour le bloc Kilométrage & Carburant.
      final currentDriverId = SupabaseService.currentUserId ?? '';

      return InspectionReport(
        missionId: data['mission_id'] as String,
        driverId: currentDriverId,
        inspectionType: data['inspection_type'] as String,

        // Contact
        contactFirstName: data['contact_first_name'] as String?,
        contactLastName: data['contact_last_name'] as String?,
        contactPhone: data['contact_phone'] as String?,

        // Véhicule
        mileage: data['vehicle_mileage'] as int?,
        fuelLevel: data['vehicle_fuel_level'] as int?,
        dashboardPhoto: null, // pas stocké dans cette table

        // Photos (jsonb)
        photos: (data['photos'] as List?)
                ?.map((e) => Map<String, dynamic>.from(e as Map))
                .toList() ??
            [],

        // Signatures / photos globales (non présentes dans cette table)
        driverPhoto: null,
        driverSignature: null,
        contactSignature: null,
        etatDesLieuxPhoto: null,

        // Localisation
        latitude: (data['latitude'] as num?)?.toDouble(),
        longitude: (data['longitude'] as num?)?.toDouble(),

        // Dépenses carburant / péage (noms conformes au SQL)
        fuelExpense: (data['fuel_expense_amount'] as num?)?.toDouble(),
        fuelExpensePhoto: data['fuel_expense_image_url'] as String?,
        tollExpense: (data['toll_expense_amount'] as num?)?.toDouble(),
        tollExpensePhoto: data['toll_expense_image_url'] as String?,
      );
    } on PostgrestException catch (e) {
      throw Exception('Erreur Supabase (inspection_reports): ${e.message}');
    } catch (e) {
      throw Exception('Erreur récupération rapport inspection: $e');
    }
  }
}
