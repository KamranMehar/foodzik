import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer' as developer show log;
import '../utils/dialogs.dart';


class DeleteRecipeProvider with ChangeNotifier {
  List<String>deleteRecipeList = [];
  Map editRecipe={};

  addToDeleteList(String recipeName, String category) {
    deleteRecipeList.add("$category/$recipeName");
    notifyListeners();
  }

  addToEdit(Map recipe){

      editRecipe = recipe;
      notifyListeners();

  }

  removeFromDeleteList(String recipeName) {
    deleteRecipeList.remove(recipeName);
    editRecipe.clear();
    notifyListeners();
  }

  deleteFromDB() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Recipes");
    for (int i = 0; i < deleteRecipeList.length; i++) {
      String input = deleteRecipeList[i];
      List<String> parts = input.split('/');
      String category = parts[0];
      String name = parts[1];
      developer.log("Name: $name");
      developer.log("Category: $category");
      developer.log("path: $category/$name");
      await ref.child(category).child(name).remove().then((value) {
        ref.child("all").child(name).remove().then((value) {
          deleteDirectory("Recipe/$name");
          //Deleting second time with ingredients bcz Firebase storage does't have method to delete all under the path
          deleteDirectory("Recipe/$name/ingredients");
          Utils.showToast("$name is Removed ");

        }).onError((error, stackTrace){
          Utils.showToast("$name is not removed");
          developer.log(error.toString());
        });
      }).catchError((error) {
        developer.log(error.toString());
      });
    }
    deleteRecipeList.clear();
    editRecipe.clear();
    notifyListeners();
    developer.log(deleteRecipeList.toString());
    //  10/06/23 Saturday
  }
  void deleteDirectory(String directoryPath) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    try {
      Reference directoryReference = storage.ref().child(directoryPath);
      ListResult listResult = await directoryReference.listAll();

      for (Reference item in listResult.items) {
        await item.delete();
        developer.log('Item deleted: ${item.fullPath}');
      }

      developer.log('Directory and its contents deleted successfully.');
    } catch (e) {
      developer.log('Error deleting directory: $e');
    }
  }

}


    
