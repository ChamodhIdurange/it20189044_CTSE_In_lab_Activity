import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/recipe_model.dart';

class RecipeRepositery {
  final _reference = FirebaseFirestore.instance.collection("RecepieList");

  createToDo(Recipe recipe) async {
    await _reference
        .add(recipe.toJson())
        .whenComplete(() => debugPrint('Success'));
  }

  Future<List<Recipe>> getToDoList(String userId) async {
    final snapshot = await _reference.where('userId', isEqualTo: userId).get();
    final list = snapshot.docs.map((e) => Recipe.fromSnapshot(e)).toList();
    return list;
  }

  Future<void> completeItem(Recipe item) async {
    await _reference.doc(item.id).update(item.toJson());
  }

  Future<void> deleteItem(String? id) async {
    await _reference.doc(id).delete();
  }
}
