import 'package:cookie_maker/models/Alert.dart';
import 'package:cookie_maker/models/Data.dart';
import 'package:cookie_maker/models/Loading.dart';
import 'package:cookie_maker/services/recipe_service.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CreateRecipe extends StatefulWidget {
  @override
  _CreateRecipeState createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  final _formKey = GlobalKey<FormState>();
  final RecipeService _recipeService = RecipeService();
  String recipeName = "";
  bool isError = false;
  bool isButtonPressed = false;
  List<Ingredient> ingredients = List<Ingredient>();
  int quantity = 1;
  String dropdownValue = 'Sugar';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Recipe"),
        backgroundColor: Colors.brown[500],
        centerTitle: true,
      ),
      body: loading
          ? Loading()
          : Container(
              padding: EdgeInsets.all(40.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Enter a recipe name",
                      ),
                      validator: (value) {
                        if (!isButtonPressed) return null;
                        isError = true;
                        if (value.isEmpty) return 'Please enter some text';
                        if (value.length < 4)
                          return "The recipe name must have at least 4 characters";
                        isError = false;
                        return null;
                      },
                      onChanged: (value) {
                        isButtonPressed = false;
                        if (isError) {
                          _formKey.currentState.validate();
                        }
                        setState(() => recipeName = value);
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(ingredients.isEmpty
                            ? "Please Select one or more ingredient(s)"
                            : "Selected Ingredients: "),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            for (var item in ingredients)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('x${item.quantity} ${item.name} '),
                                  IconButton(
                                    icon: Icon(
                                      Icons.highlight_remove,
                                      color: Colors.red,
                                    ),
                                    tooltip: 'Remove Ingredient',
                                    onPressed: () {
                                      setState(() {
                                        ingredients.remove(item);
                                      });
                                    },
                                  )
                                ],
                              ),
                          ],
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.brown[300]),
                          underline: Container(
                            height: 2,
                            color: Colors.brown[300],
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>[
                            "Sugar",
                            'Flour',
                            'Chocolate',
                            'Nocilla negra',
                            'Nocilla blanca'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        new NumberPicker.integer(
                            initialValue: quantity,
                            minValue: 1,
                            maxValue: 30,
                            onChanged: (value) {
                              setState(() {
                                quantity = value;
                              });
                            }),
                        SizedBox(
                          width: 70.0,
                          height: 30.0,
                          child: ElevatedButton(
                            onPressed: () {
                              Ingredient newIngredient = new Ingredient(
                                  name: dropdownValue, quantity: quantity);
                              var existingItem = ingredients.firstWhere(
                                  (item) => item.name == newIngredient.name,
                                  orElse: () => null);
                              if (existingItem == null) {
                                setState(() {
                                  ingredients.add(newIngredient);
                                });
                              } else {
                                showAlertDialog(context, "Oops",
                                    "This ingredient has already been added");
                              }
                            },
                            child: Text('Add'),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    ElevatedButton(
                      onPressed: () async {
                        isButtonPressed = true;
                        if (_formKey.currentState.validate() &&
                            ingredients.length > 0) {
                          setState(() => loading = true);
                          Recipe newRecipe = Recipe(
                              id: '',
                              recipeName: recipeName,
                              ingredientsList: ingredients);

                          await _recipeService
                              .createRecipe(newRecipe)
                              .then((response) {
                            if (response.statusCode == 200) {
                              setState(() => loading = false);
                              showAlertDialog(context, "Congratulations!",
                                  "Recipe sucressfully created");
                            } else {
                              setState(() => loading = false);
                              showAlertDialog(context, "Oops!", response.body);
                            }
                          });
                        } else {
                          setState(() => loading = false);
                          showAlertDialog(context, "Oops!",
                              "The recipe must have a name and at least one ingredient");
                        }
                      },
                      child: Text('Submit'),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
