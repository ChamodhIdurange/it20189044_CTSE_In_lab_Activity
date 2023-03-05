import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  String? id;
  String title;
  String description;
  String userId;
  String? passedIngredients;
  List<String>? ingredients;

  Recipe(
      {required this.description,
      required this.title,
      required this.userId,
      this.passedIngredients,
      this.id});

  toJson() {
    List<String>? ingredientList = passedIngredients?.split(',');
    return {
      "description": description,
      "title": title,
      "userId": userId,
      "ingredients": ingredientList
    };
  }

  factory Recipe.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    //Because data can be null
    final data = document.data()!;
    return Recipe(
      id: document.id,
      description: data["description"],
      userId: data["userId"],
      title: data["title"],
    );
  }
}
