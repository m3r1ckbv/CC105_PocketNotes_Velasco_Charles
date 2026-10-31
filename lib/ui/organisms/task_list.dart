import 'package:flutter/material.dart';

import '../../data/models/task.dart';
import '../molecules/empty_state.dart';
import 'task_tile.dart';

/// Organism: scrollable list of [TaskTile]s, or an [EmptyState].
class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.tasks,
    required this.onEdit,
    required this.onDelete,
  });

  final List<Task> tasks;
  final ValueChanged<Task> onEdit;
  final ValueChanged<Task> onDelete;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const EmptyState(
        message: 'No tasks yet. Tap + to add one.',
        icon: Icons.checklist_rounded,
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 88),
      itemCount: tasks.length,
      itemBuilder: (_, i) => TaskTile(
        key: ValueKey(tasks[i].id),
        task: tasks[i],
        onEdit: () => onEdit(tasks[i]),
        onDelete: () => onDelete(tasks[i]),
      ),
    );
  }
}
