import 'package:flutter/material.dart';
import 'package:foodzik/admin%20pages/add_recipe/recipe_image.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/back_button.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/forground_img.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/ingrediants_tile.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:foodzik/my_widgets/my_edit_text.dart';
import 'package:foodzik/provider%20classes/image_provider.dart';
import 'package:foodzik/provider%20classes/theme_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    final modelTheme=Provider.of<ModelTheme>(context);
    bool isThemeDark=modelTheme.isDark;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
      leading: const BackLeadingBtn(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
           ForegroundRecipeImg(size: size),
            const SizedBox(height: 5,),
            const SizedBox(height: 5,),
            RecipeImage(size: size,),
            Center(child: Text("Add Ingredients",style: GoogleFonts.aBeeZee(fontSize: 21,fontWeight: FontWeight.bold))),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: IngredientsListWidget(size: size,),
            ),
            const Divider(color: Colors.grey,height: 1,thickness: 1),
            const SizedBox(height: 10,),
            Center(child: Text("Add Recipe Details",style: GoogleFonts.aBeeZee(fontSize: 21,fontWeight: FontWeight.bold))),
            Form(
              key: AddRecipePage._formKey,
                child:Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    //name
                    MyEditText(
                        child: TextFormField(
                          style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,fontSize: 18),
                          decoration:   InputDecoration(
                            border: InputBorder.none,
                            hintText: "Name",
                            hintStyle: TextStyle(color: isThemeDark?Colors.white70:Colors.black54,fontSize: 18),
                          ),
                        )),
                    MyEditText(
                        child: TextFormField(
                          style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,fontSize: 18),
                          decoration:   InputDecoration(
                            border: InputBorder.none,
                            hintText: "Price",
                            hintStyle: TextStyle(color: isThemeDark?Colors.white70:Colors.black54,fontSize: 18),
                          ),
                        )),
                    MyEditText(
                        child: TextFormField(
                          style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,fontSize: 18),
                          decoration:   InputDecoration(
                            border: InputBorder.none,
                            hintText: "Category",
                            hintStyle: TextStyle(color: isThemeDark?Colors.white70:Colors.black54,fontSize: 18),
                          ),
                        )),
                    MyEditText(
                        child: TextFormField(
                          style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,fontSize: 18),
                          decoration:   InputDecoration(
                            border: InputBorder.none,
                            hintText: "Time to bake",
                            hintStyle: TextStyle(color: isThemeDark?Colors.white70:Colors.black54,fontSize: 18),
                          ),
                        )),
                    MyEditText(
                        child: TextFormField(
                          style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,fontSize: 18),
                          decoration:   InputDecoration(
                            border: InputBorder.none,
                            hintText: "Per person",
                            hintStyle: TextStyle(color: isThemeDark?Colors.white70:Colors.black54,fontSize: 18),
                          ),
                        )),
                  ],
                ),) ),
            //ADD Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
              child: MyButton(onTap: (){
                final imageProviderClass=Provider.of<ImageProviderClass>(context,listen: false);
                if(imageProviderClass.recipeImagePath!=null){
                  print(imageProviderClass.recipeImagePath);
                }
              }, title: "ADD",fontSize: 21,padding: 10),
            ),
          ],
        ),
      ),
    );
  }
}
