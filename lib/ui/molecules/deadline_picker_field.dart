import 'package:flutter/material.dart';

import '../../core/utils/date_format.dart';
import '../atoms/app_date_field.dart';

/// Molecule: [AppDateField] + the platform date picker.
class DeadlinePickerField extends StatelessWidget {
  const DeadlinePickerField({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = 'Deadline',
  });

  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final String label;

  Future<void> _pick(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: value ?? dateOnly(DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) onChanged(dateOnly(picked));
  }

  @override
  Widget build(BuildContext context) {
    return AppDateField(
      label: label,
      valueText: value == null ? null : formatDate(value!),
      onTap: () => _pick(context),
      onClear: () => onChanged(null),
    );
  }
}
