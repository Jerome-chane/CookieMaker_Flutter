import 'dart:convert';
import 'package:cookie_maker/models/Data.dart';
import 'package:http/http.dart' as http;

class RecipeService {
  final String _urlAndroid = "http://10.0.2.2:5000/recipe";
  // final String _urlIOS = "http://127.0.0.1:5000/recipe";

  Future<List<Recipe>> getRecipes() async {
    dynamic response = await http.get(_urlAndroid); //10.0.2.2 replace localhost
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Recipe.fromJson(job)).toList();
    } else {
      return null;
      // throw Exception('Failed to Fetch cookies.');
    }
  }

  Future<http.Response> createRecipe(Recipe recipe) async {
    String jsonRecipe = jsonEncode(recipe);

    return http
        .post(_urlAndroid,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonRecipe)
        .then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      return response;
    });
  }
}
