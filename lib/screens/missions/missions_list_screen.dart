import 'package:flutter/material.dart';

import '../../config/theme.dart';
import '../../models/mission.dart';
import '../../models/mission_restriction.dart';
import '../../services/mission_service.dart';
import '../../services/supabase_service.dart';
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
  final Mission representative; // mission affichée dans la carte
  final int count; // Xn
  final List<Mission> missions; // toutes les missions du groupe

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

  /// Map des certifications validées du driver
  /// clés : client_handover, LAVAGE, electric_vehicle, document_management
  Map<String, bool> _certMap = {
    'client_handover': false,
    'LAVAGE': false,
    'electric_vehicle': false,
    'document_management': false,
  };

  /// Le driver possède-t-il une plaque W-Garage ?
  bool _hasWGarage = false;

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
      // 1) Charger les infos du driver (w_garage + certifs)
      await _loadDriverRestrictions();

      // 2) Charger les missions disponibles
      final missions = await _missionService.fetchAvailableMissions();

      // 3) Appliquer la logique de regroupement SameVehicleSameDest
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

  /// Charge w_garage + certifications validées du driver connecté
  Future<void> _loadDriverRestrictions() async {
    final client = SupabaseService.client;
    final userId = SupabaseService.currentUserId;

    // Pas d'utilisateur connecté => par sécurité, aucune certif / pas de W-Garage
    if (userId == null) {
      _certMap = {
        'client_handover': false,
        'LAVAGE': false,
        'electric_vehicle': false,
        'document_management': false,
      };
      _hasWGarage = false;
      return;
    }

    // 1) Profil : w_garage
    final profile = await client
        .from('profiles')
        .select('w_garage')
        .eq('id', userId)
        .single();

    _hasWGarage = profile['w_garage'] == true;

    // 2) Certifications validées
    final certs = await client
        .from('driver_certifications')
        .select('certifications(code)')
        .eq('driver_id', userId)
        .eq('is_validated', true);

    final map = {
      'client_handover': false,
      'LAVAGE': false,
      'electric_vehicle': false,
      'document_management': false,
    };

    for (final row in certs as List) {
      final code = row['certifications']?['code'] as String?;
      if (code != null && map.containsKey(code)) {
        map[code] = true;
      }
    }

    _certMap = map;
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

      // On trie par deadline / pickup pour la carte représentative
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

  /// Affiche un dialog expliquant pourquoi la mission est bloquée
  void _showRestrictionDialog(MissionRestriction restriction) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Mission non accessible'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (restriction.isWGarageRestricted) ...[
                const Text('❌ Plaque W-Garage requise'),
                const SizedBox(height: 8),
              ],
              if (restriction.isCertificationRestricted) ...[
                const Text('❌ Certifications manquantes :'),
                const SizedBox(height: 4),
                ...restriction.missingCertifications.map(
                  (cert) => Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 2),
                    child: Text('• $cert'),
                  ),
                ),
                const SizedBox(height: 8),
              ],
              const SizedBox(height: 8),
              const Text(
                'Obtenez ces certifications sur le site web CarSwiift '
                'dans votre espace "Certifications".',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
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

          // 🔥 Calcul de la restriction pour cette mission (représentative du groupe)
          final restriction = MissionRestrictionChecker.check(
            mission,
            _certMap,
            _hasWGarage,
          );

          final bool isRestricted = restriction.isRestricted;

          return Opacity(
            opacity: isRestricted ? 0.4 : 1.0, // floutage visuel
            child: MissionCard(
              mission: mission,
              remainingCount: group.count, // pour le badge xN
              onTap: () {
                if (isRestricted) {
                  _showRestrictionDialog(restriction);
                } else {
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
                }
              },
            ),
          );
        },
      ),
    );
  }
}
