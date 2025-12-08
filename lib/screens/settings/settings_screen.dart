import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/constants.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkMode = false;
  bool _locationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('General'),
          _buildSwitchTile(
            title: 'Dark Mode',
            subtitle: 'Enable dark theme',
            value: _darkMode,
            icon: Icons.dark_mode,
            onChanged: (val) {
              setState(() => _darkMode = val);
              // TODO: Implement theme switching logic
            },
          ),
          _buildSwitchTile(
            title: 'Notifications',
            subtitle: 'Receive push notifications',
            value: _notificationsEnabled,
            icon: Icons.notifications,
            onChanged: (val) {
              setState(() => _notificationsEnabled = val);
            },
          ),
          _buildSwitchTile(
            title: 'Location Services',
            subtitle: 'Allow app to access location',
            value: _locationEnabled,
            icon: Icons.location_on,
            onChanged: (val) {
              setState(() => _locationEnabled = val);
            },
          ),
          const Divider(),
          _buildSectionHeader('Account'),
          _buildListTile(
            title: 'Edit Profile',
            icon: Icons.person,
            onTap: () {
              // Navigate to edit profile
            },
          ),
          _buildListTile(
            title: 'Change Password',
            icon: Icons.lock,
            onTap: () {
              // Navigate to change password
            },
          ),
          _buildListTile(
            title: 'Privacy Policy',
            icon: Icons.privacy_tip,
            onTap: () {
              // Navigate to privacy policy
            },
          ),
           const Divider(),
          _buildSectionHeader('Support'),
          _buildListTile(
            title: 'Help Center',
            icon: Icons.help,
            onTap: () {
              // Navigate to help center
            },
          ),
          _buildListTile(
            title: 'About Us',
            icon: Icons.info,
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'HyperLocal Pro',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2024 HyperLocal Pro',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required IconData icon,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        secondary: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        activeColor: AppColors.primary,
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}
