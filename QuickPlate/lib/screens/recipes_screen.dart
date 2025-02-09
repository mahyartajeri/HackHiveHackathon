import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quick_plate/models/recipe.dart';
import 'package:quick_plate/providers/user_provider.dart';
import 'package:quick_plate/screens/recipe_view_screen.dart';
import 'package:quick_plate/screens/select_macros_screen.dart';

final _firebase = FirebaseAuth.instance;
final _google = GoogleSignIn();

class RecipesScreen extends ConsumerWidget {
  const RecipesScreen({super.key, required this.recipes});

  final List<Recipe> recipes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
        // backgroundColor: const Color(0xFF3E5F41),
        appBar: AppBar(
          title: Row(
            children: [
              Text('QuickPlate',
                  style: theme.textTheme.headlineLarge!.copyWith(
                    color: Colors.white,
                  )),
              const Spacer(),
              Text(
                ref.watch(userProvider).name,
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () async {
                if (await confirm(
                  context,
                  title: const Text('Logout?'),
                  content: const Text('Are you sure you want to logout?'),
                )) {
                  ref.read(userProvider.notifier).clearUser();
                  _firebase.signOut();
                  _google.signOut();
                }
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SelectMacrosScreen(),
              ),
            );
          },
          label: Text(
            'Add Recipe',
            style: theme.textTheme.headlineSmall!.copyWith(
              color: Colors.white,
            ),
          ),
          icon: const Icon(
            Icons.add,
            size: 35,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          child: recipes.isNotEmpty
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                  ),
                  padding: const EdgeInsets.all(16),
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RecipeViewScreen(
                              recipe: recipe,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Image.network(
                                  recipe.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      recipe.title,
                                      style: theme.textTheme.headlineSmall!
                                          .copyWith(
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'No recipes saved yet. Get cooking! 🥘',
                    style: theme.textTheme.headlineLarge!.copyWith(
                        // color: Colors.white,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
        ));
  }
}
