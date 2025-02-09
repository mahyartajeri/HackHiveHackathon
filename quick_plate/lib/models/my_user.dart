import 'package:quick_plate/models/recipe.dart';

class MyUser {
  final String uid;
  final String email;
  final String name;
  final List<Recipe> recipes;

  MyUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.recipes,
  });

  addRecipe(Recipe recipe) {
    recipes.add(recipe);
  }

  deleteRecipe(String recipeId) {
    try {
      recipes.firstWhere((r) => r.id == recipeId);
    } catch (e) {
      return;
    }
    recipes.removeWhere((recipe) => recipe.id == recipeId);
  }

  updateRecipe(Recipe recipe) {
    try {
      recipes.firstWhere((r) => r.id == recipe.id);
    } catch (e) {
      return;
    }
    final index = recipes.indexWhere((r) => r.id == recipe.id);
    recipes[index] = recipe;
  }
}
