/// Keys used with SharedPreferences.
class StorageKeys {
  StorageKeys._();
  static const String isDarkMode = 'is_dark_mode';
}

/// Names used by the SQLite database.
class DbConstants {
  DbConstants._();
  static const String name = 'pocket_task.db';
  static const int version = 2;

  static const String tableTasks = 'tasks';
  static const String colId = 'id';
  static const String colTitle = 'title';
  static const String colDescription = 'description';
  static const String colStatus = 'status';
  static const String colCreatedAt = 'created_at';
  static const String colDeadline = 'deadline';
}
