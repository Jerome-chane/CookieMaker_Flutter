import 'package:cookie_maker/screens/recipe/recipe_detail.dart';
import 'package:flutter/material.dart';

class RecipeView extends StatefulWidget {
  final List<dynamic> recipes;
  final String title;
  RecipeView({Key key, @required this.recipes, this.title}) : super(key: key);

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(widget.title),
          backgroundColor: Colors.brown[500]),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/cookie2.jpg"), fit: BoxFit.cover),
        ),
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: widget.recipes.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.brown[200],
                      borderRadius: BorderRadius.circular(18.0)),
                  height: 50,
                  margin: EdgeInsets.all(5),
                  child: Center(
                      child: Text(
                    '${widget.recipes[index].recipeName}',
                    style: TextStyle(fontSize: 18),
                  )),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecipeDetail(
                                recipe: widget.recipes[index],
                              )));
                },
              );
            }),
      ),
    );
  }
}
