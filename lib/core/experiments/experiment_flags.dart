/// ============================================================
/// EXPERIMENT SWITCHES - demo only, NOT for the final app.
/// ============================================================
class ExperimentFlags {
  ExperimentFlags._();

  /// EXPERIMENT 1 (wrong-theme flash):
  /// How long the app waits before applying the saved theme.
  /// Set to `Duration.zero` to turn the experiment off.
  static const Duration themeLoadDelay = Duration(seconds: 4);
}
