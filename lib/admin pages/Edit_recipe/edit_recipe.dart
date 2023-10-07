import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/provider%20classes/delete_recipe_provider.dart';
import 'package:foodzik/provider%20classes/theme_model.dart';
import 'package:foodzik/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:developer'as developer show log;
import '../../const/colors.dart';
import '../../model classes/Recipe.dart';
import '../../model classes/ingredient.dart';
import '../../model classes/steps_to_bake.dart';
import '../../my_widgets/my_button.dart';
import '../../my_widgets/my_edit_text.dart';
import '../../provider classes/baking_steps_provider.dart';
import '../../provider classes/image_provider.dart';
import '../../provider classes/ingredients_provider.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../utils/add_ingredient_dialog.dart';
import '../add_recipe/add_recipe_page.dart';
import '../add_recipe/ui_components/categories_drop_menu.dart';
import '../add_recipe/ui_components/defficulty_of_recipe.dart';
import '../add_recipe/ui_components/forground_img.dart';
import '../add_recipe/ui_components/ingrediants_tile.dart';
import '../add_recipe/ui_components/recipe_image.dart';
import '../add_recipe/ui_components/steps_widget.dart';



class EditRecipeScreen extends StatefulWidget {
  const EditRecipeScreen({super.key});

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
   final GlobalKey<FormState> _formKey =  GlobalKey<FormState>();
   final GlobalKey<FormState> _formKeySec =  GlobalKey<FormState>();

  Map? _recipeMap={};
  List<Map<dynamic, dynamic>> ingredients=[];

  final nameController=TextEditingController();
  final priceController=TextEditingController();
  final personsController=TextEditingController();
  final titleController=TextEditingController();
  final descriptionController=TextEditingController();
  final infoController=TextEditingController();

  String? timeToBake;
  String? category;
  String? difficulty;
  bool isLoading=false;
  bool isInitialized=false;

  @override
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ModelTheme>(context);
    bool isThemeDark=themeProvider.isDark;
    Size size=MediaQuery.of(context).size;
    final stepsProvider=Provider.of<BakingStepsProvider>(context,listen: false);

    return WillPopScope(
        onWillPop: ()async{
          return await _showDiscardDialog();
        },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.black26,
          leading:  InkWell(
            onTap: (){
             _showDiscardDialog();
            },
            child: Container(
              height: 30,
              width: 90,
              decoration:  const BoxDecoration(
                color: greenPrimary,
                borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight: Radius.circular(50)),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,size: 35,),
            ),
          ),

          centerTitle: true,
          title: Text("Edit Recipe",
            style: GoogleFonts.aBeeZee(fontSize: 21.sp,color: isThemeDark?Colors.white:Colors.black),),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ///Foreground Image
              ForegroundRecipeImg(size: size),
              const SizedBox(height: 5,),
              ///image
              RecipeImage(size: size,isThemeDark: isThemeDark,),

              Center(
                  child: Text("Add Ingredients",style: GoogleFonts.aBeeZee(fontSize: 21,fontWeight: FontWeight.bold))),
              ///Ingredients
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: IngredientsListWidget(size: size,),
              ),
              const Divider(color: Colors.grey,height: 1,thickness: 1),
              const SizedBox(height: 10,),
              Center(child: Text("Add Recipe Details",style: GoogleFonts.aBeeZee(fontSize: 21,fontWeight: FontWeight.bold))),
              Form(
                  key: _formKey,
                  child:Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        const Text('Name is Unchangeable'),
                        //name
                        MyEditText(
                          child: TextFormField(
                            readOnly: true,
                            controller: nameController,
                            style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,fontSize: 18),
                            decoration:   InputDecoration(
                              border: InputBorder.none,
                              hintText: "Name",
                              hintStyle: TextStyle(color: isThemeDark?Colors.white70:Colors.black54,fontSize: 18),
                            ),
                            textInputAction: TextInputAction.done,
                            validator: (value){
                              if(nameController.text.isEmpty){
                                return "   Name is Empty";
                              }
                              return null;
                            },
                          ),
                        ),
                        const Text('Price'),
                        //price
                        MyEditText(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: priceController,
                              style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,fontSize: 18),
                              decoration:   InputDecoration(
                                border: InputBorder.none,
                                hintText: "Price",
                                hintStyle: TextStyle(color: isThemeDark?Colors.white70:Colors.black54,fontSize: 18),
                              ),
                              textInputAction: TextInputAction.done,
                              validator: (value){
                                if(priceController.text.isEmpty){
                                  return "   Price is Empty";
                                }
                                return null;
                              },
                            )),
                        const Text('For Number Of Persons'),
                        //Per Person
                        MyEditText(
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
                            )),
                        //info about recipe
                        const Text('about'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.grey.withOpacity(0.2),
                                  Colors.grey.withOpacity(0.7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: greenTextColor, width: 1),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  minLines: 10,
                                  keyboardType: TextInputType.multiline,
                                  controller: infoController,
                                  textInputAction: TextInputAction.newline,
                                  style: GoogleFonts.aBeeZee(
                                    color: isThemeDark ? Colors.white : Colors.black,
                                    fontSize: 18,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "   Write Some Information About Recipe",
                                    hintStyle: TextStyle(
                                      color: isThemeDark ? Colors.white70 : Colors.black54,
                                      fontSize: 18,
                                    ),
                                    contentPadding:
                                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  ),
                                  onChanged: (value) {
                                    // Handle the text change event if needed
                                  },
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return "Information is empty";
                                    }
                                    return null;
                                  },
                                  maxLines: 10, // Allow unlimited number of lines
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),) ),
              const StepsWidget(),
              Form(
                  key: _formKeySec,
                  child:Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Center(child: Text("Add Steps To Bake",style: GoogleFonts.aBeeZee(fontSize: 21,fontWeight: FontWeight.bold))),
                        MyEditText(
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
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.grey.withOpacity(0.2),
                                  Colors.grey.withOpacity(0.7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: greenTextColor, width: 1),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                controller: descriptionController,
                                textInputAction: TextInputAction.newline,
                                style: GoogleFonts.aBeeZee(
                                  color: isThemeDark ? Colors.white : Colors.black,
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Description",
                                  hintStyle: TextStyle(
                                    color: isThemeDark ? Colors.white70 : Colors.black54,
                                    fontSize: 18,
                                  ),
                                  contentPadding:
                                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                ),
                                onChanged: (value) {
                                  // Handle the text change event if needed
                                },
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return "Description is empty";
                                  }
                                  return null;
                                },
                                maxLines: null, // Allow unlimited number of lines
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),) ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 10),
                child: LoadingButton(
                  fontSize: 15.sp,
                    shadowColor: Colors.transparent,
                    text: "Add Step", click: (){
                  if(_formKeySec.currentState!.validate()){
                    StepsToBake stepsToBake=StepsToBake(title: titleController.text,details: descriptionController.text);
                    stepsProvider.addStep(stepsToBake);
                    titleController.clear();
                    descriptionController.clear();
                  }
                }),
              ),
              const SizedBox(height: 10,),
              const Center(child: Text('Time To Bake')),
              TimeInputButton(
                text: timeToBake??"Time To Bake",
                  isThemeDark: isThemeDark, size: size,
                  onInputTimeDone: (value){
                    timeToBake=value;
                  }),
              const Center(child: Text('Difficulty')),
              ///Difficulty
              Center(
                child: SizedBox(
                  width: size.width* 4.5/10,
                  child: MyEditText(
                      child: Center(child:
                       DifficultyDropDownMenu(
                           isThemeDark: isThemeDark,
                           onChanged: (value){
                        difficulty=value;
                      },
                       text: difficulty??"Select Difficulty",
                       ),)),
                ),
              ),
              ///ADD Button
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 30),
                child: LoadingButton(
                  shadowColor: Colors.transparent,
                  fontSize: 18.sp,
                  isLoading: isLoading,
                  click: ()async{
                    if(_formKey.currentState!.validate()) {
                      final imageProviderClass = Provider.of<ImageProviderClass>(context, listen: false);
                      final ingredientProviderClass = Provider.of<IngredientsProvider>(context, listen: false);
                      final stepsProvider = Provider.of<BakingStepsProvider>(context, listen: false);
                      if (imageProviderClass.recipeImagePath .isEmpty ) {
                        Utils.showToast("Add Recipe Image");
                      }else if(imageProviderClass.foregroundImagePath .isEmpty ){
                        Utils.showToast("Add Foreground Image");
                      }else if(timeToBake==null){
                        Utils.showToast("Add Time To Bake");
                      }else if(category==null){
                        Utils.showToast("Select Category");
                      }else if(ingredientProviderClass.ingredientList==null){
                        Utils.showToast("Add ingredients");
                      }else if(stepsProvider.stepsList!.isEmpty){
                        Utils.showToast("Add Steps To Bake");
                      }else if(difficulty==null){
                        Utils.showToast("Add Difficulty level");
                      }else{
                        setState(() {
                          isLoading=true;
                        });
                        try {
                          String? foregroundImageURL;
                          String? recipeImageURL;
                          //Add Recipe to Database
                          getImageUrl(
                              imageProviderClass.foregroundImagePath ?? "",
                              nameController.text,
                              "${nameController.text}_foregroundIMG"
                          ).then((value) {
                            foregroundImageURL = value;
                            getImageUrl(
                                imageProviderClass.recipeImagePath ?? "",
                                nameController.text,
                                "${nameController.text}_mainIMG").then((
                                value) async {
                              recipeImageURL = value;
                              List<
                                  Ingredient>? ingredientList = ingredientProviderClass
                                  .ingredientList;
                              List<Ingredient> ingredientListWithURL = [];
                              // Recipe recipe=Recipe();
                              await Future.forEach(
                                  ingredientList as Iterable<Ingredient>, (
                                  Ingredient ingredient) async {
                                await getImageUrl(
                                    ingredient.image!, nameController.text,
                                    "/ingredients/${ingredient.name!}_image")
                                    .then((value) {
                                  Ingredient _ingredeint = ingredient;
                                  _ingredeint.image = value;
                                  ingredientListWithURL.add(_ingredeint);
                                });
                              }).then((value) {
                                //ADD All Data to DB

                                List<StepsToBake>? bakingSteps = stepsProvider
                                    .stepsList;
                                Recipe recipe = Recipe(
                                  name: nameController.text,
                                  category: category,
                                  timeToBake: timeToBake,
                                  image: recipeImageURL,
                                  imageForeground: foregroundImageURL,
                                  price: int.tryParse(priceController.text),
                                  ingredients: ingredientListWithURL,
                                  perPerson: int.tryParse(
                                      personsController.text),
                                  stepsToBakeList: bakingSteps,
                                  difficulty: difficulty,
                                  info: infoController.text,
                                );
                                addRecipeToDB(recipe);
                              }).onError((error, stackTrace) {
                                developer.log(error.toString());
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            });
                          });
                        }catch(e){
                          Utils.showToast("Something Went Wrong\nCheck Your Internet and Try again");
                        }
                      }
                    }
                  }, text: "ADD",),
              ),
            ],
          ),
        ),
      ),
    );

  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(!isInitialized) {
      isInitialized=true;
      _recipeMap = ModalRoute
          .of(context)
          ?.settings
          .arguments as Map?;
      if (_recipeMap != null) {
        ingredients =
        List<Map<dynamic, dynamic>>.from(_recipeMap!['ingredients']);
        nameController.text = _recipeMap!['name'];
        priceController.text = _recipeMap!['price'].toString();
        personsController.text = _recipeMap!['perPerson'].toString();
        infoController.text = _recipeMap!['info'].toString();
        final ingredientProvider = Provider.of<IngredientsProvider>(
            context, listen: false);
        List<Ingredient> extractedIngredients = [];

        List<Map<dynamic, dynamic>> recipeIngredients = List<
            Map<dynamic, dynamic>>.from(_recipeMap!['ingredients']);

        for (var ingredientMap in recipeIngredients) {
          Ingredient ingredient = Ingredient(
            image: ingredientMap['image'],
            unit: ingredientMap['unit'],
            quantity: ingredientMap['quantity'],
            price: ingredientMap['price'],
            name: ingredientMap['name'],
          );
          extractedIngredients.add(ingredient);
        }
        ingredientProvider.setAll(extractedIngredients);
        final stepsProvider = Provider.of<BakingStepsProvider>(
            context, listen: false);
        List<StepsToBake> extractedSteps = [];
        List<Map<dynamic, dynamic>> recipeSteps = List<
            Map<dynamic, dynamic>>.from(_recipeMap!['steps']);

        for (var stepsMap in recipeSteps) {
          StepsToBake steps = StepsToBake(
              title: stepsMap['title'],
              details: stepsMap['details']
          );
          extractedSteps.add(steps);
        }
        stepsProvider.setAll(extractedSteps);
        timeToBake = _recipeMap!['timeToBake'];
        difficulty = _recipeMap!['difficulty'];
        category = _recipeMap!['category'];

        final imageProvider = Provider.of<ImageProviderClass>(
            context, listen: false);
        imageProvider.foregroundImagePath = _recipeMap!['imageForeground'];
        imageProvider.recipeImagePath = _recipeMap!['image'];
      }
    }
  }


  Future<bool> _showDiscardDialog() async {
    bool? confirmed = await showDialog(
      context: context,
      builder: (context) => const MyAlertDialog(
        title: "Discard Edit",
        message: "Are You Sure To Discard Edit Recipe ?",
      ),
    );

    // Handle the case when 'confirmed' is null by assuming it's false
    confirmed ??= false;

    if (confirmed) {
      Future.delayed(Duration.zero,(){
      final imageProvider=  Provider.of<ImageProviderClass>(context,listen: false);
      imageProvider.clearIngredientImage();
      imageProvider.clearImages();
      final ingredientProvider=Provider.of<IngredientsProvider>(context,listen: false);
      ingredientProvider.clearIngredientList();
      final stepsProvider=Provider.of<BakingStepsProvider>(context,listen: false);
      stepsProvider.clearList();

      });
      if(isLoading=true){
        setState(() {
          isLoading=false;
        });
      }
      Navigator.pop(context);
    }

    return confirmed; //
  }

  Future<String?> getImageUrl(String imagePath,String recipeName,String imageName) async {
    if(imagePath.startsWith('http')) {
      return imagePath;
    }else{
      String filePath = imagePath;
      File file = File(filePath.toString());
      String? downloadUrl;
      try {
        firebase_storage.Reference storageRef = firebase_storage
            .FirebaseStorage.instance
            .ref("Recipe/$recipeName/$imageName");
        firebase_storage.UploadTask imageUploadTask = storageRef.putFile(
          file.absolute,);
        await Future.value(imageUploadTask).then((value) async {
          downloadUrl = await storageRef.getDownloadURL();
          return downloadUrl;
        }).onError((error, stackTrace) {
          setState(() {
            isLoading = false;
          });
          developer.log(error.toString());
          return null;
        });
        return downloadUrl;
      } on FirebaseException catch (e) {
        Utils.showAlertDialog(e.message ?? "Something went wrong", context, () {
          developer.log("call back pressed");
        });
      }
    }
    return null;
  }
  addRecipeToDB(Recipe recipe)async{

    DatabaseReference ref=FirebaseDatabase.instance.ref("Recipes/${recipe.category}/${recipe.name}");
    try{
      ref.update(recipe.toJson()).then((value){
        //Also add to all Category
        DatabaseReference refAll=FirebaseDatabase.instance.ref("Recipes/all/${recipe.name}");
        refAll.set(recipe.toJson()).then((value){
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

          Navigator.pop(context);
        }).onError((error, stackTrace) {
          setState(() {
            isLoading=false;
          });
          developer.log(error.toString());
        });

      }).onError((error, stackTrace){
        setState(() {
          isLoading=false;
        });
        developer.log(error.toString());
      });
    }on FirebaseException catch (e){
      Utils.showAlertDialog(e.message??"Something went wrong", context,()=>Navigator.pop(context));
    }

  }
}
