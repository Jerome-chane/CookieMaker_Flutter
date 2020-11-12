import 'package:cookie_maker/models/Alert.dart';
import 'package:cookie_maker/models/Device.dart';
import 'package:cookie_maker/models/Loading.dart';
import 'package:cookie_maker/screens/recipe/create_recipe.dart';
import 'package:cookie_maker/screens/recipe/recipe_view.dart';
import 'package:cookie_maker/services/recipe_service.dart';
import 'package:flutter/material.dart';

class RecipeDashboard extends StatefulWidget {
  @override
  _RecipeDashboardState createState() => _RecipeDashboardState();
}

class _RecipeDashboardState extends State<RecipeDashboard> {
  final RecipeService _recipeService = RecipeService();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: Text("Recipe Dashboard"),
          centerTitle: true,
          backgroundColor: Colors.brown[500],
        ),
        body: loading
            ? Loading()
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/cookie3.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Center(
                  child: ListView(
                    padding: const EdgeInsets.all(30),
                    children: <Widget>[
                      ButtonTheme(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        minWidth: 200.0,
                        height: Device.height * 0.15,
                        buttonColor: Colors.green[300],
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateRecipe()));
                          },
                          child: Text("Create new Recipe"),
                        ),
                      ),
                      SizedBox(
                          height: Device.portrait
                              ? Device.height * 0.05
                              : Device.height * 0.1),
                      ButtonTheme(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        minWidth: 200.0,
                        height: Device.height * 0.15,
                        buttonColor: Colors.blue[300],
                        child: RaisedButton(
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });

                            await _recipeService.getRecipes().then((value) {
                              setState(() {
                                loading = false;
                              });
                              if (value != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RecipeView(
                                              recipes: value,
                                              title: "All recipes",
                                            )));
                              } else {
                                showAlertDialog(
                                    context, "Oops", "No Recipes were found");
                              }
                            });
                          },
                          child: Text("See all the Recipes"),
                        ),
                      ),
                      // SizedBox(
                      //     height: Device.portrait
                      //         ? Device.height * 0.05
                      //         : Device.height * 0.1),
                      // ButtonTheme(
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(18.0),
                      //   ),
                      //   minWidth: 200.0,
                      //   height: Device.height * 0.15,
                      //   buttonColor: Colors.orange[300],
                      //   child: RaisedButton(
                      //     onPressed: () async {},
                      //     child: Text("Modify Recipe"),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ));
  }
}
