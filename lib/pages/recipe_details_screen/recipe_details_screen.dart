import 'package:flutter/material.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/back_button.dart';
import 'package:foodzik/pages/home/ui_componets/shimmar_effect.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider classes/theme_model.dart';

class RecipeDetailScreen extends StatefulWidget {
 final Map? recipeMap;
   const RecipeDetailScreen({Key? key,required this.recipeMap}) : super(key: key);

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
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
        leading:const BackLeadingBtn(),
      ),
      body:Column(
        children: [
          //Foreground Image
      Container(
      height: size.height * 4 / 10,
        width: size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(80)),
          child: Image.network(
            recipeMap!["imageForeground"],
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return
                ShimmerEffect(height: size.height * 4 / 10,
                  width: size.width,isCircular: false,);
                /*Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );*/
              }
            },
          ),
        ),
      ),
          const SizedBox(height: 5,),
          ClipOval(
            child: Image(
              image: NetworkImage(recipeMap["image"],),
              fit: BoxFit.contain,
              width: 200,
              height: 200,
            ),
          )  ,
          const SizedBox(height: 5,),
          Text(recipeMap["name"],overflow: TextOverflow.ellipsis,
          style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,
              fontWeight: FontWeight.bold,fontSize: 25),
          )
      ],
      ),
    );
  }
}
