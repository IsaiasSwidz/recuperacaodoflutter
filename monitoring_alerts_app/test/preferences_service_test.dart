import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../lib/services/preferences_service.dart';
import '../lib/models/preferences.dart';

void main() {
  group('PreferencesService Tests', () {
    setUp(() {
      // Initialize SharedPreferences with a mock implementation
      SharedPreferences.setMockInitialValues({});
    });

    test('should initialize with default preferences', () async {
      final service = PreferencesService();
      
      // Wait for initialization
      await Future.delayed(const Duration(milliseconds: 100));
      
      expect(service.preferences.vibrationEnabled, true);
      expect(service.preferences.soundEnabled, true);
      expect(service.preferences.bannerEnabled, true);
      expect(service.preferences.criticalMode, false);
    });

    test('should toggle vibration preference', () async {
      final service = PreferencesService();
      
      // Wait for initialization
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Initially true
      expect(service.preferences.vibrationEnabled, true);
      
      // Toggle to false
      await service.toggleVibration();
      expect(service.preferences.vibrationEnabled, false);
      
      // Toggle back to true
      await service.toggleVibration();
      expect(service.preferences.vibrationEnabled, true);
    });

    test('should toggle sound preference', () async {
      final service = PreferencesService();
      
      // Wait for initialization
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Initially true
      expect(service.preferences.soundEnabled, true);
      
      // Toggle to false
      await service.toggleSound();
      expect(service.preferences.soundEnabled, false);
      
      // Toggle back to true
      await service.toggleSound();
      expect(service.preferences.soundEnabled, true);
    });

    test('should toggle critical mode', () async {
      final service = PreferencesService();
      
      // Wait for initialization
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Initially false
      expect(service.preferences.criticalMode, false);
      
      // Toggle to true
      await service.toggleCriticalMode();
      expect(service.preferences.criticalMode, true);
      
      // Toggle back to false
      await service.toggleCriticalMode();
      expect(service.preferences.criticalMode, false);
    });

    test('should save preferences correctly', () async {
      final service = PreferencesService();
      
      // Wait for initialization
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Create new preferences
      final newPrefs = Preferences(
        vibrationEnabled: false,
        soundEnabled: false,
        bannerEnabled: false,
        criticalMode: true,
      );
      
      // Save the new preferences
      await service.savePreferences(newPrefs);
      
      // Check that preferences were updated
      expect(service.preferences.vibrationEnabled, false);
      expect(service.preferences.soundEnabled, false);
      expect(service.preferences.bannerEnabled, false);
      expect(service.preferences.criticalMode, true);
    });
  });
}