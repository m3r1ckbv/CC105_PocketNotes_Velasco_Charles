enum TaskStatus {
  ongoing('On-going'),
  finished('Finished'),
  cancelled('Cancelled');

  const TaskStatus(this.label);
  final String label;

  /// Safe parse from the value stored in the database.
  static TaskStatus fromName(String? name) => TaskStatus.values.firstWhere(
        (s) => s.name == name,
        orElse: () => TaskStatus.ongoing,
      );
}
