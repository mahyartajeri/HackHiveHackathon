import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quick_plate/models/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_plate/providers/user_provider.dart';

class RecipeViewScreen extends ConsumerStatefulWidget {
  RecipeViewScreen({super.key, required this.recipe})
      : generated = false,
        onRegenerate = null;
  RecipeViewScreen.generated({
    super.key,
    required this.recipe,
    required this.onRegenerate,
  }) : generated = true;

  Recipe recipe;
  final bool generated;
  final Future<Recipe?> Function()? onRegenerate;

  @override
  _RecipeViewScreenState createState() => _RecipeViewScreenState();
}

class _RecipeViewScreenState extends ConsumerState<RecipeViewScreen> {
  bool _regenerating = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ModalProgressHUD(
      inAsyncCall: _regenerating || _isSaving,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: widget.generated
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    key: const Key('regenerate'),
                    heroTag: 'regenerate',
                    onPressed: () async {
                      setState(() {
                        _regenerating = true;
                      });
                      final newRecipe = await widget.onRegenerate!();
                      if (newRecipe != null) {
                        setState(() {
                          widget.recipe = newRecipe;
                        });
                      }
                      setState(() {
                        _regenerating = false;
                      });
                    },
                    label: const Text('Try again'),
                    icon: const Icon(Icons.refresh),
                  ),
                  const SizedBox(width: 32),
                  FloatingActionButton.extended(
                    key: const Key('save'),
                    heroTag: 'save',
                    onPressed: () async {
                      try {
                        setState(() {
                          _isSaving = true;
                        });
                        final docRef = FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('recipes')
                            .doc(widget.recipe.id);
                        await docRef.set(widget.recipe.toMap());

                        // update provider
                        ref
                            .read(userProvider.notifier)
                            .addRecipe(widget.recipe);
                      } catch (e) {
                        print(e);
                      }

                      setState(() {
                        _isSaving = false;
                      });

                      // pop navigator twice
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    backgroundColor: Colors.green,
                    label: const Text('Save'),
                    icon: const Icon(Icons.save),
                  ),
                ],
              )
            : null,
        appBar: AppBar(
          title: FittedBox(
            child: Text(
              widget.recipe.title,
              style: theme.textTheme.headlineLarge!.copyWith(
                color: Colors.white,
              ),
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
                widget.recipe.recipe,
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
