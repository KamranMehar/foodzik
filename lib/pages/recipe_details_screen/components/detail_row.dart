import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/provider%20classes/theme_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer'as developer show log;

import 'package:provider/provider.dart';

class DetailRowRecipe extends StatelessWidget {
  final bool isThemeDark;
  final Map recipeMap;
   const DetailRowRecipe({Key? key,required this.isThemeDark,required this.recipeMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String timeToBake=recipeMap['timeToBake'];
    String hours = timeToBake.substring(0, 2);
    String minutes = timeToBake.substring(2, 4);
    List<Map<dynamic, dynamic>> ingredientsList = List<Map<dynamic, dynamic>>.from(recipeMap['ingredients']);

    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconUnderTextWidget(
          icon: SizedBox(
            height: 25,width: 25,
          child: Image.asset("assets/chef_hat.png",color: isThemeDark?Colors.white70:Colors.grey.shade800,),),
        text: recipeMap['difficulty'],
        ),
        IconUnderTextWidget(
          icon: SizedBox(
            height: 25,width: 25,
          child: Icon(CupertinoIcons.time,color: isThemeDark?Colors.white70:Colors.grey.shade800,),),
        text: "${hours=="00"?"":"$hours hr"} ${minutes=="00"?"":"$minutes min"}",
        ),
        IconUnderTextWidget(
          icon: SizedBox(
            height: 25,width: 25,
          child: Icon(CupertinoIcons.person_2,color: isThemeDark?Colors.white70:Colors.grey.shade800,),),
        text: recipeMap['perPerson'].toString(),
        ),
        IconUnderTextWidget(
          icon: SizedBox(
            height: 25,width: 25,
          child: Image.asset("assets/ingredient_no.png",color: isThemeDark?Colors.white70:Colors.grey.shade800,),),
        text: ingredientsList.length.toString(),
        ),
      ],
    );
  }
}

class IconUnderTextWidget extends StatelessWidget {
  const IconUnderTextWidget({Key? key,
    required this.icon,
  required this.text,
    this.fontSize=16,
    }) : super(key: key);
 final Widget icon;
 final String text;
 final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        Text(text,style: GoogleFonts.robotoMono(fontSize: fontSize),)
      ],
    );
  }
}
