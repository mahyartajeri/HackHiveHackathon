import 'package:flutter/material.dart';
import 'package:quick_plate/models/recipe.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key, required this.recipes});

  final List<Recipe> recipes;

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Recipe',
          style: theme.textTheme.headlineLarge!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: widget.recipes.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(''),
              subtitle: Text(widget.recipes[index].description),
              onTap: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => const SelectMacrosScreen(),
                //   ),
                // );
              },
            );
          }),
    );
  }
}
