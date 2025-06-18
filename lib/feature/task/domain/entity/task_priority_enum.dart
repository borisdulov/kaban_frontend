enum TaskPriority {
  high(str: 'high'),
  major(str: 'major'),
  medium(str: 'medium'),
  low(str: 'low');

  final String str;

  const TaskPriority({required this.str});

  factory TaskPriority.fromString(String str) {
    return TaskPriority.values.firstWhere(
      (value) => value.str.toLowerCase() == str.toLowerCase(),
      orElse: () => TaskPriority.medium,
    );
  }
}
