

import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier{
  int totalPrice=0;
  List<Map> recipeList=[];

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
  bool isRecipeInCart(Map recipe) {
    return recipeList.any((item) => item['name'] == recipe['name']);
  }

  clearList(){
    recipeList.clear();
    notifyListeners();
  }

}