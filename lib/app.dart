import 'package:flutter/material.dart';

import 'controllers/task_controller.dart';
import 'controllers/theme_controller.dart';
import 'core/theme/app_theme.dart';
import 'ui/pages/home_page.dart';

class PocketTaskApp extends StatelessWidget {
  const PocketTaskApp({
    super.key,
    required this.themeController,
    required this.taskController,
  });

  final ThemeController themeController;
  final TaskController taskController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeController,
      builder: (_, __) => MaterialApp(
        title: 'Pocket Task',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeController.mode,
        home: HomePage(
          taskController: taskController,
          themeController: themeController,
        ),
      ),
    );
  }
}
