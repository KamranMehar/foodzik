import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodzik/provider%20classes/image_provider.dart';
import 'package:provider/provider.dart';

class ForegroundRecipeImg extends StatefulWidget {
  Size size;
   ForegroundRecipeImg({Key? key,required this.size}) : super(key: key);

  @override
  State<ForegroundRecipeImg> createState() => _ForegroundRecipeImgState();
}

class _ForegroundRecipeImgState extends State<ForegroundRecipeImg> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ImageProviderClass>(
      builder: (context,imageProvider,_) {

        final imagePath = imageProvider.imagePath;
        return InkWell(
          onTap: (){
            imageProvider.pickImageFromGallery();
          },
          child: Container(
            height: widget.size.height * 4 / 10,
            width: widget.size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imagePath != null ? FileImage(File(imagePath)) as ImageProvider<Object> // Explicit casting
                    : const NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/foodzik-61d17.appspot.com/o/UsersImages%2F149309150_2770636779916453_2611855383541858058_n%20(1).jpg?alt=media&token=05d3359d-4816-4ab6-a355-1e363c0ea006&_gl=1*1ywjyvn*_ga*MTAyODIyMzYxOC4xNjY5NjYxNDM1*_ga_CW55HF8NVT*MTY4NTUxMzk5NS4yNS4xLjE2ODU1MTQwODYuMC4wLjA."),
                fit: BoxFit.cover,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
            ),
          ),
        );
      }
    );
  }
}
