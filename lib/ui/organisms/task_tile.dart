import 'package:flutter/material.dart';

import '../../data/models/task.dart';
import '../molecules/edit_delete_actions.dart';
import '../molecules/task_details.dart';

/// Organism: one task card - details on the left, actions on the right.
class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.onEdit,
    required this.onDelete,
  });

  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 4, 8),
        child: Row(
          children: [
            Expanded(child: TaskDetails(task: task)),
            EditDeleteActions(onEdit: onEdit, onDelete: onDelete),
          ],
        ),
      ),
    );
  }
}
