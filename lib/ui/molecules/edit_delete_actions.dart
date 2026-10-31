import 'package:flutter/material.dart';

import '../../core/theme/semantic_colors.dart';
import '../atoms/icon_action_button.dart';

/// Molecule: Edit + Delete icon buttons.
class EditDeleteActions extends StatelessWidget {
  const EditDeleteActions({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = context.semantic;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconActionButton(
          icon: Icons.edit_outlined,
          color: colors.edit,
          tooltip: 'Edit',
          onPressed: onEdit,
        ),
        IconActionButton(
          icon: Icons.delete_outline,
          color: colors.delete,
          tooltip: 'Delete',
          onPressed: onDelete,
        ),
      ],
    );
  }
}
