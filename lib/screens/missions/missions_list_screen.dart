import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../../models/mission.dart';
import '../../services/mission_service.dart';
import '../../widgets/mission_card.dart';
import '../../widgets/loading_indicator.dart';
import 'mission_detail_screen.dart';

class MissionsListScreen extends StatefulWidget {
  const MissionsListScreen({super.key});

  @override
  State<MissionsListScreen> createState() => _MissionsListScreenState();
}

/// Représente soit un groupe, soit une mission seule
class _MissionGroup {
  final Mission representative;    // mission affichée dans la carte
  final int count;                 // Xn
  final List<Mission> missions;    // toutes les missions du groupe

  _MissionGroup({
    required this.representative,
    required this.count,
    required this.missions,
  });
}

class _MissionsListScreenState extends State<MissionsListScreen> {
  final MissionService _missionService = MissionService();

  List<Mission> _missions = [];
  List<_MissionGroup> _groups = [];

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMissions();
  }

  Future<void> _loadMissions() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final missions = await _missionService.fetchAvailableMissions();
      final groups = _groupMissions(missions);

      setState(() {
        _missions = missions;
        _groups = groups;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  /// Calqué sur la logique Lovable (site) :
  ///
  /// - Si `is_group_order` = true
  /// - et `group_order_id` non nul
  /// - et `group_order_type == 'same_vehicles_same_dest'`
  ///   -> on regroupe les missions ayant le même group_order_id
  ///
  /// Sinon, mission individuelle.
  List<_MissionGroup> _groupMissions(List<Mission> missions) {
    final Map<String, List<Mission>> buckets = {};
    final List<Mission> individuals = [];

    for (final mission in missions) {
      final isSameVehicleSameDest =
          mission.isGroupOrder &&
          mission.groupOrderId != null &&
          mission.groupOrderType == 'same_vehicles_same_dest';

      if (isSameVehicleSameDest) {
        final key = mission.groupOrderId!;
        buckets.putIfAbsent(key, () => []).add(mission);
      } else {
        individuals.add(mission);
      }
    }

    final List<_MissionGroup> result = [];

    // Groupes SameVehicleSameDest
    buckets.forEach((groupId, list) {
      if (list.isEmpty) return;

      // on peut trier par deadline ou pickup
      list.sort((a, b) {
        final ad = a.deliveryDeadline ?? a.pickupDatetime ?? a.createdAt;
        final bd = b.deliveryDeadline ?? b.pickupDatetime ?? b.createdAt;
        return ad.compareTo(bd);
      });

      result.add(
        _MissionGroup(
          representative: list.first,
          count: list.length,
          missions: list,
        ),
      );
    });

    // Missions individuelles
    for (final m in individuals) {
      result.add(
        _MissionGroup(
          representative: m,
          count: 1,
          missions: [m],
        ),
      );
    }

    // Tri global : comme la requête, par delivery_deadline puis pickup
    result.sort((a, b) {
      final ad = a.representative.deliveryDeadline ??
          a.representative.pickupDatetime ??
          a.representative.createdAt;
      final bd = b.representative.deliveryDeadline ??
          b.representative.pickupDatetime ??
          b.representative.createdAt;
      return ad.compareTo(bd);
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Missions disponibles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadMissions,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingIndicator(message: 'Chargement des missions...');
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppTheme.errorColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Erreur',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
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
              onPressed: _loadMissions,
              child: const Text('Réessayer'),
            ),
          ],
        ),
      );
    }

    if (_groups.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: AppTheme.textHint,
            ),
            const SizedBox(height: 16),
            Text(
              'Aucune mission disponible',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Les nouvelles missions apparaîtront ici',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadMissions,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _groups.length,
        itemBuilder: (context, index) {
          final group = _groups[index];
          final mission = group.representative;

          return MissionCard(
            mission: mission,
            // 🔥 c’est ici qu’on passe le nombre pour le badge Xn
            remainingCount: group.count,
            onTap: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (_) => MissionDetailScreen(
                    missionId: mission.id,
                    isAvailable: true,
                  ),
                ),
              )
                  .then((_) => _loadMissions());
            },
          );
        },
      ),
    );
  }
}
