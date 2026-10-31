import 'package:flutter/foundation.dart';

import '../data/models/task.dart';
import '../data/repositories/task_repository.dart';

class TaskController extends ChangeNotifier {
  TaskController(this._repo);
  final TaskRepository _repo;

  List<Task> _tasks = [];
  List<Task> get tasks => List.unmodifiable(_tasks);

  Future<void> load() async {
    _tasks = await _repo.getAll();
    notifyListeners();
  }

  Future<void> add(Task task) async {
    final saved = await _repo.insert(task);
    _tasks.insert(0, saved);
    notifyListeners();
  }

  Future<void> update(Task task) async {
    await _repo.update(task);
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) _tasks[index] = task;
    notifyListeners();
  }

  Future<void> delete(Task task) async {
    if (task.id == null) return;
    await _repo.delete(task.id!);
    _tasks.removeWhere((t) => t.id == task.id);
    notifyListeners();
  }
}
