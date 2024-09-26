class Todo {
  const Todo({
    required this.id,
    required this.description,
    required this.completed,
  });

  final int id;
  final String description;
  final bool completed;

  Todo copyWith({
    int? id,
    String? description,
    bool? completed,
  }) =>
      Todo(
        id: id ?? this.id,
        description: description ?? this.description,
        completed: completed ?? this.completed,
      );
}
