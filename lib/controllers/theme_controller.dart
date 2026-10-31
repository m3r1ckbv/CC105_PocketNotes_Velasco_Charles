import 'package:flutter/material.dart';

import '../data/local/preferences_service.dart';

class ThemeController extends ChangeNotifier {
  ThemeController(this._prefs) : _isDark = _prefs.isDarkMode;

  final PreferencesService _prefs;
  bool _isDark;

  bool get isDark => _isDark;
  ThemeMode get mode => _isDark ? ThemeMode.dark : ThemeMode.light;

  Future<void> toggle() async {
    _isDark = !_isDark;
    notifyListeners();
    await _prefs.setDarkMode(_isDark);
  }
}
