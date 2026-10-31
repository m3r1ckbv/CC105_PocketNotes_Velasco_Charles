// EXPERIMENT 1 (disabled): only needed for unawaited(...) below.
// import 'dart:async';

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

  // FIX (restored): prefs are loaded and the ThemeController is created
  // BEFORE runApp(), and its constructor reads the saved theme immediately.
  // So the first frame already uses the correct theme.
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

  // EXPERIMENT 1 (disabled): the saved theme used to be requested here and
  // left running in the background (unawaited). runApp() fired immediately,
  // so the app showed light for ~4 s before jumping to the saved theme.
  // unawaited(themeController.loadSavedTheme());

  runApp(PocketTaskApp(
    themeController: themeController,
    taskController: taskController,
    favoriteController: favoriteController,
  ));
}
