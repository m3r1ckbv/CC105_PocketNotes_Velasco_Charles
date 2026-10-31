import 'package:flutter/material.dart';

import '../../data/models/task_status.dart';
import '../atoms/radio_option.dart';

/// Molecule: label + one [RadioOption] per [TaskStatus].
class StatusRadioGroup extends StatelessWidget {
  const StatusRadioGroup({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final TaskStatus value;
  final ValueChanged<TaskStatus> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Task Status', style: Theme.of(context).textTheme.labelLarge),
        for (final status in TaskStatus.values)
          RadioOption<TaskStatus>(
            value: status,
            groupValue: value,
            label: status.label,
            onChanged: onChanged,
          ),
      ],
    );
  }
}
