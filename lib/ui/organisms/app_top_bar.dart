import 'package:flutter/material.dart';

import '../molecules/theme_toggle_button.dart';

/// Organism: app bar with title and the theme toggle.
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({
    super.key,
    required this.title,
    required this.isDark,
    required this.onToggleTheme,
  });

  final String title;
  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        ThemeToggleButton(isDark: isDark, onPressed: onToggleTheme),
      ],
    );
  }
}
