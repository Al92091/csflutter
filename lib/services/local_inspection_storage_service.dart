import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Service permettant de sauvegarder, charger et effacer une inspection
/// en cours localement. Chaque brouillon est stocké par mission_id.
class LocalInspectionStorageService {
  static const String _prefix = "draft_inspection_";

  /// Sauvegarde un état des lieux en cours
  /// [missionId] : identifiant de la mission
  /// [data] : Map<String,dynamic> contenant l'état du formulaire
  static Future<void> saveDraftInspection(
      String missionId, Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(data);
      await prefs.setString("$_prefix$missionId", jsonString);
    } catch (e) {
      print("Erreur sauvegarde EDL local : $e");
    }
  }

  /// Charge un brouillon d'état des lieux
  /// Retourne `null` si rien n'existe
  static Future<Map<String, dynamic>?> loadDraftInspection(
      String missionId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString("$_prefix$missionId");

      if (jsonString == null) return null;

      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      print("Erreur chargement EDL local : $e");
      return null;
    }
  }

  /// Supprime un brouillon existant
  static Future<void> deleteDraftInspection(String missionId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("$_prefix$missionId");
    } catch (e) {
      print("Erreur suppression EDL local : $e");
    }
  }

  /// Vérifie si un brouillon existe déjà
  static Future<bool> draftExists(String missionId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("$_prefix$missionId");
  }
}