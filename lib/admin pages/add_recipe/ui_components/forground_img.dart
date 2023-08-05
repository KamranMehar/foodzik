import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider classes/image_provider.dart';


class ForegroundRecipeImg extends StatelessWidget {
final  Size size;
   const ForegroundRecipeImg({Key? key,required this.size,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return  Stack(
    children: [
      Consumer<ImageProviderClass>(
            builder: (context,imageProvider,_) {
               if(imageProvider.foregroundImagePath!=null) {
                return
                  Container(
                    height: size.height * 4 / 10,
                    width: size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(imageProvider.foregroundImagePath.toString())),
                        fit: BoxFit.cover, // Set the desired BoxFit
                      ),
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(80)),
                    ),
                  );
              }else{
                return
                  Container(
                    height: size.height * 4 / 10,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(80)),
                    ),
                  );
              }
            }
        ),
      Positioned(
          right: 0,
          bottom: 10,
          child: GetForegroundImgBtn()),
    ],
  );

  }
}

class GetForegroundImgBtn extends StatelessWidget {
   GetForegroundImgBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final imageProvider_= Provider.of<ImageProviderClass>(context,listen: false);
    return  Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          border: Border.all(color: isDarkTheme?Colors.white:Colors.black,width: 1),
          shape: BoxShape.circle
      ),
      child: IconButton(onPressed: (){
        imageProvider_.pickImageFromGallery();
      }, icon: Icon(CupertinoIcons.camera_fill,size: 30,color: isDarkTheme?Colors.white:Colors.black,)),
    );
  }
}
