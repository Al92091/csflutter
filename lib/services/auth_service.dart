import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/constants.dart';
import 'supabase_service.dart';

class AuthService {
  final SupabaseClient _client = SupabaseService.client;

  Future<AuthResponse> signIn(String email, String password) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    
    // Verify driver status
    if (response.user != null) {
      final profile = await _client
          .from('profiles')
          .select('driver_status')
          .eq('id', response.user!.id)
          .single();
      
      final driverStatus = profile['driver_status'] as String?;
      
      if (driverStatus == null || 
          !AppConstants.activeDriverStatuses.contains(driverStatus)) {
        await _client.auth.signOut();
        throw Exception('Accès refusé. Seuls les convoyeurs actifs peuvent se connecter.');
      }
    }
    
    return response;
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<Map<String, dynamic>> getCurrentProfile() async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) throw Exception('User not authenticated');
    
    final profile = await _client
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    
    return profile;
  }

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;
}
