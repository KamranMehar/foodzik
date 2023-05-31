import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageProviderClass with ChangeNotifier {
  String? _foregroundImagePath;
  String? _recipeImagePath;

  String? get recipeImagePath => _recipeImagePath;
  String? get foregroundImagePath => _foregroundImagePath;

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

  void clearImage() {
    _foregroundImagePath = null;
    notifyListeners();
  }
}
