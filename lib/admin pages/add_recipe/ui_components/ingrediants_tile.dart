import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/provider%20classes/ingredients_provider.dart';
import 'package:foodzik/utils/add_ingredient_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

import 'package:provider/provider.dart';

import '../../../model classes/ingredient.dart';


class IngredientsListWidget extends StatelessWidget {
 final Size size;
  const IngredientsListWidget({Key? key,required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 235,
      width: size.width,
      child: Consumer<IngredientsProvider>(
        builder: (context,ingredientProvider,_) {
          if(ingredientProvider.ingredientList!.isNotEmpty){
            int totalPrice = ingredientProvider.getTotalPrice();
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Center(child: Text("Ingredients Total Price: $totalPrice",),),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ingredientProvider.ingredientList!.length + 1, // Add 1 for the InkWell
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // Show InkWell for the first item
                      return const AddIngredient();
                    } else {
                      // Show IngredientTile for the remaining items
                      final ingredient = ingredientProvider.ingredientList![index - 1]; // Subtract 1 to account for the InkWell
                      return IngredientExampleTile(
                        ingredient: ingredient,
                        provider: ingredientProvider,
                      );
                    }
                  },
                ),
              ),
            ],
          );
          }else{
            ///Template
           return const Row(
             children: [
               //add Recipe Template
             AddIngredient(),
              // IngredientTile(name: "Name", quantity: "Quantity", unit: "Unit", image: null),
               IngredientTemplate(),
             ],
           );
          }
        }
      ),
    );
  }
}

class IngredientExampleTile extends StatelessWidget {
 final Ingredient ingredient;
 final IngredientsProvider provider;
  const IngredientExampleTile({Key? key,
    required this.ingredient,
    required this.provider
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return   //Recipe Template
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            Container(
              height: 235,
              width: 150,
              decoration:BoxDecoration(
                color: const Color(0xffE4E4E4),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            Positioned(
              top: 5,
              left: 5,
              right: 5,
              child: Container(
                height: 145,
                width: 145,
                decoration: BoxDecoration(
                  color: const Color(0xff9DABA9),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ingredient.image != null
                    ? ingredient.image!.startsWith('http') // Check if it's a network URL
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    ingredient.image!,
                    fit: BoxFit.contain,
                    errorBuilder: (context,obh,st){
                      return const Icon(Icons.error,color: Colors.red,);
                    },
                  ),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                    child: Image.file(
                    File(ingredient.image!),
                    fit: BoxFit.contain,
                  ),
                )
                    : const Icon(Icons.image, color: Colors.white, size: 60),

              ),
            ),
            Positioned(
              bottom: 0,
              left: 10,
              right: 10,
              child: SizedBox(
                height: 70,
                width: 145,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(ingredient.name??"",style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,),
                      Text((ingredient.quantity??"").toString(),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 16),),
                      Text((ingredient.unit??"").toString(),
                          overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 14),),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                child:  InkWell(
                  onTap: (){
                    provider.deleteIngredient(ingredient);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          offset: Offset(-3, 3),
                          blurRadius: 8,
                          spreadRadius: 3
                        )
                      ],
                      shape: BoxShape.circle,
                      color: Color(0xffE4E4E4),
                    ),
                    child: const Icon(CupertinoIcons.clear,color:Colors.red,size: 16,),
                  ),
                ))
          ],
        ),
      );
  }
}

class IngredientTemplate extends StatelessWidget {
  const IngredientTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Container(
            height: 235,
            width: 150,
            decoration:BoxDecoration(
              color: const Color(0xffE4E4E4),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            right: 5,
            child: Container(
              height: 145,
              width: 145,
              decoration: BoxDecoration(
                color: const Color(0xff9DABA9),
                borderRadius: BorderRadius.circular(25),
              ),
              child:
              const Icon(Icons.image,color: Colors.white,size: 60,),
            ),
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
                  Text("Name",style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,),
                  Text("Quantity",style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 16),),
                  Text("Unit",style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 14),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AddIngredient extends StatelessWidget {
  const AddIngredient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      height: 235,
      width: 150,
      child: InkWell(
        onTap: (){
          showDialog(
              barrierDismissible: true,//false, //Tap outside the dialog to dismiss
              context: context, builder: (BuildContext context)=> AddRecipeDialog());
        },
        child: Container(
          margin: const EdgeInsets.only(left: 8),
          decoration:BoxDecoration(
            color: const Color(0xffE4E4E4),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Icon(CupertinoIcons.add,color: Colors.black,size: 60,),
        ),
      ),
    );
  }
}
