import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../models/mission.dart';
import '../../services/mission_service.dart';
import '../../widgets/mission_card.dart';
import '../../widgets/loading_indicator.dart';
import 'mission_detail_screen.dart';

class MyMissionsScreen extends StatefulWidget {
  const MyMissionsScreen({super.key});

  @override
  State<MyMissionsScreen> createState() => _MyMissionsScreenState();
}

class _MyMissionsScreenState extends State<MyMissionsScreen> {
  final MissionService _missionService = MissionService();
  Map<String, List<Mission>> _categorizedMissions = {};
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
      final missions = await _missionService.fetchMyMissions();
      final categorized = _missionService.categorizeMissions(missions);
      setState(() {
        _categorizedMissions = categorized;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Missions'),
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
      return const LoadingIndicator(message: 'Chargement de vos missions...');
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

    final totalMissions = _categorizedMissions.values
        .fold<int>(0, (sum, list) => sum + list.length);

    if (totalMissions == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.assignment_outlined,
              size: 64,
              color: AppTheme.textHint,
            ),
            const SizedBox(height: 16),
            Text(
              'Aucune mission',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Vos missions réservées apparaîtront ici',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadMissions,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_categorizedMissions['toClose']?.isNotEmpty ?? false)
            _buildCategory(
              'À clôturer',
              _categorizedMissions['toClose']!,
              Icons.pending_actions,
              AppTheme.warningColor,
            ),
          if (_categorizedMissions['inProgress']?.isNotEmpty ?? false)
            _buildCategory(
              'En cours',
              _categorizedMissions['inProgress']!,
              Icons.local_shipping,
              AppTheme.secondaryColor,
            ),
          if (_categorizedMissions['upcoming']?.isNotEmpty ?? false)
            _buildCategory(
              'À venir',
              _categorizedMissions['upcoming']!,
              Icons.schedule,
              AppTheme.primaryColor,
            ),
          if (_categorizedMissions['history']?.isNotEmpty ?? false)
            _buildCategory(
              'Historique',
              _categorizedMissions['history']!,
              Icons.history,
              AppTheme.successColor,
            ),
        ],
      ),
    );
  }

  Widget _buildCategory(
    String title,
    List<Mission> missions,
    IconData icon,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 8),
            Text(
              '$title (${missions.length})',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...missions.map((mission) => MissionCard(
              mission: mission,
              showStatus: true, // ✅ affiche la version "Mes missions"
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MissionDetailScreen(
                      missionId: mission.id,
                      isAvailable: false,
                    ),
                  ),
                ).then((_) => _loadMissions());
              },
            )),
        const SizedBox(height: 24),
      ],
    );
  }
}
