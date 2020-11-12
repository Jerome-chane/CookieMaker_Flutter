class Cookie {
  final String id;
  final String recipeId;
  final int progress;
  final String startTime;
  final String endTime;
  final String cookingDuration;
  final bool shipped;
  Cookie(
      {this.id,
      this.recipeId,
      this.progress,
      this.startTime,
      this.endTime,
      this.cookingDuration,
      this.shipped});

  factory Cookie.fromJson(Map<String, dynamic> json) {
    return Cookie(
        id: json['id'],
        recipeId: json['recipeId'],
        progress: json['progress'],
        startTime: json['startTime'],
        endTime: json['endTime'] ?? null,
        cookingDuration: json['cookingDuration'] ?? null,
        shipped: json['shipped']);
  }
}

class Recipe {
  final String id;
  final String recipeName;
  final List<Ingredient> ingredientsList;
  Recipe({this.id, this.recipeName, this.ingredientsList});
  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<Ingredient> list = List<Ingredient>();
    for (var ingredient in json['ingredientsList']) {
      Ingredient i = new Ingredient.fromJson(ingredient);
      list.add(i);
    }
    return Recipe(
        id: json['id'], recipeName: json['recipeName'], ingredientsList: list);
  }
  Map toJson() => {
        "id": '',
        "recipeName": recipeName,
        "ingredientsList": ingredientsList.map((e) => e.toJson()).toList()
      };
}

class Ingredient {
  final String name;
  final int quantity;
  Ingredient({this.name, this.quantity});
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      quantity: json['quantity'],
    );
  }
  Map toJson() => {"name": name, "quantity": quantity};
}

enum Ingredient_name { sugar, flour, chocolate, nocillanegra, nocillablanca }
