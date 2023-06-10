import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer' as developer show log;
import '../utils/dialogs.dart';


class DeleteRecipeProvider with ChangeNotifier {
  List<String>deleteRecipeList = [];

  addToDeleteList(String recipeName, String category) {
    deleteRecipeList.add("$category/$recipeName");
    notifyListeners();
  }


  removeFromDeleteList(String recipeName) {
    deleteRecipeList.remove(recipeName);
    notifyListeners();
  }

  deleteFromDB() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Recipes");
    for (int i = 0; i < deleteRecipeList.length; i++) {
      String input = deleteRecipeList[i];
      List<String> parts = input.split('/');
      String category = parts[0];
      String name = parts[1];
      print("Name: $name");
      print("Category: $category");
      print("path: $category/$name");
      await ref.child(category).child(name).remove().then((value) {
        Utils.showToast("$name is Removed ");
      }).catchError((error) {
        Utils.showToast("$name is not removed");
        print(error.toString());
      });
    }
    deleteRecipeList.clear();
    //  10/06/23 Saturday
  }

}


    
