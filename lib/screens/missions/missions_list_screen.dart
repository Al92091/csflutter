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

class _MissionsListScreenState extends State<MissionsListScreen> {
  final MissionService _missionService = MissionService();
  List<Mission> _missions = [];
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
      setState(() {
        _missions = missions;
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

    if (_missions.isEmpty) {
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
        itemCount: _missions.length,
        itemBuilder: (context, index) {
          final mission = _missions[index];
          return MissionCard(
            mission: mission,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MissionDetailScreen(
                    missionId: mission.id,
                    isAvailable: true, // ✅ flag pour dire qu'on est dans "missions disponibles"
                  ),
                ),
              ).then((_) => _loadMissions());
            },
          );
        },
      ),
    );
  }
}
