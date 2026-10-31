import 'package:flutter/material.dart';

import '../core/experiments/experiment_flags.dart';
import '../data/local/preferences_service.dart';

class ThemeController extends ChangeNotifier {
  ThemeController(this._prefs);

  final PreferencesService _prefs;

  // EXPERIMENT 1: the theme used to be read right here, synchronously:
  //     ThemeController(this._prefs) : _isDark = _prefs.isDarkMode;
  // That is why the right theme appeared on the very first frame.
  // Now the controller ALWAYS starts as light and only applies the saved
  // value later (see loadSavedTheme) -> the first frames use the wrong theme.
  bool _isDark = false;

  // EXPERIMENT 1: if the user taps the toggle during the delay, their tap
  // must win, so the late "saved value" must not overwrite it afterwards.
  bool _userToggled = false;

  bool get isDark => _isDark;
  ThemeMode get mode => _isDark ? ThemeMode.dark : ThemeMode.light;

  /// EXPERIMENT 1: simulates a slow preference read.
  /// Waits [delay] (4 s by default) and only then applies the saved theme.
  /// Called from main() WITHOUT await, so runApp() is not blocked and the
  /// app is already on screen (in light) while this is still waiting.
  Future<void> loadSavedTheme({
    Duration delay = ExperimentFlags.themeLoadDelay,
  }) async {
    await Future<void>.delayed(delay);
    if (_userToggled) return;

    final saved = _prefs.isDarkMode;
    if (saved != _isDark) {
      _isDark = saved;
      notifyListeners(); // <- this is the visible "flash" from light to dark
    }
  }

  Future<void> toggle() async {
    _userToggled = true; // EXPERIMENT 1: see note above
    _isDark = !_isDark;
    notifyListeners();
    await _prefs.setDarkMode(_isDark);
  }
}
