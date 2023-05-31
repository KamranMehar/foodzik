import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageProviderClass with ChangeNotifier {
  String? _imagePath;

  String? get imagePath => _imagePath;

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _imagePath = pickedImage.path;
      notifyListeners();
    }
  }

  void clearImage() {
    _imagePath = null;
    notifyListeners();
  }
}
