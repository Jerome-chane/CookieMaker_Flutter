import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cookie_maker/models/Alert.dart';
import 'package:cookie_maker/models/Data.dart';
import 'package:cookie_maker/models/Device.dart';
import 'package:cookie_maker/models/Loading.dart';
import 'package:cookie_maker/screens/cookie/cookie_cooking.dart';
import 'package:cookie_maker/services/cookie_service.dart';
import 'package:cookie_maker/services/recipe_service.dart';
import "package:flutter/material.dart";
import 'package:numberpicker/numberpicker.dart';
import 'package:signalr_client/signalr_client.dart' as hub;

class CreateCookie extends StatefulWidget {
  @override
  _CreateCookieState createState() => _CreateCookieState();
}

class _CreateCookieState extends State<CreateCookie> {
  final StreamController _streamController = StreamController.broadcast();
  final RecipeService _recipeService = RecipeService();
  final CookieService _cookieService = CookieService();
  Future<List<Recipe>> futureRecipes;
  Recipe selectedRecipe;
  int quantity = 1;
  int selectedIndex = -1;
  bool loading = false;
  bool connected = false;

  final hubConnection = hub.HubConnectionBuilder()
      .withUrl(Device.isIOS
          ? "http://127.0.0.1:5000/connect"
          : "http://10.0.2.2:5000/connect")
      .build();

  @override
  void initState() {
    super.initState();
    futureRecipes = _recipeService.getRecipes();
    hubConnection.onclose((_) {
      setState(() {
        connected = false;
      });
      print("Conexion lost");
    });
    hubConnection.on("InformClient", onReceiveMessage);
    startConnection();
  }

  void startConnection() async {
    await hubConnection.start().then((value) {
      setState(() {
        connected = true;
      });
      print('Connection started');
    }).catchError((error) => print(error));
  }

  void onReceiveMessage(dynamic result) {
    print("Message Received");
    _streamController.add(result);
  }

  @override
  Widget build(BuildContext context) {
    Stream stream = _streamController.stream;

    return Scaffold(
      appBar: AppBar(
        title: Text("New Cookie"),
        centerTitle: true,
        backgroundColor: Colors.brown[500],
      ),
      body: loading
          ? Loading()
          : Container(
              padding: EdgeInsets.all(30.0),
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Number of Cookies"),
                      NumberPicker.integer(
                          initialValue: quantity,
                          minValue: 1,
                          maxValue: 5,
                          onChanged: (value) {
                            setState(() {
                              quantity = value;
                            });
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: AutoSizeText(
                            "Select a recipe",
                            style: TextStyle(fontSize: 5),
                            maxLines: 1,
                          ),
                        ),
                        buildFutureBuilder(),
                      ]),
                  SizedBox(
                    height: Device.height * 0.06,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (selectedRecipe == null) {
                        showAlertDialog(
                            context, "Error!", "You must select a recipe");
                      } else {
                        loading = true;
                        if (!connected) {
                          startConnection();
                          showAlertDialog(context, "Hang on!",
                              "Connecting with the server. Please try again");
                          return null;
                        }
                        if (connected) {
                          print("CONNECTED ${connected}");
                          await _cookieService
                              .createCookie(quantity, selectedRecipe.recipeName)
                              .then((response) {
                            if (response.statusCode == 200) {
                              setState(() => loading = false);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CookieCooking(
                                            receivedStream: stream,
                                          )));
                            } else {
                              setState(() => loading = false);
                              showAlertDialog(context, "Oops!", response.body);
                            }
                          });
                        }
                      }
                    },
                    child: Text("Create"),
                  ),
                ],
              )),
    );
  }

  FutureBuilder<List<Recipe>> buildFutureBuilder() {
    return FutureBuilder(
        future: futureRecipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          }
          List<Recipe> recipes = snapshot.data ?? [];
          return Expanded(
              child: SizedBox(
            height: Device.height * 0.3,
            child: Scrollbar(
              radius: Radius.circular(20),
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  shrinkWrap: true,
                  itemCount: recipes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: selectedIndex == index
                          ? Colors.blue[400]
                          : Colors.blue[100],
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          setState(() {
                            selectedRecipe = recipes[index];
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          width: Device.width * 0.02,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              AutoSizeText(
                                recipes[index].recipeName,
                                style: TextStyle(fontSize: 1),
                                maxLines: 2,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var ingredient
                                      in recipes[index].ingredientsList)
                                    AutoSizeText(
                                      'x${ingredient.quantity} ${ingredient.name} ',
                                      style: TextStyle(fontSize: 5),
                                      maxLines: 1,
                                    ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ));
        });
  }
}
