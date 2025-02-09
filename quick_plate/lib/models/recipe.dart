class Recipe {
  final String id;
  final String title;
  final String recipe;
  final DateTime timestamp;

  Recipe({
    required this.id,
    required this.title,
    required this.recipe,
    required this.timestamp,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      recipe: json['text'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
