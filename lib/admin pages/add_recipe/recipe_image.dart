import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodzik/provider%20classes/image_provider.dart';
import 'package:foodzik/theme/colors.dart';
import 'package:provider/provider.dart';

class RecipeImage extends StatelessWidget {
  Size size;
  Function(String?) imagePath;
  RecipeImage({Key? key,required this.size,required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: size.width* (3/5),
      width: size.width* 9/10,
      child: Consumer<ImageProviderClass>(
        builder: (context,imageProvider,_) {
          return Stack(
            children: [
              Positioned(
                right: 0,
                top: 20,
                bottom: 20,
                child: Container(
                  padding: EdgeInsets.only(left: size.width* 1/3),
                  height: size.width* 2/6,
                  width: size.width* 4/6,
                  decoration: const BoxDecoration(
                    color: greenPrimary,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80),topLeft: Radius.circular(80)),
                  ),
                  child: IconButton(onPressed: (){
                      imageProvider.pickRecipeImage();
                      imagePath(imageProvider.recipeImagePath);
                  },icon:const Icon(Icons.camera_alt_rounded,size: 35,)),
                ),
              ),
               Positioned(
                left: 10,
                bottom: 0,
                top: 0,
                child:  Builder(
                  builder: (context) {
                    if(imageProvider.recipeImagePath!=null) {
                      return CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.transparent,
                        foregroundImage: FileImage(File(imageProvider.recipeImagePath??"")),
                      );
                    }else{
                      return const CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.transparent,
                      );
                    }
                  }
                )

                ),
            ],
          );
        }
      ),
    );
  }
}
