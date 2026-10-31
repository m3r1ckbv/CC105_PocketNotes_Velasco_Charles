import 'package:flutter/material.dart';

/// Atom: read-only field that looks like a text input and opens a picker
/// on tap. Shows a clear (x) button when a value is set and [onClear] given.
class AppDateField extends StatelessWidget {
  const AppDateField({
    super.key,
    required this.label,
    required this.valueText,
    required this.onTap,
    this.onClear,
  });

  final String label;
  final String? valueText;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final hasValue = valueText != null;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: InputDecorator(
        isEmpty: !hasValue,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: hasValue && onClear != null
              ? IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: 'Clear',
                  onPressed: onClear,
                )
              : const Icon(Icons.calendar_today_outlined),
        ),
        child: Text(valueText ?? ''),
      ),
    );
  }
}
