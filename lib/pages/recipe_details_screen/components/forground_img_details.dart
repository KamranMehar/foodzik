import 'package:flutter/material.dart';
import '../../home/ui_componets/shimmar_effect.dart';
import 'bookmark.dart';

class ForegroundImageDetailPage extends StatelessWidget {
   const ForegroundImageDetailPage({Key? key,required this.recipeMap,required this.size}) : super(key: key);
  final Map? recipeMap;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 3.5/10,
      width: size.width,
      decoration: const BoxDecoration(
      //  color: Colors.transparent,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
      ),
      child: Stack(
        fit:StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(80)),
            child: Image.network(
              recipeMap!["imageForeground"],
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return
                    ShimmerEffect(height: size.height * 4 / 10,
                      width: size.width,isCircular: false,);
                }
              },
            ),
          ),
          Positioned(
            right: 12,
            bottom: 12,
            child: BookmarkRecipe(recipe: recipeMap??{}),
          ),

        ],
      ),
    );
  }
}
