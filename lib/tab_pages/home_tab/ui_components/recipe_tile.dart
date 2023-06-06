import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer' as developer show log;
import '../../../model classes/Recipe.dart';

class RecipeTile extends StatelessWidget {
  bool isThemeDark;
  String name;
  int price;
  String image;
  Map recipeMap;
   RecipeTile({Key? key,required this.isThemeDark,required this.name,required this.price,
     required this.image,required this.recipeMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    developer.log(recipeMap.toString());

    return SizedBox(
      /*height: 100,//size.height* 1/10,
      width: 100,//size.width* 4/10,*/
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 145,
              height: 160,//size.height* ((1/10)/2),
              decoration: BoxDecoration(
                color: isThemeDark?Colors.grey.shade700:Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Spacer(flex: 5),
                 Text(name,style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,
                     fontSize: 22,fontWeight: FontWeight.bold),
                 overflow: TextOverflow.ellipsis,),
                  Text("Rs:/ $price",
                      style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,fontSize: 18),
                  overflow: TextOverflow.ellipsis,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(CupertinoIcons.time_solid,color: isThemeDark?Colors.white:Colors.black,size: 20,),
                      Text(recipeMap['timeToBake'],
                          style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,fontSize: 14),
                      overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                  Spacer()
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 165,//size.height* ((1/10)/2),
              width: 165,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image.toString()),),
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),

            ),
          ),

        ],
      ),
    );
  }
}
