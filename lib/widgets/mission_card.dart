// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../config/theme.dart';
import '../models/mission.dart';
import '../utils/formatters.dart';
// ✅ import du calculateur de prix
import 'package:carswift_driver/services/driver_price_calculator.dart';

class MissionCard extends StatelessWidget {
  final Mission mission;
  final VoidCallback onTap;
  final bool showStatus;

  /// nouveau : nombre de missions dans le groupe (pour le badge xN)
  final int? remainingCount;

  const MissionCard({
    super.key,
    required this.mission,
    required this.onTap,
    this.showStatus = false,
    this.remainingCount,
  });

  // -------- Helpers prix (arrondi "site") --------

  int _roundSite(double value) {
    final euros = value.floor();
    final cents = ((value * 100).floor()) % 100;
    return (cents >= 51) ? (euros + 1) : euros;
  }

  String _formatEuroInt(num value) => '${value.toInt()}€';

  Color _getStatusColor() {
    switch (mission.missionStatusDriver) {
      case 'mission_acceptee':
        return AppTheme.warningColor;
      case 'en_coursdriver':
        return AppTheme.secondaryColor;
      case 'termineedriver':
        return AppTheme.warningColor;
      case 'clotureedriver':
        return AppTheme.successColor;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getStatusLabel() {
    switch (mission.missionStatusDriver) {
      case 'mission_acceptee':
        return 'À venir';
      case 'en_coursdriver':
        return 'En cours';
      case 'termineedriver':
        return 'À clôturer';
      case 'clotureedriver':
        return 'Clôturée';
      default:
        return 'Disponible';
    }
  }

  /// ✅ Logo client
  Widget? _buildCustomerLogo() {
    final url = mission.companyLogoUrl;
    if (url != null && url.isNotEmpty) {
      return Image.network(
        url,
        height: 30,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.business, size: 24, color: Colors.grey);
        },
      );
    }
    return null;
  }

  /// ✅ Prix missions disponibles (calculé dynamiquement + arrondi "site")
  Widget _buildCalculatedPrice() {
    final calculator = DriverPriceCalculator();

    final options = {
      'document_management': mission.documentManagement ?? false,
      'basic_handover': mission.basicHandover ?? false,
      'comfort_handover': mission.comfortHandover ?? false,
      'basic_washing': mission.basicWashing ?? false,
      'standard_washing': mission.standardWashing ?? false,
      'premium_washing': mission.premiumWashing ?? false,
      'w_garage': mission.wGarage ?? false,
      'electric_vehicle': mission.electricVehicle ?? false,
    };

    final isReturn = (mission.isReturnMission ?? false) ||
        (mission.missionType == 'livraison_reprise');

    return FutureBuilder(
      future: () async {
        final driverStatus =
            await calculator.getCurrentDriverStatus() ?? 'active_beginner';
        final distance = mission.distanceMission ?? 0.0;

        final rawPrice = await calculator.calculateFinalDriverPrice(
          distanceKm: distance,
          driverStatus: driverStatus,
          options: options,
          isReturnMission: isReturn,
        );

        final rounded = _roundSite(rawPrice);
        return _formatEuroInt(rounded);
      }(),
      builder: (context, snap) {
        final txt =
            snap.connectionState == ConnectionState.done && snap.hasData
                ? snap.data!
                : '...';

        return Text(
          txt,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
        );
      },
    );
  }

  /// ✅ Prix missions réservées (BDD)
  Widget _buildReservedPrice() {
    final price = mission.reservedDriverPrice ?? 0.0;
    final rounded = _roundSite(price);

    return Text(
      _formatEuroInt(rounded),
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.pink,
      ),
    );
  }

  /// ✅ Options mission → icônes
  List<Widget> _buildOptions() {
    final blue = const Color(0xFF2D59A2);
    final opts = <Widget>[];

    if (mission.wGarage == true) {
      opts.add(
        Text(
          "W",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: blue,
          ),
        ),
      );
    }

    if (mission.basicHandover == true || mission.comfortHandover == true) {
      opts.add(Icon(LucideIcons.handshake, size: 18, color: blue));
    }

    if (mission.basicWashing == true ||
        mission.standardWashing == true ||
        mission.premiumWashing == true) {
      opts.add(Icon(LucideIcons.droplet, size: 18, color: blue));
    }

    // ✅ Carburant : seulement si fuel_same_level OU plein
    if (mission.fuelManagement == "remise_niveau" ||
        mission.fuelManagement == "plein") {
      opts.add(Icon(LucideIcons.fuel, size: 18, color: blue));
    }

    if (mission.documentManagement == true) {
      opts.add(Icon(LucideIcons.fileText, size: 18, color: blue));
    }

    // ✅ Nouveau : icône véhicule électrique
    if (mission.electricVehicle == true) {
      opts.add(Icon(LucideIcons.zap, size: 18, color: blue));
    }

    return opts
        .map(
          (w) => Padding(
            padding: const EdgeInsets.only(left: 8),
            child: w,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final blue = const Color(0xFF2D59A2);
    // ✅ Afficher le badge seulement si on a plus d’1 mission dans le groupe
    final bool showCount = (remainingCount ?? 0) > 1;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (showStatus) ...[
                    _buildReservedPrice(),
                    Center(child: _buildCustomerLogo() ?? const SizedBox()),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _getStatusLabel(),
                        style: TextStyle(
                          color: _getStatusColor(),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ] else ...[
                    Center(child: _buildCustomerLogo() ?? const SizedBox()),
                    _buildCalculatedPrice(),
                  ],
                ],
              ),

              const SizedBox(height: 8),

              /// Missions disponibles : "Du JJ/MM au JJ/MM"
              if (!showStatus &&
                  mission.availabilityStart != null &&
                  mission.deliveryDeadline != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: blue),
                    const SizedBox(width: 4),
                    Text(
                      "Du ${Formatters.formatDay(mission.availabilityStart)} au ${Formatters.formatDay(mission.deliveryDeadline)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

              /// Mes missions : JJ/MM HH:mm
              if (showStatus && mission.pickupDatetime != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: blue),
                    const SizedBox(width: 4),
                    Text(
                      Formatters.formatShortDateTime(mission.pickupDatetime),
                      style: TextStyle(
                        fontSize: 12,
                        color: blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 12),

              /// Departure
              Row(
                children: [
                  Icon(Icons.circle,
                      size: 12, color: AppTheme.successColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      Formatters.truncateAddress(mission.displayDeparture),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              /// Arrival
              Row(
                children: [
                  Icon(Icons.location_on,
                      size: 12, color: AppTheme.errorColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      Formatters.truncateAddress(mission.displayArrival),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),

              /// Image véhicule + badge xN
              if (mission.vehicleImageUrl != null &&
                  mission.vehicleImageUrl!.isNotEmpty) ...[
                const SizedBox(height: 12),
                SizedBox(
                  height: 100,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Center(
                        child: Image.network(
                          mission.vehicleImageUrl!,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                      if (showCount)
                        Positioned(
                          top: -6,
                          right: -6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE61B7F),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              'x${remainingCount!}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],

              const Divider(height: 24),

              /// Bas de carte : temps + distance (gauche) | options (droite)
              Row(
                children: [
                  Row(
                    children: [
                      Icon(LucideIcons.clock, size: 16, color: blue),
                      const SizedBox(width: 4),
                      Text(
                        Formatters.formatTravelTime(
                          int.tryParse(mission.estimatedTravelTime ?? ''),
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          color: blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      Icon(LucideIcons.route, size: 16, color: blue),
                      const SizedBox(width: 4),
                      Text(
                        Formatters.formatDistanceInt(mission.distanceMission),
                        style: TextStyle(
                          fontSize: 12,
                          color: blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(children: _buildOptions()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
