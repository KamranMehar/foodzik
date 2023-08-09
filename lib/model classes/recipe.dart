import 'package:foodzik/model%20classes/steps_to_bake.dart';
import 'ingredient.dart';
class Recipe {
  String? name;
  String? imageForeground;
  String? image;
  int? price;
  String? category;
  List<Ingredient>? ingredients;
  String? timeToBake;
  int? perPerson;
  String? difficulty;
  String? info;
  List<StepsToBake>? stepsToBakeList;

    Recipe({
     required this.name,
     required this.category,
      required this.timeToBake,
      required this.image,
      required this.imageForeground,
      required this.price,
      required this.ingredients,
      required this.perPerson,
      required this.stepsToBakeList,
      required this.difficulty,
      required this.info,
    });

  factory Recipe.fromJson(Map<dynamic, dynamic> json) {
    return Recipe(
      name: json['name'],
      imageForeground: json['imageForeground'],
      image: json['image'],
      price: json['price'],
      category: json['category'],
      ingredients: json['ingredients'] != null
          ? List<Ingredient>.from(json['ingredients'].map((x) => Ingredient.fromJson(x)))
          : [], // Provide an empty list if ingredients is null
      timeToBake: json['timeToBake'],
      perPerson: json['perPerson'],
      stepsToBakeList: List<StepsToBake>.from(json['steps'].map((x) => StepsToBake.fromJson(x))),
      difficulty: json['difficulty'],
      info: json['info'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageForeground': imageForeground,
      'image': image,
      'price': price,
      'category': category,
      'ingredients': List<dynamic>.from(ingredients!.map((x) => x.toJson())),
      'timeToBake': timeToBake,
      'perPerson': perPerson,
      'steps': List<dynamic>.from(stepsToBakeList!.map((x) => x.toJson())),
      'difficulty':difficulty,
      'info': info
    };
  }
}

