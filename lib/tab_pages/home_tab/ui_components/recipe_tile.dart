
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/const/colors.dart';
import 'package:foodzik/provider%20classes/delete_recipe_provider.dart';
import 'package:foodzik/provider%20classes/is_admin_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer' as developer show log;

import 'package:provider/provider.dart';

import '../../../pages/home/ui_componets/shimmar_effect.dart';

class RecipeTile extends StatelessWidget {
  final bool isThemeDark;
  final String name;
  final int price;
  final String image;
 final Map recipeMap;
   const RecipeTile({Key? key,required this.isThemeDark,required this.name,required this.price,
     required this.image,required this.recipeMap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  //  developer.log(recipeMap.toString());
  String timeToBake=recipeMap['timeToBake'];
  String hours = timeToBake.substring(0, 2);
  String minutes = timeToBake.substring(2, 4);
    return Consumer<IsAdminProvider>(
      builder: (context,adminProvider,_) {
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, 'recipeDetailPage', arguments: recipeMap);
          },
          onLongPress: (){
            if(adminProvider.isAdmin){
              final deleteRecipeProvider=Provider.of<DeleteRecipeProvider>(context,listen: false);
              if(deleteRecipeProvider.deleteRecipeList.contains("${recipeMap['category']}/$name")){
                deleteRecipeProvider.removeFromDeleteList("${recipeMap["category"]}/$name");
                developer.log("List: ${deleteRecipeProvider.deleteRecipeList}");
              }else{
                deleteRecipeProvider.addToDeleteList(name,recipeMap['category']);
                developer.log("List: ${deleteRecipeProvider.deleteRecipeList}");
              }
            }
          },
          child: SizedBox(
            child: Stack(
              children: [
                ///Card
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Consumer<DeleteRecipeProvider>(
                    builder: (context,deleteProvider,_) {
                      Color color=isThemeDark?Colors.grey.shade700:Colors.grey.shade300;
                      developer.log(deleteProvider.deleteRecipeList.toString());
                      return Container(
                        width: 145,
                        height: 160,//size.height* ((1/10)/2),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                spreadRadius: 4,
                                blurRadius: 20,
                                color: Colors.black54,
                                offset:Offset(0,10)
                            )
                          ],
                          color: deleteProvider.deleteRecipeList.contains("${recipeMap["category"]}/$name")?greenPrimary:color,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    }
                  ),
                ),
                ///Image
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                     const Spacer(flex: 2,),
                      Container(
                        height: 165,//size.height* ((1/10)/2),
                        width: 165,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: Image.network(image.toString(),
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return
                                      ShimmerEffect(
                                        height: 165,//size.height* ((1/10)/2),
                                        width: 165
                                        ,isCircular: true,);
                                  }
                                },
                              ).image,
                          ),
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),

                      ),
                     // const Spacer(flex: 5),
                      Text(name,style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,
                          fontSize: 20,fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text("Rs:/ $price",
                        style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,fontSize: 18),
                        overflow: TextOverflow.ellipsis,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.time_solid,color: isThemeDark?Colors.white:Colors.black,size: 20,),
                          Text("${hours=="00"?"":"$hours hr"} ${minutes=="00"?"":"$minutes min"}",
                            style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black,fontSize: 14),
                            overflow: TextOverflow.ellipsis,),
                        ],
                      ),
                      const Spacer()
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
