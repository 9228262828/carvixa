import 'package:flutter/material.dart';

import '../providers/theme_provider.dart';
import 'about_screen.dart';
import 'privacy_policy_screen.dart';
import 'terms_conditions_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeController.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
        children: [
          Text('Appearance', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          Card(
            child: SwitchListTile.adaptive(
              value: themeProvider.isDarkMode,
              onChanged: themeProvider.setDarkMode,
              secondary: const Icon(Icons.dark_mode_rounded),
              title: const Text('Dark Mode'),
              subtitle: const Text('Use a darker appearance across the app.'),
            ),
          ),
          const SizedBox(height: 22),
          Text('Information', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.info_outline_rounded,
                  title: 'About Carvixa',
                  onTap: () => _open(context, const AboutScreen()),
                ),
                const Divider(height: 1, indent: 64),
                _SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  onTap: () => _open(context, const PrivacyPolicyScreen()),
                ),
                const Divider(height: 1, indent: 64),
                _SettingsTile(
                  icon: Icons.description_outlined,
                  title: 'Terms & Conditions',
                  onTap: () => _open(context, const TermsConditionsScreen()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Card(
            child: ListTile(
              leading: const Icon(Icons.apps_rounded),
              title: const Text('App Version'),
              trailing: Text(
                '1.0.0',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _open(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: onTap,
    );
  }
}
