class Preferences {
  bool vibrationEnabled;
  bool soundEnabled;
  bool bannerEnabled;
  bool criticalMode;

  Preferences({
    this.vibrationEnabled = true,
    this.soundEnabled = true,
    this.bannerEnabled = true,
    this.criticalMode = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'vibrationEnabled': vibrationEnabled,
      'soundEnabled': soundEnabled,
      'bannerEnabled': bannerEnabled,
      'criticalMode': criticalMode,
    };
  }

  factory Preferences.fromMap(Map<String, dynamic> map) {
    return Preferences(
      vibrationEnabled: map['vibrationEnabled'] ?? true,
      soundEnabled: map['soundEnabled'] ?? true,
      bannerEnabled: map['bannerEnabled'] ?? true,
      criticalMode: map['criticalMode'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Preferences(vibrationEnabled: $vibrationEnabled, soundEnabled: $soundEnabled, bannerEnabled: $bannerEnabled, criticalMode: $criticalMode)';
  }
}