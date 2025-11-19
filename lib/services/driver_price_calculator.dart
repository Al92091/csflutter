import 'package:supabase_flutter/supabase_flutter.dart';

class DriverPriceCalculator {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Caches pour éviter de recharger tout le temps
  Map<String, dynamic>? _coefficientsCache;
  Map<String, double>? _commissionsCache;
  double? _returnDiscountCache;

  /// 🔑 Récupère le driver_status du chauffeur connecté
  Future<String?> getCurrentDriverStatus() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    final profile = await _supabase
        .from('profiles')
        .select('driver_status')
        .eq('id', user.id)
        .maybeSingle();

    return profile?['driver_status']?.toString();
  }

  /// 🎯 Calcule le prix final pour un chauffeur
  Future<double> calculateFinalDriverPrice({
    required double distanceKm,
    required String driverStatus,
    required Map<String, bool> options,
    bool isReturnMission = false,
  }) async {
    // 1. Prix de base
    final basePrice = await _calculateBasePrice(distanceKm, driverStatus);

    // 2. Commissions liées aux options
    final optionsCommission =
        await _calculateOptionsCommission(options, distanceKm);

    // 3. Prix avant remise
    double finalPrice = basePrice + optionsCommission;

    // 4. Réduction retour
    if (isReturnMission) {
      finalPrice = await _applyReturnDiscount(finalPrice);
    }

    // 5. Arrondi
    return (finalPrice * 100).roundToDouble() / 100;
  }

  /// 💰 Calcule le prix de base avec les coefficients quadratiques
  Future<double> _calculateBasePrice(
      double distance, String driverStatus) async {
    _coefficientsCache ??= await _fetchCoefficients();

    final coefficientA = (_coefficientsCache!['coefficient_a'] as num).toDouble();
    double coefficientB;
    double coefficientC;

    switch (driverStatus) {
      case 'active_beginner':
        coefficientB =
            (_coefficientsCache!['coefficient_b_beginner'] as num).toDouble();
        coefficientC =
            (_coefficientsCache!['coefficient_c_beginner'] as num).toDouble();
        break;
      case 'active_intermediate':
        coefficientB =
            (_coefficientsCache!['coefficient_b_intermediate'] as num).toDouble();
        coefficientC =
            (_coefficientsCache!['coefficient_c_intermediate'] as num).toDouble();
        break;
      case 'active_expert':
        coefficientB =
            (_coefficientsCache!['coefficient_b_expert'] as num).toDouble();
        coefficientC =
            (_coefficientsCache!['coefficient_c_expert'] as num).toDouble();
        break;
      case 'active_elite':
        coefficientB =
            (_coefficientsCache!['coefficient_b_elite'] as num).toDouble();
        coefficientC =
            (_coefficientsCache!['coefficient_c_elite'] as num).toDouble();
        break;
      default:
        return 0.0;
    }

    final price =
        coefficientA * (distance * distance) + coefficientB * distance + coefficientC;

    return price < 0 ? 0.0 : (price * 100).roundToDouble() / 100;
  }

  /// 🔄 Charge les coefficients de pricing
  Future<Map<String, dynamic>> _fetchCoefficients() async {
    final response = await _supabase
        .from('driver_pricing_coefficients')
        .select()
        .eq('id', 1)
        .single();

    return response;
  }

  /// 💸 Calcule la commission liée aux options
  Future<double> _calculateOptionsCommission(
      Map<String, bool> options, double distance) async {
    _commissionsCache ??= await _fetchCommissions();

    double total = 0.0;

    if (options['document_management'] == true) {
      total += _commissionsCache!['document_management'] ?? 0.0;
    }
    if (options['basic_handover'] == true) {
      total += _commissionsCache!['basic_handover'] ?? 0.0;
    }
    if (options['comfort_handover'] == true) {
      total += _commissionsCache!['comfort_handover'] ?? 0.0;
    }
    if (options['basic_washing'] == true) {
      total += _commissionsCache!['basic_washing'] ?? 0.0;
    }
    if (options['standard_washing'] == true) {
      total += _commissionsCache!['standard_washing'] ?? 0.0;
    }
    if (options['premium_washing'] == true) {
      total += _commissionsCache!['premium_washing'] ?? 0.0;
    }
    if (options['w_garage'] == true) {
      total += _commissionsCache!['w_garage'] ?? 0.0;
    }
    if (options['electric_vehicle'] == true) {
      final electricCommission =
          _commissionsCache!['electric_vehicle'] ?? 0.0;
      total += electricCommission * distance; // par km
    }

    return total;
  }

  /// 🔄 Charge les commissions depuis mission_options
  Future<Map<String, double>> _fetchCommissions() async {
    final response =
        await _supabase.from('mission_options').select('code, driver_commission');

    return Map.fromIterable(
      response as List,
      key: (item) => item['code'] as String,
      value: (item) => (item['driver_commission'] as num).toDouble(),
    );
  }

  /// 🔙 Applique la réduction pour les missions retour
  Future<double> _applyReturnDiscount(double price) async {
    _returnDiscountCache ??= await _fetchReturnDiscount();

    final discount = price * (_returnDiscountCache! / 100);
    return price - discount;
  }

  /// 🔄 Charge la réduction retour depuis return_mission_pricing_config
  Future<double> _fetchReturnDiscount() async {
    final response = await _supabase
        .from('return_mission_pricing_config')
        .select('discount_percentage')
        .eq('id', 1)
        .single();

    return (response['discount_percentage'] as num).toDouble();
  }
}
