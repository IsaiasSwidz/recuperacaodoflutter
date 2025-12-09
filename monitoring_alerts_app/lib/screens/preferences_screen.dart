import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/preferences_service.dart';
import '../models/preferences.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = context.watch<PreferencesService>().preferences;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notification Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Vibration'),
                      subtitle: const Text('Enable vibration for notifications'),
                      value: prefs.vibrationEnabled,
                      onChanged: (value) => 
                        context.read<PreferencesService>().toggleVibration(),
                    ),
                    const Divider(),
                    SwitchListTile(
                      title: const Text('Sound'),
                      subtitle: const Text('Enable sound for notifications'),
                      value: prefs.soundEnabled,
                      onChanged: (value) => 
                        context.read<PreferencesService>().toggleSound(),
                    ),
                    const Divider(),
                    SwitchListTile(
                      title: const Text('Banner'),
                      subtitle: const Text('Show banner notifications'),
                      value: prefs.bannerEnabled,
                      onChanged: (value) => 
                        context.read<PreferencesService>().toggleBanner(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Critical Mode',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SwitchListTile(
                  title: const Text('Critical Mode'),
                  subtitle: const Text(
                    'Force alerts even when device is in silent mode or Do Not Disturb is active'
                  ),
                  value: prefs.criticalMode,
                  onChanged: (value) => 
                    context.read<PreferencesService>().toggleCriticalMode(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About Critical Mode',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'When Critical Mode is enabled, the app will attempt to bypass system settings '
                      'like silent mode and Do Not Disturb to ensure important alerts are delivered. '
                      'This may require special permissions on some devices.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}