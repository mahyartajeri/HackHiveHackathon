import 'package:uuid/uuid.dart';

class Recipe {
  final String id;
  final String title;
  final String recipe;
  final DateTime timestamp;
  final String imageUrl;

  Recipe({
    required this.id,
    required this.title,
    required this.recipe,
    required this.timestamp,
    this.imageUrl = '',
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: const Uuid().v4(),
      title: json['title'],
      recipe: json['recipe'],
      timestamp: DateTime.parse(json['timestamp']),
      imageUrl: json['imageUrl'],
    );
  }

  String toJson() {
    return '''
    {
      "title": "$title",
      "recipe": "$recipe",
      "timestamp": "$timestamp",
      "imageUrl": "$imageUrl"
    }
    ''';
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    final rec = Recipe(
      id: map['id'],
      title: map['title'],
      recipe: map['recipe'],
      timestamp: DateTime.parse(map['timestamp']),
      imageUrl: map['imageUrl'],
    );
    return rec;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'recipe': recipe,
      'timestamp': timestamp.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }
}
