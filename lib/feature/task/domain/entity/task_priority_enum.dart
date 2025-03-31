enum TaskPriority {
  high(str: 'High'),
  major(str: 'Major'),
  medium(str: 'Medium'),
  low(str: 'Low');

  final String str;

  const TaskPriority({required this.str});

  factory TaskPriority.fromString(String str) {
    return TaskPriority.values.firstWhere(
      (value) => value.str == str,
      orElse: () => TaskPriority.medium,
    );
  }
}
