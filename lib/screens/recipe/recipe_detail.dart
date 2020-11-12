import 'package:cookie_maker/models/Data.dart';
import 'package:cookie_maker/models/Device.dart';
import 'package:flutter/material.dart';

class RecipeDetail extends StatelessWidget {
  final Recipe recipe;
  RecipeDetail({Key key, @required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Device().init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Recipe Detail"),
          backgroundColor: Colors.brown[500],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Device.height * 0.09,
                    child: Text("Name:"),
                  ),
                  Container(
                    height: Device.height * 0.09,
                    child: Text(recipe.recipeName),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Ingredients: "),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var item in recipe.ingredientsList)
                        Text('x${item.quantity} ${item.name} ')
                    ],
                  )
                ],
              ),
              Divider(),
              SizedBox(
                width: 70.0,
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Device.height * 0.09,
                    child: Text("Id: "),
                  ),
                  Container(
                    height: Device.height * 0.09,
                    child: Text(recipe.id),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
