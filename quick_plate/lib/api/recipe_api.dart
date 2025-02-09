import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quick_plate/models/macros.dart';
import 'package:quick_plate/models/recipe.dart';

class RecipeApi {
  static Future<Recipe> generateRecipe(Macros macros) async {
    const path = 'genRecipe';

    final response = await http.post(
      Uri.parse('http://localhost:5000/$path'),
      body: macros.toJson(),
    );

    if (response.statusCode == 200) {
      return Recipe.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to generate recipe');
    }
  }
}
