

import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier{
  int totalPrice=0;
 static List<Map> recipeList=[];

  addToCart(Map recipe){
    recipeList.add(recipe);
    totalPrice=(totalPrice+recipe["price"]).toInt();
    notifyListeners();
  }

  removeFromCart(Map recipe){
    recipeList.remove(recipe);
    totalPrice=(totalPrice-recipe["price"]).toInt();
    notifyListeners();
  }
}