import 'package:flutter/material.dart';

import '../../controllers/task_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../core/theme/semantic_colors.dart';
import '../../data/models/task.dart';
import '../atoms/app_fab.dart';
import '../organisms/app_top_bar.dart';
import '../organisms/confirm_dialog.dart';
import '../organisms/task_form_dialog.dart';
import '../organisms/task_list.dart';
import '../templates/home_template.dart';

/// Page: connects controllers (state) to the template and organisms.
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.taskController,
    required this.themeController,
  });

  final TaskController taskController;
  final ThemeController themeController;

  Future<void> _addTask(BuildContext context) async {
    final task = await TaskFormDialog.show(context);
    if (task != null) await taskController.add(task);
  }

  Future<void> _editTask(BuildContext context, Task current) async {
    final updated = await TaskFormDialog.show(context, task: current);
    if (updated != null) await taskController.update(updated);
  }

  Future<void> _deleteTask(BuildContext context, Task task) async {
    final confirmed = await ConfirmDialog.show(
      context,
      title: 'Delete task?',
      message: '"${task.title}" will be permanently removed.',
      confirmLabel: 'Delete',
      confirmColor: context.semantic.delete,
    );
    if (confirmed) await taskController.delete(task);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([taskController, themeController]),
      builder: (context, _) => HomeTemplate(
        appBar: AppTopBar(
          title: 'Pocket Task',
          isDark: themeController.isDark,
          onToggleTheme: themeController.toggle,
        ),
        body: TaskList(
          tasks: taskController.tasks,
          onEdit: (t) => _editTask(context, t),
          onDelete: (t) => _deleteTask(context, t),
        ),
        floatingActionButton: AppFab(
          icon: Icons.add,
          color: context.semantic.add,
          tooltip: 'Add task',
          onPressed: () => _addTask(context),
        ),
      ),
    );
  }
}
