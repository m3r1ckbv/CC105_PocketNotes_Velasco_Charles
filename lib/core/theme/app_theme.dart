import 'package:flutter/material.dart';

import 'semantic_colors.dart';

/// Plain, minimal light & dark themes.
class AppTheme {
  AppTheme._();

  static const Color _seed = Color(0xFF6C8EBF); // soft blue-grey

  static final ThemeData light = _build(
    ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.light)
        .copyWith(surface: const Color(0xFFF7F9FB)),
    SemanticColors.light,
  );

  static final ThemeData dark = _build(
    ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.dark),
    SemanticColors.dark,
  );

  static ThemeData _build(ColorScheme scheme, SemanticColors semantic) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      extensions: <ThemeExtension<dynamic>>[semantic],
    );
  }
}
