import 'package:flutter/material.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/back_button.dart';
import 'package:foodzik/const/colors.dart';
import 'package:foodzik/pages/recipe_details_screen/components/detail_row.dart';
import 'package:foodzik/pages/recipe_details_screen/components/forground_img_details.dart';
import 'package:foodzik/pages/recipe_details_screen/components/tabs/info.dart';
import 'package:foodzik/pages/recipe_details_screen/components/tabs/ingredient_tab.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../provider classes/theme_model.dart';
import 'components/main_image.dart';
import 'components/tabs/bake_recipe.dart';

class RecipeDetailScreen extends StatefulWidget {
 final Map? recipeMap;
   const RecipeDetailScreen({Key? key,required this.recipeMap}) : super(key: key);

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController childScrollController = ScrollController();
  final ScrollController parentScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    childScrollController.addListener(_handleChildScroll);
    _tabController = TabController(length: 3, vsync: this);

  }

  @override
  void dispose() {
    childScrollController.removeListener(_handleChildScroll);
    childScrollController.dispose();
    parentScrollController.dispose();
    super.dispose();
  }

  void _handleChildScroll() {
    if (childScrollController.position.atEdge) {
      if (childScrollController.position.pixels == 0) {
        // Child scroll view reached the top
        // You can handle any desired behavior here
      } else {
        // Child scroll view reached the bottom
        // Scroll the parent scroll view
        parentScrollController.animateTo(
          parentScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final modelTheme=Provider.of<ModelTheme>(context);
    bool isThemeDark=modelTheme.isDark;
    Map? recipeMap = ModalRoute.of(context)?.settings.arguments as Map?;
    Size size=MediaQuery.of(context).size;
    return  Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: BackLeadingBtn(),
      ),
      body:SingleChildScrollView(
        controller: parentScrollController,
        scrollDirection: Axis.vertical,
        physics:const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 4.5/10,
              width: size.width,
              child: Stack(
                children: [
                  ///Foreground Image
                  ForegroundImageDetailPage(size: size,recipeMap: recipeMap),
                  ///main Image
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: MainImageRecipeDetailPage(url: recipeMap!["image"],)
                  )  ,
                ],
              ),
            ),
         const SizedBox(height: 3,),
            ///Name
            Text(
              recipeMap["name"],overflow: TextOverflow.ellipsis,
            style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,
                fontWeight: FontWeight.bold,fontSize: 25),
            ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20),
            child:DetailRowRecipe(
                isThemeDark: isThemeDark,
                recipeMap: recipeMap,
            ),),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.transparent, // Set the background color of the TabBar
              child: TabBar(
                controller: _tabController,
                indicatorColor: greenTextColor, // Set the color of the underline
                tabs: [
                  Tab(child: Text("Info",style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold,
                      color:isThemeDark?Colors.white:Colors.black,fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                  ),),
                  Tab(child: Text("Ingredients",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold,
                        color:isThemeDark?Colors.white:Colors.black,fontSize: 14),),),
                  Tab(child: Text("Bake",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold,
                        color:isThemeDark?Colors.white:Colors.black,fontSize: 14),),),
                ],
              ),
            ),
            SizedBox(
              height: size.height*7/10,
              width: size.width,
              child: TabBarView(
                controller: _tabController,
                children: [
                      InfoTab(size: size, info: recipeMap['info'], isThemeDark: isThemeDark),
                      IngredientsTab(ingredients: List<Map<dynamic, dynamic>>.from(recipeMap['ingredients']),
                        isThemeDark: isThemeDark, childScrollController: childScrollController, size: size,),
                       HowToBakeTab(stepList: List<Map<dynamic, dynamic>>.from(recipeMap['steps']),),
                ],
              ),
            ),
        ],
        ),
      ),
    );
  }


}
