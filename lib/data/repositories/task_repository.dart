import 'package:sqflite/sqflite.dart';

import '../../core/constants/storage_keys.dart';
import '../models/task.dart';

/// All task SQL lives here. Values are never concatenated into SQL:
/// update/delete use `WHERE id = ?` with whereArgs.
class TaskRepository {
  TaskRepository(this._db);
  final Database _db;

  Future<List<Task>> getAll() async {
    final rows = await _db.query(
      DbConstants.tableTasks,
      orderBy: '${DbConstants.colCreatedAt} DESC',
    );
    return rows.map(Task.fromMap).toList();
  }

  Future<Task> insert(Task task) async {
    final id = await _db.insert(DbConstants.tableTasks, task.toMap());
    return task.copyWith(id: id);
  }

  Future<int> update(Task task) {
    return _db.update(
      DbConstants.tableTasks,
      task.toMap(),
      where: '${DbConstants.colId} = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> delete(int id) {
    return _db.delete(
      DbConstants.tableTasks,
      where: '${DbConstants.colId} = ?',
      whereArgs: [id],
    );
  }
}
