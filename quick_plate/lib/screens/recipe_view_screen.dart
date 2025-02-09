import 'package:flutter/material.dart';
import 'package:quick_plate/models/recipe.dart';

class RecipeViewScreen extends StatefulWidget {
  const RecipeViewScreen({super.key, required this.recipe})
      : generated = false,
        onRegenerate = null;
  const RecipeViewScreen.generated({
    super.key,
    required this.recipe,
    required this.onRegenerate,
  }) : generated = true;

  final Recipe recipe;
  final bool generated;
  final void Function()? onRegenerate;

  @override
  _RecipeViewScreenState createState() => _RecipeViewScreenState();
}

class _RecipeViewScreenState extends State<RecipeViewScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: widget.generated
          ? FloatingActionButton(
              onPressed: widget.onRegenerate,
              child: const Icon(Icons.refresh),
            )
          : null,
      appBar: AppBar(
        title: Text(
          widget.recipe.title,
          style: theme.textTheme.headlineLarge!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 128),
        children: [
          Image.network(
            widget.recipe.imageUrl,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.recipe.description,
              style: theme.textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Ingredients',
              style: theme.textTheme.headlineMedium,
            ),
          ),
          Text(
            '',
            style: theme.textTheme.bodySmall,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Instructions',
              style: theme.textTheme.headlineMedium,
            ),
          ),
        ],
      ),
    );
  }
}
