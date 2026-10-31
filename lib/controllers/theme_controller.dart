import 'package:flutter/material.dart';

// EXPERIMENT 1 (disabled): only needed by the delayed-load demo below.
// import '../core/experiments/experiment_flags.dart';
import '../data/local/preferences_service.dart';

class ThemeController extends ChangeNotifier {
  // FIX (restored): the saved theme is read synchronously, right here, while
  // the controller is created - which happens BEFORE runApp() in main.dart.
  // The very first frame is therefore already in the correct theme (no flash).
  ThemeController(this._prefs) : _isDark = _prefs.isDarkMode;

  final PreferencesService _prefs;

  // EXPERIMENT 1 (disabled): the controller used to ALWAYS start as light.
  // bool _isDark = false;
  bool _isDark;

  // EXPERIMENT 1 (disabled): guard so a toggle during the delay wasn't
  // overwritten by the late "saved value". Not needed without the delay.
  // bool _userToggled = false;

  bool get isDark => _isDark;
  ThemeMode get mode => _isDark ? ThemeMode.dark : ThemeMode.light;

  // EXPERIMENT 1 (disabled): simulated slow preference read. It waited 4 s
  // after the app was already on screen, then applied the saved theme,
  // causing the light -> dark flash. To re-run the demo: uncomment this,
  // the `_userToggled` lines, the ExperimentFlags import, switch `_isDark`
  // back to `bool _isDark = false;` + a constructor without the initializer,
  // and uncomment the unawaited(...) call in main.dart.
  //
  // Future<void> loadSavedTheme({
  //   Duration delay = ExperimentFlags.themeLoadDelay,
  // }) async {
  //   await Future<void>.delayed(delay);
  //   if (_userToggled) return;
  //
  //   final saved = _prefs.isDarkMode;
  //   if (saved != _isDark) {
  //     _isDark = saved;
  //     notifyListeners(); // <- the visible "flash" from light to dark
  //   }
  // }

  Future<void> toggle() async {
    // _userToggled = true; // EXPERIMENT 1 (disabled)
    _isDark = !_isDark;
    notifyListeners();
    await _prefs.setDarkMode(_isDark);
  }
}
