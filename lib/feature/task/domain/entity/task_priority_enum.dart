enum TaskPriority {
  critical(str: 'critical'),
  major(str: 'major'),
  normal(str: 'normal'),
  low(str: 'low');

  final String str;

  const TaskPriority({required this.str});

  factory TaskPriority.fromString(String str) {
    return TaskPriority.values.firstWhere(
      (value) => value.str == str,
      orElse: () => TaskPriority.normal,
    );
  }
}