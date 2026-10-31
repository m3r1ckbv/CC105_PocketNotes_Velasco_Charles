import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'controllers/favorite_controller.dart';
import 'controllers/task_controller.dart';
import 'controllers/theme_controller.dart';
import 'data/local/database_helper.dart';
import 'data/local/preferences_service.dart';
import 'data/repositories/task_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final themeController = ThemeController(PreferencesService(prefs));

  // Database: opened exactly once, here, at launch.
  await DatabaseHelper.instance.init();
  final taskController = TaskController(
    TaskRepository(DatabaseHelper.instance.database),
  );
  await taskController.load(); // records ready before the first frame

  // EXPERIMENT 2: in-memory only, created fresh on every launch.
  final favoriteController = FavoriteController();

  // EXPERIMENT 1: the saved theme is NOT applied before runApp anymore.
  // Instead it is requested here and left running in the background
  // (unawaited). runApp() fires immediately, so the app shows the default
  // light theme and, ~4 seconds later, jumps to the saved one.
  //
  // Original (correct) behaviour was: apply the saved theme BEFORE runApp,
  // so the first frame is already right (no flash).
  unawaited(themeController.loadSavedTheme());

  runApp(PocketTaskApp(
    themeController: themeController,
    taskController: taskController,
    favoriteController: favoriteController,
  ));
}
