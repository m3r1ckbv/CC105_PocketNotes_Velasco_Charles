import 'package:flutter/material.dart';

/// Colors with a meaning (add / edit / delete / task status).
/// Each theme provides its own shade so they stay readable in dark mode.
@immutable
class SemanticColors extends ThemeExtension<SemanticColors> {
  const SemanticColors({
    required this.add,
    required this.edit,
    required this.delete,
    required this.ongoing,
    required this.finished,
    required this.cancelled,
  });

  final Color add;
  final Color edit;
  final Color delete;
  final Color ongoing;
  final Color finished;
  final Color cancelled;

  static const SemanticColors light = SemanticColors(
    add: Color(0xFF3FA37A),
    edit: Color(0xFF4A90C2),
    delete: Color(0xFFD9534F),
    ongoing: Color(0xFFD99A2B),
    finished: Color(0xFF3FA37A),
    cancelled: Color(0xFF8A94A0),
  );

  static const SemanticColors dark = SemanticColors(
    add: Color(0xFF5FCFA0),
    edit: Color(0xFF7DB8F0),
    delete: Color(0xFFF08A86),
    ongoing: Color(0xFFF0C066),
    finished: Color(0xFF5FCFA0),
    cancelled: Color(0xFFA7B0BA),
  );

  @override
  SemanticColors copyWith({
    Color? add,
    Color? edit,
    Color? delete,
    Color? ongoing,
    Color? finished,
    Color? cancelled,
  }) {
    return SemanticColors(
      add: add ?? this.add,
      edit: edit ?? this.edit,
      delete: delete ?? this.delete,
      ongoing: ongoing ?? this.ongoing,
      finished: finished ?? this.finished,
      cancelled: cancelled ?? this.cancelled,
    );
  }

  @override
  SemanticColors lerp(ThemeExtension<SemanticColors>? other, double t) {
    if (other is! SemanticColors) return this;
    return SemanticColors(
      add: Color.lerp(add, other.add, t)!,
      edit: Color.lerp(edit, other.edit, t)!,
      delete: Color.lerp(delete, other.delete, t)!,
      ongoing: Color.lerp(ongoing, other.ongoing, t)!,
      finished: Color.lerp(finished, other.finished, t)!,
      cancelled: Color.lerp(cancelled, other.cancelled, t)!,
    );
  }
}

extension SemanticColorsContext on BuildContext {
  SemanticColors get semantic => Theme.of(this).extension<SemanticColors>()!;
}
