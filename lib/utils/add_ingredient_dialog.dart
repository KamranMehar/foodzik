import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/model%20classes/ingredient.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:foodzik/my_widgets/my_edit_text.dart';
import 'package:foodzik/provider%20classes/image_provider.dart';
import 'package:foodzik/const/colors.dart';
import 'package:foodzik/utils/dialogs.dart';
import 'package:foodzik/utils/time_to_bake.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider classes/ingredients_provider.dart';
import '../provider classes/theme_model.dart';


class AddRecipeDialog extends StatefulWidget {
  AddRecipeDialog({Key? key}) : super(key: key);

  @override
  State<AddRecipeDialog> createState() => _AddRecipeDialogState();
}

class _AddRecipeDialogState extends State<AddRecipeDialog> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  Ingredient ingredient = Ingredient();
  Widget nameField() {
    final modelTheme = Provider.of<ModelTheme>(context);
    bool isThemeDark = modelTheme.isDark;

    return MyEditText(
      child: TextFormField(
        textInputAction: TextInputAction.next,
        maxLines: 1,
        controller: nameController,
        style: GoogleFonts.aBeeZee(
          color: isThemeDark ? Colors.white : Colors.black,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Name",
          hintStyle: TextStyle(
            color: isThemeDark ? Colors.white70 : Colors.black54,
            fontSize: 18,
          ),
        ),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return "Name is Empty";
          }
          return null;
        },
      ),
    );
  }

  Widget priceField() {
    final modelTheme = Provider.of<ModelTheme>(context);
    bool isThemeDark = modelTheme.isDark;

    return MyEditText(
      child: TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        maxLines: 1,
        controller: priceController,
        style: GoogleFonts.aBeeZee(
          color: isThemeDark ? Colors.white : Colors.black,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Price per Unit",
          hintStyle: TextStyle(
            color: isThemeDark ? Colors.white70 : Colors.black54,
            fontSize: 18,
          ),
        ),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return "Price is Empty";
          }
          return null;
        },
      ),
    );
  }

  Widget quantityField() {
    final modelTheme = Provider.of<ModelTheme>(context);
    bool isThemeDark = modelTheme.isDark;

    return MyEditText(
      child: TextFormField(
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        maxLines: 1,
        controller: quantityController,
        style: GoogleFonts.aBeeZee(
          color: isThemeDark ? Colors.white : Colors.black,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Quantity",
          hintStyle: TextStyle(
            color: isThemeDark ? Colors.white70 : Colors.black54,
            fontSize: 18,
          ),
        ),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return "Quantity is Empty";
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final modelTheme = Provider.of<ModelTheme>(context);
    Size size = MediaQuery.of(context).size;
    bool isThemeDark = modelTheme.isDark;

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: size.height * 3 / 5,
        decoration: BoxDecoration(
          color: isThemeDark ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 0),
              color: greenTextColor,
              spreadRadius: 5,
              blurRadius: 12,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Add Ingredient",
                    style: GoogleFonts.aBeeZee(
                      color: isThemeDark ? Colors.white : Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5,),
                    Consumer<ImageProviderClass>(
                    builder: (context, imageProvideClass, _) {
                      if (imageProvideClass.ingredientImagePath == null) {
                        return InkWell(
                          onTap: () =>
                              imageProvideClass.pickIngredientImage(),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor:
                            isThemeDark ? Colors.white : Colors.black,
                            child: Icon(
                              CupertinoIcons.camera_fill,
                              color:
                              isThemeDark ? Colors.black : Colors.white,
                            ),
                          ),
                        );
                      } else {
                        ingredient.image =
                            imageProvideClass.ingredientImagePath;
                        return InkWell(
                          onTap: () =>
                              imageProvideClass.pickIngredientImage(),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 70,
                            backgroundImage: FileImage(File(imageProvideClass.ingredientImagePath ?? "",)),
                            child: Text(
                              "Change",
                              style: TextStyle(
                                color:
                               isThemeDark ? Colors.white : Colors.black,
                                shadows: [
                                  BoxShadow(
                                    color: isThemeDark?Colors.grey.shade900: Colors.grey.shade500,
                                    spreadRadius: 12,
                                    blurRadius: 8,
                                    offset: const Offset(0,0)
                                  )
                                ]
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  nameField(),
                  Row(
                    children: [
                      Expanded(
                        child: quantityField(),
                      ),
                      const SizedBox(width: 5),
                      UnitDropDownButton(onChanged: (unit) {
                        ingredient.unit = unit;
                      }),
                    ],
                  ),
                  priceField(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: MyButton(
                       onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (ingredient.image == null) {
                            Utils.showToast("No Image Selected");
                          } else if (ingredient.unit == null) {
                            Utils.showToast("Select Unit");
                          } else {
                            ingredient.name = nameController.text;
                            ingredient.price =
                                int.tryParse(priceController.text);
                            ingredient.quantity =
                                int.tryParse(quantityController.text);
                            final imageProvider =
                            Provider.of<ImageProviderClass>(context, listen: false);
                            final ingredientProvider = Provider.of<IngredientsProvider>(context,listen: false);
                            ingredientProvider.addIngredientToList(ingredient);
                            imageProvider.clearIngredientImage();
                            Navigator.pop(context);
                          }
                        }
                      },
                      title: "Add to Recipe",
                      padding: 5,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }
}

class TimeInputButton extends StatefulWidget {
  bool isThemeDark;
  Size size;

  void Function(String) onInputTimeDone;
  TimeInputButton({Key? key,required this.isThemeDark,required this.size,
  required this.onInputTimeDone}) : super(key: key);

  @override
  State<TimeInputButton> createState() => _TimeInputButtonState();
}

class _TimeInputButtonState extends State<TimeInputButton> {
  String timeToBake="Time To Bake";
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: GestureDetector(
        onTap: (){
          showDialog(
            barrierDismissible: true, // false, //Tap outside the dialog to dismiss
            context: context,
            builder: (BuildContext context) => InputTimeDialog( size: widget.size,
              onTimeInputDone: (time ){
              widget.onInputTimeDone(time);
              setState(() {
                timeToBake=time;
              });
              },),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50,),
          child: MyEditText(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(timeToBake,
                    style: TextStyle(color: widget.isThemeDark?Colors.white70:Colors.black54,fontSize: 18),),
                  Icon(CupertinoIcons.time_solid,color: widget.isThemeDark?Colors.white70:Colors.black54,)
                ],
              ),
            ),
          ),
        ),
      ),);
  }
}

class UnitDropDownButton extends StatefulWidget {
  final void Function(String? selectedValue)? onChanged;

  const UnitDropDownButton({Key? key, this.onChanged}) : super(key: key);

  @override
  _UnitDropDownButtonState createState() => _UnitDropDownButtonState();
}

class _UnitDropDownButtonState extends State<UnitDropDownButton> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedOption,
      onChanged: (String? newValue) {
        setState(() {
          _selectedOption = newValue!;
        });

        // Call the onChanged callback function with the selected value
        if (widget.onChanged != null) {
          widget.onChanged!(_selectedOption);
        }
      },
      items: <String>['Grams', 'KG', 'Ltr','ml']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
