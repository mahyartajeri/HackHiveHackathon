import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quick_plate/models/macros.dart';
import 'package:quick_plate/models/recipe.dart';

class RecipeApi {
  static Future<Recipe?> generateRecipe(Macros macros) async {
    const endpoint = 'genRecipe';
    print(macros.toJson());
    // Add timeout to avoid infinite waiting

    try {
      final response = await http.post(
        Uri.parse('http://10.0.0.165:8000/$endpoint'),
        body: jsonEncode({
          'data': macros.toJson(),
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 25));
      print(Recipe.fromJson(json.decode(response.body)));

      if (response.statusCode == 200) {
        return Recipe.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to generate recipe');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
