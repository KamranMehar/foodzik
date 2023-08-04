import 'package:flutter/material.dart';
import 'package:foodzik/model%20classes/ingredient.dart';
import 'package:foodzik/provider%20classes/theme_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../admin pages/add_recipe/ui_components/back_button.dart';
import '../recipe_details_screen/components/tabs/ingredient_tab.dart';

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
        title: Text("Create Special Order",style: GoogleFonts.aBeeZee(fontSize: 21.sp,
            fontWeight: FontWeight.bold),),
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: BackLeadingBtn(),
    ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text("Ingredients",style: GoogleFonts.aBeeZee(fontSize: 19.sp,fontWeight: FontWeight.bold),),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of items in each row
                    childAspectRatio: 0.7, // Width to height ratio of each item
                  ),
                  itemCount: ingredients.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        showDialog(context: context, builder: (context){
                          return const Dialog();
                        });
                      },
                      child: IngredientTabTile(
                        name: ingredients[index]['name'],
                        quantity: ingredients[index]['quantity'],
                        image: ingredients[index]['image'],
                        isThemeDark: isThemeDark,
                        unit: ingredients[index]['unit'],
                        price: ingredients[index]['price'],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _recipeMap = ModalRoute.of(context)?.settings.arguments as Map?;
    if(_recipeMap!=null){
      ingredients=List<Map<dynamic, dynamic>>.from(_recipeMap!['ingredients']);
    }
  }
}
