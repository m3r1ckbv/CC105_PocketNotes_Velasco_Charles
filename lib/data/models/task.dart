import '../../core/constants/storage_keys.dart';
import 'task_status.dart';

class Task {
  const Task({
    this.id,
    required this.title,
    this.description = '',
    this.status = TaskStatus.ongoing,
    this.deadline,
    required this.createdAt,
  });

  final int? id;
  final String title;
  final String description;
  final TaskStatus status;
  final DateTime? deadline; // date only, optional
  final DateTime createdAt;

  /// Pass [clearDeadline] = true to remove the deadline.
  Task copyWith({
    int? id,
    String? title,
    String? description,
    TaskStatus? status,
    DateTime? deadline,
    bool clearDeadline = false,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      deadline: clearDeadline ? null : (deadline ?? this.deadline),
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// The id is omitted: it is auto-generated on insert and passed
  /// separately (whereArgs) on update/delete.
  Map<String, Object?> toMap() => {
        DbConstants.colTitle: title,
        DbConstants.colDescription: description,
        DbConstants.colStatus: status.name,
        DbConstants.colDeadline: deadline?.millisecondsSinceEpoch,
        DbConstants.colCreatedAt: createdAt.millisecondsSinceEpoch,
      };

  factory Task.fromMap(Map<String, Object?> map) {
    final deadlineMs = map[DbConstants.colDeadline] as int?;
    return Task(
      id: map[DbConstants.colId] as int?,
      title: map[DbConstants.colTitle] as String,
      description: (map[DbConstants.colDescription] as String?) ?? '',
      status: TaskStatus.fromName(map[DbConstants.colStatus] as String?),
      deadline: deadlineMs == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(deadlineMs),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map[DbConstants.colCreatedAt] as int,
      ),
    );
  }
}
