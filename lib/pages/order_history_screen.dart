import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:developer' as log show log;
import '../const/colors.dart';
import '../model classes/Recipe.dart';
import '../model classes/ingredient.dart';
import '../model classes/steps_to_bake.dart';
import '../my_widgets/my_button.dart';
import '../provider classes/theme_model.dart';
import '../tab_pages/cart_tab/components/cart_ingredient_tile.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  bool isLoading=false;
  String uId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final ref=FirebaseDatabase.instance.ref("Users/$uId/OrderHistory");
    final themeProvider=Provider.of<ModelTheme>(context);
    bool isThemeDark=themeProvider.isDark;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Order History",
          style: GoogleFonts.aBeeZee(color: greenTextColor, fontSize: 20.sp),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 30,
            )),
      ),
      body: StreamBuilder(
        stream: ref.onValue,
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot){
          if(!snapshot.hasData){
            return  const Center(child: CircularProgressIndicator(color: greenPrimary,strokeWidth: 1,),);
          }else if(snapshot.hasError){
            return const Center(child: Text("Something went wrong\nTry again"),);
          }else{
            //if data found
            Map<dynamic, dynamic>? map = snapshot.data!.snapshot
                .value as dynamic;
            List<dynamic> list = [];
            list.clear();
            if(map!=null){
              list = map.values.toList();
              List<Recipe> recipes=[];
                List<Recipe> updatedRecipes = [];
                for (int i = 0; i < list.length; i++) {
                  List<StepsToBake> stepsToBakeList = [];
                  for (var step in list[i]['steps']) {
                    StepsToBake stepToBake = StepsToBake(
                      title: step['title'],
                      details: step['details'],
                    );
                    stepsToBakeList.add(stepToBake);
                  }

                  List<Ingredient> ingredientsList = [];
                  for (var ingredient in list[i]['ingredients']) {
                    Ingredient ingredientObj = Ingredient(
                      quantity: ingredient['quantity'],
                      name: ingredient['name'],
                      image: ingredient['image'],
                      price: ingredient['price'],
                      unit: ingredient['unit'],
                    );
                    ingredientsList.add(ingredientObj);
                  }

                  Recipe recipe = Recipe(
                    name: list[i]['name'],
                    imageForeground: list[i]['imageForeground'],
                    image: list[i]['image'],
                    price: list[i]['price'],
                    category: list[i]['category'],
                    ingredients: ingredientsList,
                    timeToBake: list[i]['timeToBake'],
                    perPerson: list[i]['perPerson'],
                    stepsToBakeList: stepsToBakeList,
                    difficulty: list[i]['difficulty'],
                    info: list[i]['info'],
                  );

                  updatedRecipes.add(recipe);
                }

                recipes = updatedRecipes;

              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Total Orders :",style: GoogleFonts.aBeeZee(fontSize: 18.sp)),
                        const Spacer(),
                        Text(recipes.length.toString(),style: GoogleFonts.aBeeZee(fontSize: 18.sp),)
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: recipes.length,
                          itemBuilder: (context,index){
                            Recipe recipe=recipes[index];
                            return Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: isThemeDark?Colors.white:Colors.black,width: 1),
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                  image: NetworkImage(recipe.imageForeground??""),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.6),
                                    BlendMode.darken,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 30.w,
                                        width: 30.w,
                                        child: Image.network(recipe.image??""),
                                      ),
                                    ],
                                  ),
                                  Text("${recipe.name}",
                                    style: GoogleFonts.abel(fontSize: 20.sp,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                                  Text("for ${recipe.perPerson} Persons",
                                      style: GoogleFonts.abel(fontSize: 18.sp),overflow: TextOverflow.ellipsis),
                                  Text("RS:/ ${recipe.price}",
                                      style: GoogleFonts.abel(fontSize: 18.sp),overflow: TextOverflow.ellipsis),
                                  SizedBox(
                                    height: 15.h,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: recipe.ingredients!.length,
                                        itemBuilder: (context,index){
                                          Ingredient ingredient=recipe.ingredients![index];
                                          return CartIngredientTile(
                                            showImage: true,
                                            name: ingredient.name??"",
                                            quantity: ingredient.quantity!.toInt(),
                                            image: ingredient.image??"",
                                            isThemeDark: isThemeDark,
                                            unit: ingredient.unit??"",
                                            price: ingredient.price??0,
                                          );
                                        }),
                                  )
                                ],
                              ),
                            );
                      }),
                    ),
                  ],
                ),
              );
            }else{
              return const Center(child: Text("No Order Found"),);
            }
          }
        },
      )
    );
  }

}
