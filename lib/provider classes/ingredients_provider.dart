
import 'package:flutter/cupertino.dart';

import '../model classes/ingredient.dart';

class IngredientsProvider with ChangeNotifier{
 static List<Ingredient> _ingredientList=[];

  List<Ingredient>? get ingredientList => _ingredientList;

  void addIngredientToList(Ingredient ingredient){
    _ingredientList.add(ingredient);
    notifyListeners();
  }
  void clearIngredientList(){
    _ingredientList.clear();
    notifyListeners();
  }
}