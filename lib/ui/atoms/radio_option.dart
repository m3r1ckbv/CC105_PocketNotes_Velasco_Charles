import 'package:flutter/material.dart';

/// Atom: a single labeled radio button.
class RadioOption<T> extends StatelessWidget {
  const RadioOption({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
  });

  final T value;
  final T groupValue;
  final String label;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      value: value,
      groupValue: groupValue,
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
      title: Text(label),
      dense: true,
      contentPadding: EdgeInsets.zero,
    );
  }
}
