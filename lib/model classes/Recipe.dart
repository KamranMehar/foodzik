import 'ingredient.dart';

class Recipe {
  String name;
  String imageForeground;
  String image;
  int price;
  String category;
  List<Ingredient> ingredients;
  String timeToBake;
  int perPerson;

  Recipe({
    required this.name,
    required this.imageForeground,
    required this.image,
    required this.price,
    required this.category,
    required this.ingredients,
    required this.timeToBake,
    required this.perPerson,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      imageForeground: json['imageForeground'],
      image: json['image'],
      price: json['price'],
      category: json['category'],
      ingredients: List<Ingredient>.from(json['ingredients'].map((x) => Ingredient.fromJson(x))),
      timeToBake: json['timeToBake'],
      perPerson: json['perPerson'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageForeground': imageForeground,
      'image': image,
      'price': price,
      'category': category,
      'ingredients': List<dynamic>.from(ingredients.map((x) => x.toJson())),
      'timeToBake': timeToBake,
      'perPerson': perPerson,
    };
  }
}
