import 'package:flutter/material.dart';

import '../../core/theme/semantic_colors.dart';
import '../../data/models/task.dart';
import '../../data/models/task_status.dart';
import '../atoms/app_text_field.dart';
import '../molecules/deadline_picker_field.dart';
import '../molecules/dialog_actions.dart';
import '../molecules/status_radio_group.dart';

/// Organism: add / edit form. Pass [task] to edit. [show] resolves to the
/// resulting [Task], or null if dismissed.
class TaskFormDialog extends StatefulWidget {
  const TaskFormDialog({super.key, this.task});
  final Task? task;

  static Future<Task?> show(BuildContext context, {Task? task}) {
    return showDialog<Task>(
      context: context,
      builder: (_) => TaskFormDialog(task: task),
    );
  }

  @override
  State<TaskFormDialog> createState() => _TaskFormDialogState();
}

class _TaskFormDialogState extends State<TaskFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title =
      TextEditingController(text: widget.task?.title);
  late final TextEditingController _description =
      TextEditingController(text: widget.task?.description);
  late TaskStatus _status = widget.task?.status ?? TaskStatus.ongoing;
  late DateTime? _deadline = widget.task?.deadline;

  bool get _isEditing => widget.task != null;

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final base = widget.task ?? Task(title: '', createdAt: DateTime.now());
    Navigator.of(context).pop(
      base.copyWith(
        title: _title.text.trim(),
        description: _description.text.trim(),
        status: _status,
        deadline: _deadline,
        clearDeadline: _deadline == null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.semantic;
    return AlertDialog(
      title: Text(_isEditing ? 'Edit Task' : 'New Task'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(
                controller: _title,
                label: 'Task Title',
                autofocus: true,
                textInputAction: TextInputAction.next,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Title is required' : null,
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _description,
                label: 'Description',
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              DeadlinePickerField(
                value: _deadline,
                onChanged: (d) => setState(() => _deadline = d),
              ),
              const SizedBox(height: 12),
              StatusRadioGroup(
                value: _status,
                onChanged: (s) => setState(() => _status = s),
              ),
            ],
          ),
        ),
      ),
      actions: [
        DialogActions(
          confirmLabel: _isEditing ? 'Update' : 'Add',
          confirmColor: _isEditing ? colors.edit : colors.add,
          onConfirm: _submit,
          onCancel: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
