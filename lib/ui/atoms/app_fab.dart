import 'package:flutter/material.dart';

/// Atom: floating action button with a custom color.
class AppFab extends StatelessWidget {
  const AppFab({
    super.key,
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      elevation: 1,
      backgroundColor: color,
      foregroundColor: Colors.white,
      child: Icon(icon),
    );
  }
}
