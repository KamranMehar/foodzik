import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/provider%20classes/ingredients_provider.dart';
import 'package:foodzik/utils/add_reci_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

import 'package:provider/provider.dart';


class IngredientsListWidget extends StatelessWidget {
  Size size;
  IngredientsListWidget({Key? key,required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 170,
      width: size.width,
      child: Consumer<IngredientsProvider>(
        builder: (context,ingredientProvider,_) {
          print(ingredientProvider.ingredientList);
          if(ingredientProvider.ingredientList!.isNotEmpty){
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ingredientProvider.ingredientList!.length + 1, // Add 1 for the InkWell
            itemBuilder: (context, index) {
              if (index == 0) {
                // Show InkWell for the first item
                return InkWell(
                  onTap: () {
                    showDialog(
                      barrierDismissible: true, // false, //Tap outside the dialog to dismiss
                      context: context,
                      builder: (BuildContext context) => AddRecipeDialog(),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    height: 170,
                    width: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xffE4E4E4),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      CupertinoIcons.add,
                      color: Colors.black,
                      size: 60,
                    ),
                  ),
                );
              } else {
                // Show IngredientTile for the remaining items
                final ingredient = ingredientProvider.ingredientList![index - 1]; // Subtract 1 to account for the InkWell
                return IngredientTile(
                  name: ingredient.name ?? "",
                  quantity: ingredient.quantity.toString() ?? "",
                  unit: ingredient.unit ?? "",
                  image: ingredient.image ?? "",
                );
              }
            },
          );
          }else{
           return Row(
             children: [
               //add Recipe Template
               InkWell(
                 onTap: (){
                   showDialog(
                       barrierDismissible: false,//false, //Tap outside the dialog to dismiss
                       context: context, builder: (BuildContext context)=> AddRecipeDialog());
                 },
                 child: Container(
                   margin: const EdgeInsets.only(left: 5),
                   height: 170,
                   width: 120,
                   decoration:BoxDecoration(
                     color: const Color(0xffE4E4E4),
                     borderRadius: BorderRadius.circular(25),
                   ),
                   child: const Icon(CupertinoIcons.add,color: Colors.black,size: 60,),
                 ),
               ),
               IngredientTile(name: "Name", quantity: "Quantity", unit: "Unit", image: null),
             ],
           );
          }
        }
      ),
    );
  }
}

//Ingredients Tile reusable
class IngredientTile extends StatelessWidget {
  String name;
  String quantity;
  String unit;
  String? image;

  IngredientTile({Key? key,required this.name,required this.quantity,required this.unit,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return   //Recipe Template
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            Container(
              height: 170,
              width: 120,
              decoration:BoxDecoration(
                color: const Color(0xffE4E4E4),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            Container(
              height: 113,
              width: 120,
              decoration: BoxDecoration(
                color: const Color(0xff9DABA9),
                borderRadius: BorderRadius.circular(25),
              ),
              child:image!=null?
                  ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.file(File(image!),fit: BoxFit.cover,))
                  :  const Icon(Icons.image,color: Colors.white,size: 60,),
            ),
            Positioned(
              bottom: 0,
              left: 10,
              right: 10,
              child: SizedBox(
                height: 57,
                width: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(name,style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,),
                    Text(quantity,style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 16),),
                    Text(unit,style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 14),),
                  ],
                ),
              ),
            )
          ],
        ),
      );
  }
}

