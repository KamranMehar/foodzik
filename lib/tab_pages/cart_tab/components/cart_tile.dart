import 'package:flutter/material.dart';
import 'package:foodzik/provider%20classes/theme_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CartTile extends StatelessWidget {
  const CartTile({Key? key, required this.onDelete, required this.recipeMap}) : super(key: key);
  final VoidCallback onDelete;
  final Map recipeMap;
  @override
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ModelTheme>(context);
     bool isThemeDark=themeProvider.isDark;
    
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: isThemeDark?Colors.white:Colors.black,width: 1),
            borderRadius: BorderRadius.circular(25),
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
        Text("${recipeMap["name"]}",style: GoogleFonts.abel(fontSize: 20.sp,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
        Text("for ${recipeMap["perPerson"]} Persons",style: GoogleFonts.abel(fontSize: 18.sp),overflow: TextOverflow.ellipsis),
        Text("RS:/ ${recipeMap["price"]}",style: GoogleFonts.abel(fontSize: 18.sp),overflow: TextOverflow.ellipsis),
      ],
    ),
    );
  }
}
