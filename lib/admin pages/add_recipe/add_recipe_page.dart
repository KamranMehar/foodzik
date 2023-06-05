import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/categories_drop_menu.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/recipe_image.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/back_button.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/forground_img.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/ingrediants_tile.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:foodzik/admin%20pages/add_recipe/ui_components/steps_template.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/steps_widget.dart';
import 'package:foodzik/model%20classes/Recipe.dart';
import 'package:foodzik/model%20classes/ingredient.dart';
import 'package:foodzik/model%20classes/steps_to_bake.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:foodzik/my_widgets/my_edit_text.dart';
import 'package:foodzik/provider%20classes/baking_steps_provider.dart';
import 'package:foodzik/provider%20classes/image_provider.dart';
import 'package:foodzik/provider%20classes/ingredients_provider.dart';
import 'package:foodzik/provider%20classes/theme_model.dart';
import 'package:foodzik/utils/add_reci_dialog.dart';
import 'package:foodzik/utils/dialogs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);
  static final GlobalKey<FormState> _formKey =  GlobalKey<FormState>();
  static final GlobalKey<FormState> _formKeySec =  GlobalKey<FormState>();

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final nameController=TextEditingController();
  final priceController=TextEditingController();
  final personsController=TextEditingController();
  final titleController=TextEditingController();
  final descriptionController=TextEditingController();

  String? timeToBake;
  String? category;
  bool isLoading=false;
  Widget nameEditText(){
    final modelTheme=Provider.of<ModelTheme>(context);
    bool isThemeDark=modelTheme.isDark;
    return  //name
      MyEditText(
          child: TextFormField(
            controller: nameController,
            style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,fontSize: 18),
            decoration:   InputDecoration(
              border: InputBorder.none,
              hintText: "Name",
              hintStyle: TextStyle(color: isThemeDark?Colors.white70:Colors.black54,fontSize: 18),
            ),
            textInputAction: TextInputAction.next,
            validator: (value){
              if(nameController.text.isEmpty){
                return "   Name is Empty";
              }
              return null;
            },
          ));
  }
  Widget priceEditText(){
    final modelTheme=Provider.of<ModelTheme>(context);
    bool isThemeDark=modelTheme.isDark;
    return MyEditText(
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: priceController,
          style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,fontSize: 18),
          decoration:   InputDecoration(
            border: InputBorder.none,
            hintText: "Price",
            hintStyle: TextStyle(color: isThemeDark?Colors.white70:Colors.black54,fontSize: 18),
          ),
          textInputAction: TextInputAction.next,
          validator: (value){
            if(priceController.text.isEmpty){
              return "   Price is Empty";
            }
            return null;
          },
        ));
  }
  Widget perPersonEditText(){
    final modelTheme=Provider.of<ModelTheme>(context);
    bool isThemeDark=modelTheme.isDark;
    return MyEditText(
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: personsController,
          textInputAction: TextInputAction.done,
          style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,fontSize: 18),
          decoration:   InputDecoration(
            border: InputBorder.none,
            hintText: "Per person",
            hintStyle: TextStyle(color: isThemeDark?Colors.white70:Colors.black54,fontSize: 18),
          ),
          validator: (value){
            if(personsController.text.isEmpty){
              return "   Per Person is Empty";
            }
            return null;
          },
        ));
  }
  Widget titleEditText(){
    final modelTheme=Provider.of<ModelTheme>(context);
    bool isThemeDark=modelTheme.isDark;
    return MyEditText(
        child: TextFormField(
          controller: titleController,
          textInputAction: TextInputAction.next,
          style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,fontSize: 18),
          decoration:   InputDecoration(
            border: InputBorder.none,
            hintText: "Title",
            hintStyle: TextStyle(color: isThemeDark?Colors.white70:Colors.black54,fontSize: 18),
          ),
          validator: (value){
            if(titleController.text.isEmpty){
              return "   Title is Empty";
            }
            return null;
          },
        ));
  }
  Widget descriptionEditText(){
    final modelTheme=Provider.of<ModelTheme>(context);
    bool isThemeDark=modelTheme.isDark;
    return MyEditText(
        child: TextFormField(
          controller: descriptionController,
          textInputAction: TextInputAction.done,
          style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,fontSize: 18),
          decoration:   InputDecoration(
            border: InputBorder.none,
            hintText: "Description",
            hintStyle: TextStyle(color: isThemeDark?Colors.white70:Colors.black54,fontSize: 18),
          ),
          validator: (value){
            if(titleController.text.isEmpty){
              return "   Description is Empty";
            }
            return null;
          },
        ));
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    final modelTheme=Provider.of<ModelTheme>(context);
    bool isThemeDark=modelTheme.isDark;
    final stepsProvider=Provider.of<BakingStepsProvider>(context,listen: false);
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
            RecipeImage(size: size,isThemeDark: isThemeDark,),
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
                   nameEditText(),
                    //price
                    priceEditText(),
                    //Per Person
                    perPersonEditText(),
                  ],
                ),) ),
            StepsWidget(),
            Form(
                key: AddRecipePage._formKeySec,
                child:Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Center(child: Text("Add Steps To Bake",style: GoogleFonts.aBeeZee(fontSize: 21,fontWeight: FontWeight.bold))),
                      titleEditText(),
                      descriptionEditText(),
                    ],
                  ),) ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 50),
              child: LoadingButton(
                  text: "Add Step", click: (){
                if(AddRecipePage._formKeySec.currentState!.validate()){
                  StepsToBake stepsToBake=StepsToBake(title: titleController.text,details: descriptionController.text);
                   stepsProvider.addStep(stepsToBake);
                   titleController.clear();
                   descriptionController.clear();
                }
              }),
            ),
            const SizedBox(height: 10,),
            TimeInputButton(
                isThemeDark: isThemeDark, size: size,
                onInputTimeDone: (value){
                  timeToBake=value;
                }),
            Center(
              child: SizedBox(
                width: size.width* 3/5,
                child: MyEditText(
                  child: Center(
                    child: CategoryDropDownMenu(
                      onChanged: (value){
                       category=value;
                      }, isThemeDark: isThemeDark,
                    ),
                  ),
                ),
              ),
            ),
            //ADD Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
              child: LoadingButton(
                  isLoading: isLoading,
                  click: (){
                if(AddRecipePage._formKey.currentState!.validate()) {
                  final imageProviderClass = Provider.of<ImageProviderClass>(context, listen: false);
                  final ingredientProviderClass = Provider.of<IngredientsProvider>(context, listen: false);
                  final stepsProvider = Provider.of<BakingStepsProvider>(context, listen: false);
                  if (imageProviderClass.recipeImagePath == null) {
                   Utils.showToast("Add Recipe Image");
                  }else if(imageProviderClass.foregroundImagePath ==null){
                    Utils.showToast("Add Foreground Image");
                  }else if(timeToBake==null){
                    Utils.showToast("Add Time To Bake");
                  }else if(category==null){
                    Utils.showToast("Select Category");
                  }else if(ingredientProviderClass.ingredientList==null){
                    Utils.showToast("Add ingredients");
                  }else if(stepsProvider.stepsList!.isEmpty){
                    Utils.showToast("Add Steps To Bake");
                  }else{
                    setState(() {
                      isLoading=true;
                    });
                   String?  foregroundImageURL;
                   String?  recipeImageURL;
                    //Add Recipe to Database
                    getImageUrl(imageProviderClass.foregroundImagePath??"",
                      nameController.text,
                      "${nameController.text}_foregroundIMG"
                    ).then((value){
                      foregroundImageURL=value;
                      getImageUrl(imageProviderClass.recipeImagePath??"",
                          nameController.text,
                          "${nameController.text}_mainIMG").then((value)async{
                        recipeImageURL=value;
                        List<Ingredient>? ingredientList = ingredientProviderClass.ingredientList;
                        List<Ingredient> ingredientListWithURL=[];
                       // Recipe recipe=Recipe();
                        await Future.forEach(ingredientList as Iterable<Ingredient>, (Ingredient ingredient) async {
                         await getImageUrl(ingredient.image!,nameController.text,
                          "/ingredients/${ingredient.name!}_image").then((value){
                            Ingredient _ingredeint=ingredient;
                            _ingredeint.image=value;
                            ingredientListWithURL.add(_ingredeint);
                          });

                        }).then((value){
                          //ADD All Data to DB

                        List<StepsToBake>? bakingSteps=stepsProvider.stepsList;
                          Recipe recipe=Recipe(
                              name: nameController.text,
                              category: category,
                              timeToBake: timeToBake,
                              image: recipeImageURL,
                              imageForeground: foregroundImageURL,
                              price: int.tryParse(priceController.text),
                              ingredients: ingredientListWithURL,
                              perPerson: int.tryParse(personsController.text),
                              stepsToBakeList: bakingSteps
                          );
                          addRecipeToDB(recipe);
                        }).onError((error, stackTrace){
                          print(error.toString());
                          setState(() {
                            isLoading=false;
                          });
                        });

                      });
                    });
                  }
                }
              }, text: "ADD",),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> getImageUrl(String imagePath,String recipeName,String imageName) async {
    String filePath = imagePath;
    File file = File(filePath.toString());
    String? downloadUrl;
    try {
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref("Recipe/$recipeName/$imageName");
      firebase_storage.UploadTask imageUploadTask = storageRef.putFile(
          file.absolute);
      await Future.value(imageUploadTask).then((value) async {
        downloadUrl = await storageRef.getDownloadURL();
        return downloadUrl;
      }).onError((error, stackTrace) {
        setState(() {
          isLoading=false;
        });
        print(error.toString());
        return null;
      });
      return downloadUrl;
    }on FirebaseException catch (e){
      Utils.showAlertDialog("Something went wrong", context, e.message);
    }
    return null;
  }
  addRecipeToDB(Recipe recipe)async{
    DatabaseReference ref=FirebaseDatabase.instance.ref("Recipes/${recipe.category}/${recipe.name}");
    try{
      ref.set(recipe.toJson()).then((value){
        setState(() {
          isLoading=false;
        });
        final ingredientProvider=Provider.of<IngredientsProvider>(context,listen: false);
        final imageProvider=Provider.of<ImageProviderClass>(context,listen: false);
        final stepsProvider=Provider.of<BakingStepsProvider>(context,listen: false);
        ingredientProvider.clearIngredientList();
        imageProvider.clearImages();
        imageProvider.clearIngredientImage();
        stepsProvider.clearList();
        Utils.showToast("${recipe.name} is Added Successfully");
      }).onError((error, stackTrace){
        setState(() {
          isLoading=false;
        });
        print(error);
      });
    }on FirebaseException catch (e){
      Utils.showAlertDialog("Something went wrong", context,e.message );
    }

  }
}
