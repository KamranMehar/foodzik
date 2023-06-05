import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model classes/Recipe.dart';

class RecipeTile extends StatelessWidget {
  bool isThemeDark;
  String name;
  int price;
  String image;

   RecipeTile({Key? key,required this.isThemeDark,required this.name,required this.price,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(name);
    print(price.toString());
    return SizedBox(
      height: 260,//size.height* 1/10,
      width: 155,//size.width* 4/10,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 145,
              height: 160,//size.height* ((1/10)/2),
              decoration: BoxDecoration(
                color: isThemeDark?Colors.grey.shade700:Colors.grey.shade500,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Spacer(flex: 4),
                 Text(name,style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black),),
                  Text(price.toString(),style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black)),
                  Spacer()
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 200,//size.height* ((1/10)/2),
              width: 155,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image.toString())),
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
