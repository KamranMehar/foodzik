import 'package:foodzik/model%20classes/Recipe.dart';

import 'ingredient.dart';

class Order {
  String? userName;
  String? phoneNumber;
  String? address;
  List<Recipe>? orderRecipes;
  String? coordinates;

  Order({
    this.userName,
    this.phoneNumber,
    this.address,
    this.orderRecipes,
    this.coordinates,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      userName: json['userName'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      orderRecipes: json['orderRecipes'] != null
          ? List<Recipe>.from(json['orderRecipes'].map((x) => Recipe.fromJson(x)))
          : null,
      coordinates: json['coordinates'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'phoneNumber': phoneNumber,
      'address': address,
      'orderRecipes': orderRecipes != null
          ? List<dynamic>.from(orderRecipes!.map((x) => x.toJson()))
          : null,
      'coordinates': coordinates,
    };
  }
}
