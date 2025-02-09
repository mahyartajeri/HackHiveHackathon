class Recipe {
  final String id;
  final String title;
  final String description;
  final String instructions;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final DateTime timestamp;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.instructions,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.timestamp,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      instructions: json['instructions'],
      imageUrl: json['imageUrl'],
      ingredients: List<String>.from(json['ingredients']),
      steps: List<String>.from(json['steps']),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
