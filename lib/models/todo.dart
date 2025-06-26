class Todo {
  final String id;
  final String title;
  final String description;

  const Todo({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] ?? 'no-id',
      title: json['title'] ?? 'Untitled',
      description: json['description'] ?? '',
    );
  }
}
