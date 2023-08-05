import 'package:flutter/material.dart';
import 'package:foodzik/const/colors.dart';
import 'package:foodzik/pages/recipe_details_screen/components/tabs/ingredient_tab.dart';
import 'package:foodzik/provider%20classes/theme_model.dart';
import 'package:foodzik/tab_pages/cart_tab/components/cart_ingredient_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CartTile extends StatelessWidget {
  const CartTile({Key? key,
    required this.onDelete,
    required this.recipeMap}) : super(key: key);
  final VoidCallback onDelete;
  final Map recipeMap;
  @override
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ModelTheme>(context);
     bool isThemeDark=themeProvider.isDark;
    List<Map<dynamic, dynamic>> ingredients=List<Map<dynamic, dynamic>>.from(recipeMap['ingredients']);

    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: isThemeDark?Colors.white:Colors.black,width: 1),
            borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          image: NetworkImage(recipeMap["imageForeground"]),
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
            child: Image.network(recipeMap["image"]),
          ),
          IconButton(onPressed: onDelete,
              icon: Icon(Icons.delete,size: 25.sp,))
        ],
        ),
        Text("${recipeMap["name"]}",
          style: GoogleFonts.abel(fontSize: 20.sp,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
        Text("for ${recipeMap["perPerson"]} Persons",
            style: GoogleFonts.abel(fontSize: 18.sp),overflow: TextOverflow.ellipsis),
        Text("RS:/ ${recipeMap["price"]}",
            style: GoogleFonts.abel(fontSize: 18.sp),overflow: TextOverflow.ellipsis),
        SizedBox(
          height: 15.h,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: ingredients.length,
              itemBuilder: (context,index){
                return CartIngredientTile(
                    name: ingredients[index]["name"],
                    quantity: ingredients[index]["quantity"],
                    image: ingredients[index]["image"],
                    isThemeDark: isThemeDark,
                    unit: ingredients[index]["unit"],
                    price: ingredients[index]["price"],
                );

          }),
        )
      ],
    ),
    );
  }
}
