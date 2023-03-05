import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/recipe_model.dart';

class RecipeRepositery {
  final _reference = FirebaseFirestore.instance.collection("RecepieList");

  createRecipe(Recipe recipe) async {
    await _reference
        .add(recipe.toJson())
        .whenComplete(() => debugPrint('Success'));
  }

  Future<List<Recipe>> getRecipeist(String userId) async {
    final snapshot = await _reference.where('userId', isEqualTo: userId).get();
    final list = snapshot.docs.map((e) => Recipe.fromSnapshot(e)).toList();
    return list;
  }

  Future<void> updateRecipe(Recipe item) async {
    await _reference.doc(item.id).update(item.toJson());
  }

  Future<void> deleteRecipe(String? id) async {
    await _reference.doc(id).delete();
  }
}
