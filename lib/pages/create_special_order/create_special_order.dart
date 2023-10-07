import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/const/colors.dart';
import 'package:foodzik/provider%20classes/special_order_cart_provider.dart';
import 'package:foodzik/provider%20classes/theme_model.dart';
import 'package:foodzik/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:developer'as developer show log;
import '../../admin pages/add_recipe/ui_components/back_button.dart';
import '../../my_widgets/my_button.dart';
import '../../provider classes/create_special_order_provider.dart';
import '../recipe_details_screen/components/detail_row.dart';
import '../recipe_details_screen/components/tabs/ingredient_tab.dart';
import 'components/edit_quantity_dialog.dart';

class CreateSpecialOrderScreen extends StatefulWidget {
  const CreateSpecialOrderScreen({super.key});

  @override
  State<CreateSpecialOrderScreen> createState() => _CreateSpecialOrderScreenState();
}

class _CreateSpecialOrderScreenState extends State<CreateSpecialOrderScreen> {
  Map? _recipeMap;
  List<Map<dynamic, dynamic>> ingredients=[];

  @override
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ModelTheme>(context);
    bool isThemeDark=themeProvider.isDark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Create Special Order",
          style: GoogleFonts.aBeeZee(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: isThemeDark ? Colors.white : Colors.black,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: BackLeadingBtn(),
      ),
      body: Consumer<CreateSpecialOrderProvider>(
        builder: (context, value, child) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: greenPrimary,
                        foregroundImage:NetworkImage(value.recipe['imageForeground']),
                        radius: 20.w,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        value.recipe['name'] ?? "",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold,
                          color: isThemeDark ? Colors.white : Colors.black,
                        ),
                      ),
                      ///Price
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("Price: ${value.totalPrice} RS",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.aBeeZee(fontSize: 17.sp,fontWeight: FontWeight.bold),),
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          IconUnderTextWidget(
                            icon: const SizedBox(
                              height: 25,width: 25,
                              child: Icon(CupertinoIcons.person_2,),),
                            text:"${value.person??""}",
                          ),
                          const Spacer(),
                          Text("For Persons",style: GoogleFonts.aBeeZee(fontSize: 17.sp),),
                          const Spacer(),
                          LoadingButton(
                            text: '   +   ',
                            click: () {
                              value.addPerson();
                            },
                            blurShadow: 20,
                            spreadShadow: 0.2,
                            fontSize: 14.sp,
                          ),
                          const Spacer(),
                          LoadingButton(
                            text: '   -   ',
                            click: () {
                              value.decreasePerson();
                            },
                            blurShadow: 20,
                            spreadShadow: 0.2,
                            fontSize: 14.sp,
                          ),
                          const Spacer(),
                        ],
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.w),
                        child: Consumer<SpecialOrderCartProvider>(
                          builder: (context,specialProvider,child) {
                            return LoadingButton(
                                fontSize: 16.sp,
                                text: "Add To Special Cart",
                                spreadShadow: 0.2,
                                blurShadow: 20,
                                click: (){
                                 // developer.log("${value.recipe['ingredients']}");
                                  Map cartRecipe = Map.from(value.recipe);
                                  cartRecipe["perPerson"] = value.person;
                                  cartRecipe["price"] = value.totalPrice;
                                  specialProvider.addToCart(cartRecipe);
                                  Utils.showToast("${value.recipe["name"]} is Added To Cart");
                                  Future.delayed(Duration.zero, () {
                                    value.reset();
                                    Navigator.pop(context);
                                  });

                                });
                          }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text("Ingredients",style: GoogleFonts.aBeeZee(fontSize: 19.sp,fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
              ),
              itemCount: value.ingredients.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                      showDialog(
                          context: context, builder: (context){
                     return   EditQuantityDialog(
                          ingredient: value.ingredients[index],
                          onSelected: (newQuantityString) {
                            int newQuantity = int.parse(newQuantityString);
                            int initialQuantity = value.ingredients[index]['quantity'];
                            int initialPrice = value.ingredients[index]['price'];
                            double pricePerUnit = initialPrice.toDouble() / initialQuantity.toDouble();
                            int newPrice = (pricePerUnit * newQuantity).round();
                            value.ingredients[index]['quantity'] = newQuantity;
                            value.ingredients[index]['price'] = newPrice;
                            var updatedIngredient = Map<String, dynamic>.from(value.ingredients[index]);

                            // Update the ingredient in the provider
                            value.updateIngredient(index, updatedIngredient);
                          },
                        );

                      });
                  },
                  child: IngredientTabTile(
                    name: value.ingredients[index]['name'],
                    quantity: value.ingredients[index]['quantity'],
                    image: value.ingredients[index]['image'],
                    isThemeDark: isThemeDark,
                    unit: value.ingredients[index]['unit'],
                    price: value.ingredients[index]['price'],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _recipeMap = ModalRoute.of(context)?.settings.arguments as Map?;
    if(_recipeMap!=null){
     // ingredients=List<Map<dynamic, dynamic>>.from(_recipeMap!['ingredients']);
      final createSpecialOrderProvider=Provider.of<CreateSpecialOrderProvider>(context,listen: false);
      createSpecialOrderProvider.ingredients=List<Map<dynamic, dynamic>>.from(_recipeMap!['ingredients']);
      createSpecialOrderProvider.recipe=_recipeMap??{};
      Future.delayed(Duration.zero,(){
        createSpecialOrderProvider.minPerson = _recipeMap!["perPerson"];
        createSpecialOrderProvider.price = (_recipeMap!["price"] / _recipeMap!["perPerson"]).toInt();
        createSpecialOrderProvider.reset();
      });
    }
  }
}
