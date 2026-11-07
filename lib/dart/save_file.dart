import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SaveFile {
  static SharedPreferences? _prefs;
  static const Duration _saveDebounce = Duration(milliseconds: 300);
  static final Map<String, Timer> _debouncers = <String, Timer>{};
  static final Map<String, String> _pendingValues = <String, String>{};

  static Future<SharedPreferences> _getPrefs() async {
    return _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> saveData(String key, String value) async {
    _pendingValues[key] = value;
    _debouncers[key]?.cancel();

    _debouncers[key] = Timer(_saveDebounce, () async {
      final prefs = await _getPrefs();
      final latestValue = _pendingValues[key];
      if (latestValue == null) return;
      await prefs.setString(key, latestValue);
    });
  }

  static Future<String?> loadData(String key) async {
    final prefs = await _getPrefs();
    return prefs.getString(key);
  }
}
