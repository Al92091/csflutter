import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/theme.dart';
import '../../services/auth_service.dart';
import '../auth/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? _profile;
  String _appVersion = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final profile = await _authService.getCurrentProfile();
      final packageInfo = await PackageInfo.fromPlatform();
      
      setState(() {
        _profile = profile;
        _appVersion = packageInfo.version;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signOut() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Voulez-vous vraiment vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
            ),
            child: const Text('Déconnexion'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await _authService.signOut();
      
      if (!mounted) return;
      
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur : ${e.toString()}'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Impossible d\'ouvrir le lien'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                // Account section
                _buildSectionHeader('Compte'),
                _buildListTile(
                  icon: Icons.person,
                  title: 'Nom complet',
                  subtitle: _profile != null
                      ? '${_profile!['first_name']} ${_profile!['last_name']}'
                      : 'Non renseigné',
                ),
                _buildListTile(
                  icon: Icons.email,
                  title: 'Email',
                  subtitle: _profile?['email'] ?? 'Non renseigné',
                ),
                _buildListTile(
                  icon: Icons.phone,
                  title: 'Téléphone',
                  subtitle: _profile?['phone'] ?? 'Non renseigné',
                ),
                _buildListTile(
                  icon: Icons.edit,
                  title: 'Modifier mon profil',
                  subtitle: 'Accéder au profil web complet',
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () {
                    _launchUrl('https://yksbhynmpcpcvaysatui.supabase.co/driver/profile');
                  },
                ),
                const Divider(height: 32),

                // Preferences section
                _buildSectionHeader('Préférences'),
                SwitchListTile(
                  secondary: const Icon(Icons.notifications),
                  title: const Text('Notifications push'),
                  subtitle: const Text('Recevoir les alertes de missions'),
                  value: true, // TODO: Implement notification settings
                  onChanged: (value) {
                    // TODO: Implement notification toggle
                  },
                  activeColor: AppTheme.primaryColor,
                ),
                _buildListTile(
                  icon: Icons.language,
                  title: 'Langue',
                  subtitle: 'Français',
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Implement language selection
                  },
                ),
                const Divider(height: 32),

                // Information section
                _buildSectionHeader('Informations'),
                _buildListTile(
                  icon: Icons.info_outline,
                  title: 'Version de l\'application',
                  subtitle: 'v$_appVersion',
                ),
                _buildListTile(
                  icon: Icons.description,
                  title: 'Conditions d\'utilisation',
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () {
                    _launchUrl('https://carswiift.com/terms');
                  },
                ),
                _buildListTile(
                  icon: Icons.privacy_tip,
                  title: 'Politique de confidentialité',
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () {
                    _launchUrl('https://carswiift.com/privacy');
                  },
                ),
                const Divider(height: 32),

                // Support section
                _buildSectionHeader('Support'),
                _buildListTile(
                  icon: Icons.help_outline,
                  title: 'Centre d\'aide',
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () {
                    _launchUrl('https://carswiift.com/faq');
                  },
                ),
                _buildListTile(
                  icon: Icons.email_outlined,
                  title: 'Contacter le support',
                  subtitle: 'support@carswiift.com',
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () {
                    _launchUrl('mailto:support@carswiift.com');
                  },
                ),
                const Divider(height: 32),

                // Sign out button
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: _signOut,
                      icon: const Icon(Icons.logout),
                      label: const Text('Déconnexion'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.errorColor,
                        side: const BorderSide(color: AppTheme.errorColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppTheme.primaryColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
