import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/preferences.dart';

class PreferencesService extends ChangeNotifier {
  static const String _prefsKey = 'app_preferences';
  
  Preferences _preferences = Preferences();

  Preferences get preferences => _preferences;

  PreferencesService() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final prefsString = prefs.getString(_prefsKey);
    
    if (prefsString != null) {
      final Map<String, dynamic> prefsMap = 
          Map<String, dynamic>.from((decodePreferences(prefsString)));
      _preferences = Preferences.fromMap(prefsMap);
    } else {
      _preferences = Preferences();
    }
    
    notifyListeners();
  }

  Future<void> savePreferences(Preferences newPreferences) async {
    _preferences = newPreferences;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, encodePreferences(_preferences.toMap()));
    
    notifyListeners();
  }

  // Toggle methods
  Future<void> toggleVibration() async {
    _preferences.vibrationEnabled = !_preferences.vibrationEnabled;
    await _saveCurrentPreferences();
  }

  Future<void> toggleSound() async {
    _preferences.soundEnabled = !_preferences.soundEnabled;
    await _saveCurrentPreferences();
  }

  Future<void> toggleBanner() async {
    _preferences.bannerEnabled = !_preferences.bannerEnabled;
    await _saveCurrentPreferences();
  }

  Future<void> toggleCriticalMode() async {
    _preferences.criticalMode = !_preferences.criticalMode;
    await _saveCurrentPreferences();
  }

  Future<void> _saveCurrentPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, encodePreferences(_preferences.toMap()));
  }

  // Helper methods to encode/decode preferences for storage
  String encodePreferences(Map<String, dynamic> preferences) {
    // Simple encoding - in a real app, you might want to use JSON
    return preferences.toString();
  }

  Map<String, dynamic> decodePreferences(String preferencesString) {
    // Simple decoding - in a real app, you might want to use JSON
    // This is a simplified implementation
    final map = <String, dynamic>{};
    
    // Parse the string representation back to a map
    // This is a simplified version - in a real implementation you'd use json.decode
    if (preferencesString.contains('vibrationEnabled')) {
      map['vibrationEnabled'] = preferencesString.contains('vibrationEnabled: true');
    }
    if (preferencesString.contains('soundEnabled')) {
      map['soundEnabled'] = preferencesString.contains('soundEnabled: true');
    }
    if (preferencesString.contains('bannerEnabled')) {
      map['bannerEnabled'] = preferencesString.contains('bannerEnabled: true');
    }
    if (preferencesString.contains('criticalMode')) {
      map['criticalMode'] = preferencesString.contains('criticalMode: true');
    }
    
    return map;
  }
}