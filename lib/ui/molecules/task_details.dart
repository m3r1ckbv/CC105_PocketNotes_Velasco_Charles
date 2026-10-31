import 'package:flutter/material.dart';

import '../../core/theme/semantic_colors.dart';
import '../../core/utils/date_format.dart';
import '../../data/models/task.dart';
import '../../data/models/task_status.dart';
import '../atoms/deadline_label.dart';
import '../atoms/status_chip.dart';

/// Molecule: title + description + [StatusChip] + deadline.
class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final deadline = task.deadline;
    // Overdue = still on-going and the deadline day has passed.
    final overdue = deadline != null &&
        task.status == TaskStatus.ongoing &&
        deadline.isBefore(dateOnly(DateTime.now()));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          task.title,
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (task.description.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            task.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
        ],
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            StatusChip(status: task.status),
            if (deadline != null)
              DeadlineLabel(
                text: formatDate(deadline),
                color: overdue
                    ? context.semantic.delete
                    : scheme.onSurfaceVariant,
              ),
          ],
        ),
      ],
    );
  }
}
