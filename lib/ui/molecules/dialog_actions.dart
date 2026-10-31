import 'package:flutter/material.dart';

import '../atoms/color_button.dart';

/// Molecule: Cancel text button + colored confirm button.
class DialogActions extends StatelessWidget {
  const DialogActions({
    super.key,
    required this.confirmLabel,
    required this.confirmColor,
    required this.onConfirm,
    required this.onCancel,
    this.cancelLabel = 'Cancel',
  });

  final String confirmLabel;
  final Color confirmColor;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final String cancelLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(onPressed: onCancel, child: Text(cancelLabel)),
        const SizedBox(width: 8),
        ColorButton(
          label: confirmLabel,
          color: confirmColor,
          onPressed: onConfirm,
        ),
      ],
    );
  }
}
