import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/const/colors.dart';
import 'package:foodzik/provider%20classes/delete_recipe_provider.dart';
import 'package:foodzik/provider%20classes/is_admin_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer' as developer show log;

import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../pages/home/ui_componets/shimmar_effect.dart';

class RecipeTile extends StatelessWidget {
  final bool isThemeDark;
  final String name;
  final int price;
  final String image;
  final Map recipeMap;

  const RecipeTile({
    Key? key,
    required this.isThemeDark,
    required this.name,
    required this.price,
    required this.image,
    required this.recipeMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String timeToBake = recipeMap['timeToBake'];

    return Consumer<IsAdminProvider>(
      builder: (context, adminProvider, _) {
        return GestureDetector(
          onTap: () {
            if(recipeMap.isNotEmpty) {
              Navigator.pushNamed(
                context,
                'recipeDetailPage',
                arguments: recipeMap,
              );
            }else{
              Navigator.pushNamedAndRemoveUntil(context, "/mainScreen", (route) => false);
            }
          },
          onLongPress: () {
            if (adminProvider.isAdmin) {
              final deleteRecipeProvider =
              Provider.of<DeleteRecipeProvider>(context, listen: false);
              if (deleteRecipeProvider.deleteRecipeList
                  .contains("${recipeMap['category']}/$name")) {
                deleteRecipeProvider
                    .removeFromDeleteList("${recipeMap["category"]}/$name");
                developer.log("List: ${deleteRecipeProvider.deleteRecipeList}");
              } else {
                deleteRecipeProvider.addToEdit(recipeMap);
                deleteRecipeProvider.addToDeleteList(name, recipeMap['category']);
                developer.log("List: ${deleteRecipeProvider.deleteRecipeList}");
              }
            }
          },
          child: SizedBox(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Consumer<DeleteRecipeProvider>(
                    builder: (context, deleteProvider, _) {
                      Color color = isThemeDark
                          ? Colors.grey.shade700
                          : Colors.grey.shade300;
                      developer.log(deleteProvider.deleteRecipeList.toString());
                      return Container(
                        width: 145,
                        height: 160,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              spreadRadius: 4,
                              blurRadius: 20,
                              color: Colors.black54,
                              offset: Offset(0, 10),
                            )
                          ],
                          color: deleteProvider.deleteRecipeList
                              .contains("${recipeMap["category"]}/$name")
                              ? greenPrimary
                              : color,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      const Spacer(flex: 2,),
                      Container(
                        height: 165,
                        width: 165,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.network(
                            image.toString(),
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return ShimmerEffect(
                                  height: 165,
                                  width: 165,
                                  isCircular: true,
                                );
                              }
                            },
                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isThemeDark?Colors.grey.shade600:Colors.grey.shade400
                                  ),
                                  child: Icon(Icons.error,color: Colors.red,size: 13.w,)); // Display an error icon if image fails to load
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text(
                          name,
                          style: GoogleFonts.aBeeZee(
                            color: isThemeDark ? Colors.white : Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Text(
                        "Rs:/ $price",
                        style: GoogleFonts.aBeeZee(
                          color: isThemeDark ? Colors.white : Colors.black,
                          fontSize: 15.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.time_solid,
                            color: isThemeDark ? Colors.white : Colors.black,
                            size: 15.sp,
                          ),
                          Text(
                            " $timeToBake",
                            style: GoogleFonts.aBeeZee(
                              color: isThemeDark ? Colors.white : Colors.black,
                              fontSize: 14.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
