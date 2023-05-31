import 'package:flutter/material.dart';
import 'package:foodzik/admin%20pages/add_recipe/recipe_image.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/back_button.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/forground_img.dart';
import 'package:google_fonts/google_fonts.dart';


class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
      leading: const BackLeadingBtn(),
        actions:  [
          //get foreground image icon
         GetForegroundImgBtn(imagePath: (foregroundImagePath) {  },),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
           ForegroundRecipeImg(size: size),
            const SizedBox(height: 5,),
            Center(child: Text("Add Your Recipe",style: GoogleFonts.aBeeZee(fontSize: 25,fontWeight: FontWeight.bold))),
            const SizedBox(height: 5,),
            RecipeImage(size: size, imagePath: (imagePath){},),
          ],
        ),
      ),
    );
  }
}
