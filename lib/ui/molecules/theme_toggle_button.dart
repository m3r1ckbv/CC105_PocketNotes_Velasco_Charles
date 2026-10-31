import 'package:flutter/material.dart';

import '../atoms/icon_action_button.dart';

/// Molecule: icon + tooltip that reflects the current theme.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({
    super.key,
    required this.isDark,
    required this.onPressed,
  });

  final bool isDark;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconActionButton(
      icon: isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
      color: Theme.of(context).colorScheme.onSurface,
      tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
      onPressed: onPressed,
    );
  }
}
