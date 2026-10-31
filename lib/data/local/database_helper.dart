import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../../core/constants/storage_keys.dart';

/// Owns the single SQLite connection.
/// Call [init] once at launch (see main.dart); everything else reuses [database].
class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database? _db;

  Database get database {
    final db = _db;
    if (db == null) {
      throw StateError('DatabaseHelper.init() must be called before use.');
    }
    return db;
  }

  Future<void> init() async {
    if (_db != null) return; // already opened - never open twice
    final path = p.join(await getDatabasesPath(), DbConstants.name);
    _db = await openDatabase(
      path,
      version: DbConstants.version,
      onCreate: (db, version) => db.execute('''
        CREATE TABLE ${DbConstants.tableTasks} (
          ${DbConstants.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${DbConstants.colTitle} TEXT NOT NULL,
          ${DbConstants.colDescription} TEXT NOT NULL DEFAULT '',
          ${DbConstants.colStatus} TEXT NOT NULL,
          ${DbConstants.colDeadline} INTEGER,
          ${DbConstants.colCreatedAt} INTEGER NOT NULL
        )
      '''),
      // v1 -> v2: add the deadline column without losing existing tasks.
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'ALTER TABLE ${DbConstants.tableTasks} '
            'ADD COLUMN ${DbConstants.colDeadline} INTEGER',
          );
        }
      },
    );
  }
}
