import 'package:flutter/material.dart';

import '../main.dart';
import '../models/recipe_model.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  late final List<String> defaultingredients = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favourite Recipe'),
        actions: [
          IconButton(
              onPressed: userRepo.fireBaseSignOut,
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        //Opening a diallog in OnPressed to floating button
        onPressed: () {
          setState(() {
            _titleController.text = "";
            _descriptionController.text = "";
            _ingredientsController.text = "";
          });
          showDialog(
              context: context,
              builder: (content) => AlertDialog(
                    insetPadding: const EdgeInsets.symmetric(
                      horizontal: 50.0,
                      vertical: 220.0,
                    ),
                    title: const Text('Enter new Recepie'),
                    content: Column(children: [
                      TextField(
                        //Setting the changed value
                        controller: _titleController,
                        decoration:
                            const InputDecoration(hintText: "Enter title"),
                      ),
                      TextField(
                        //Setting the changed value
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                            hintText: "Enter description"),
                      ),
                      TextField(
                        //Setting the changed value
                        controller: _ingredientsController,
                        decoration: const InputDecoration(
                            hintText: "Enter Ingredients"),
                      ),
                    ]),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        onPressed: () {
                          setState(() {
                            repo.createRecipe(Recipe(
                                title: _titleController.text,
                                passedIngredients: _ingredientsController.text,
                                ingredients: defaultingredients,
                                userId: userRepo.getCurrentUser().uid,
                                description: _descriptionController.text));

                            _titleController.text = '';
                          });
                          Navigator.of(content).pop();
                        },
                        child: const Text('Enter'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          //Closing the dialog
                          Navigator.of(content).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ));
        },
        child: const Icon(Icons.add),
      ),
      // Adding a list view to the body
      body: FutureBuilder(
        future: repo.getRecipeist(userRepo.getCurrentUser().uid),
        builder: (context, snapshot) {
          //Waiting to fetch data
          if (snapshot.connectionState == ConnectionState.done) {
            //Check whether the snapshot has data
            if (snapshot.hasData) {
              return ListView.builder(
                // Setting the snapshot data length as count
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.food_bank),
                          title: Text(snapshot.data![index].title),
                          subtitle: Text(snapshot.data![index].description),
                        ),
                        SizedBox(
                          height: 100,
                          // child ListView
                          child: ListView.builder(
                              itemCount:
                                  snapshot.data![index].ingredients.length,
                              itemBuilder: (_, i) => ListTile(
                                  leading:
                                      const Icon(Icons.all_inclusive_rounded),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 80.0,
                                  ),
                                  title: Text(
                                      snapshot.data![index].ingredients[i]))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ElevatedButton(
                              child: const Text('EDIT'),
                              onPressed: () {
                                setState(() {
                                  _titleController.text =
                                      snapshot.data![index].title;
                                  _descriptionController.text =
                                      snapshot.data![index].description;
                                });
                                showDialog(
                                    context: context,
                                    builder: (content) => AlertDialog(
                                          title: const Text('Edit Recepie'),
                                          content: Column(children: [
                                            TextField(
                                              //Setting the changed value
                                              controller: _titleController,
                                              decoration: const InputDecoration(
                                                  hintText: "Enter title"),
                                            ),
                                            TextField(
                                              //Setting the changed value
                                              controller:
                                                  _descriptionController,
                                              decoration: const InputDecoration(
                                                  hintText:
                                                      "Enter description"),
                                            ),
                                            TextField(
                                              //Setting the changed value
                                              controller:
                                                  _ingredientsController,
                                              decoration: const InputDecoration(
                                                  hintText:
                                                      "Enter description"),
                                            ),
                                          ]),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue),
                                              onPressed: () {
                                                final completedData = Recipe(
                                                    id: snapshot
                                                        .data![index].id,
                                                    description:
                                                        _descriptionController
                                                            .text,
                                                    ingredients:
                                                        defaultingredients,
                                                    title:
                                                        _titleController.text,
                                                    passedIngredients:
                                                        _ingredientsController
                                                            .text,
                                                    userId: snapshot
                                                        .data![index].userId);
                                                setState(() {
                                                  // Completing the status
                                                  repo.updateRecipe(
                                                      completedData);
                                                });
                                                //Closing the dialog
                                                Navigator.of(content).pop();
                                              },
                                              child: const Text('Update'),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                              onPressed: () {
                                                //Closing the dialog
                                                Navigator.of(content).pop();
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                          ],
                                        ));
                              },
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              child: const Text('DELETE'),
                              onPressed: () {
                                setState(() {
                                  //Deleting an item
                                  repo.deleteRecipe(snapshot.data![index].id);
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
              //Check whether snapshot has error
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return const Center(child: Text("Something went wrong"));
            }
            //Display buffer until data fetching is completed
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
