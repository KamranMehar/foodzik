import 'package:flutter/cupertino.dart';

import '../utils/dialogs.dart';

class CreateSpecialOrderProvider with ChangeNotifier{
  List<Map<dynamic, dynamic>> _ingredients=[];
  Map _recipe={};
  int _minPerson = 0;
  int _person = 0;
  int _price = 0;

  int _totalPrice = 0;

  int get minPerson => _minPerson;

  int get person => _person;

  int get price => _price;

  int get totalPrice => _totalPrice;

  set minPerson(int value) {
    _minPerson = value;
    if (_person < _minPerson) {
      _person = _minPerson;
    }
    notifyListeners();
  }

  set person(int value) {
    _person = value;
    _totalPrice = _person * _price;
    notifyListeners();
  }

  set price(int value) {
    _price = value;
    _totalPrice = _person * _price;
    notifyListeners();
  }

  void reset() {
    _person = _minPerson;
    _totalPrice = _person * _price;
    notifyListeners();
  }

  void addPerson() {
    if (_person < 50) {
      _person++;
      _totalPrice = _person * _price;
      notifyListeners();
    } else {
      Utils.showToast("Maximum 50 Persons you can set");
    }
  }

  void decreasePerson() {
    if (_person > _minPerson) {
      _person--;
      _totalPrice = _person * _price;
      notifyListeners();
    } else {
      Utils.showToast("Minimum Person Should be $_minPerson");
    }
  }

  Map get recipe => _recipe;

  set recipe(Map value) {
    _recipe = value;
  }

  List<Map<dynamic, dynamic>> get ingredients => _ingredients;

  set ingredients(List<Map<dynamic, dynamic>> value) {
    _ingredients = value;
  }

  updateIngredient(int index,Map<dynamic,dynamic> ingredient){
    _ingredients[index]=ingredient;
    notifyListeners();
  }

}