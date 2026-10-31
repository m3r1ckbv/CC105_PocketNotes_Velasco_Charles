import 'package:flutter/material.dart';

import '../../core/theme/semantic_colors.dart';
import '../../data/models/task_status.dart';

/// Atom: small colored label for a task status.
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});
  final TaskStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = context.semantic;
    final color = switch (status) {
      TaskStatus.ongoing => colors.ongoing,
      TaskStatus.finished => colors.finished,
      TaskStatus.cancelled => colors.cancelled,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(40),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
