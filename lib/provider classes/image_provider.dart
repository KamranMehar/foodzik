import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageProviderClass with ChangeNotifier {
  String? _foregroundImagePath;
  String? _recipeImagePath;
  String? _ingredientImagePath;


  String get foregroundImagePath => _foregroundImagePath??"";

  set foregroundImagePath(String value) {
    _foregroundImagePath = value;
  }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _foregroundImagePath = pickedImage.path;
      notifyListeners();
    }
  }

  Future<void> pickRecipeImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _recipeImagePath = pickedImage.path;
      notifyListeners();
    }
  }
  Future<void> pickIngredientImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _ingredientImagePath = pickedImage.path;
      notifyListeners();
    }
  }
  void clearImages() {
    _foregroundImagePath = null;
    _recipeImagePath = null;
    notifyListeners();
  }
  void clearIngredientImage(){
    _ingredientImagePath=null;
    notifyListeners();
  }

  String get recipeImagePath => _recipeImagePath??"";

  set recipeImagePath(String? value) {
    _recipeImagePath = value;
  }

  String get ingredientImagePath => _ingredientImagePath??"";

  set ingredientImagePath(String value) {
    _ingredientImagePath = value;
  }
}
