
import 'package:flutter/cupertino.dart';

class InputProvider with ChangeNotifier{
static  String  _input="";

  String get input => _input;

  set input(String value) {
    _input = _input+value;
    if(input.length==4){
      _input=_input;
    }
    notifyListeners();
  }
  decrementInput(){
    if(_input.isNotEmpty) {
      _input = _input.substring(0, _input.length - 1);
      notifyListeners();
      print(_input);
    }
  }

  clearInput(){
    _input="";
    notifyListeners();
  }

}