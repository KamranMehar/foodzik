import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/pages/recipe_details_screen/components/detail_row.dart';
import 'package:foodzik/utils/dialogs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:developer'as developer show log ;
import '../../model classes/Recipe.dart';


class FavouriteTab extends StatefulWidget {
  const FavouriteTab({Key? key}) : super(key: key);

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text("My Favourites",style: GoogleFonts.aBeeZee(fontSize: 21.sp),),),
          Expanded(
            child: FutureBuilder<List<Recipe>>(
              future: fetchRecipesFromFirebase(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator()); // Loading indicator while fetching data
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No recipes found.'));
                } else {
                  List<Recipe> recipes = snapshot.data!;

                  return MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView.builder(
                      itemCount: recipes.length,
                      itemBuilder: (context, index) {
                        Recipe recipe= recipes[index];
                        return BookmarkTile(
                            recipe: recipe ,
                          onTap: () {
                            String uId = auth.currentUser!.uid;
                              removeBookmark(uId, recipe.name??"").then((value) {
                                Utils.showToast("${recipe.name??""} is Removed From Favourite");
                                setState(() {});
                              }).onError((error, stackTrace) {
                                Utils.showToast("${recipe.name??""} is unable to Removed From Favourite\n"
                                    "Check Your Internet and Try Again");
                                setState(() {});
                              });
                          },);
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Recipe>> fetchRecipesFromFirebase() async {
    String uId = auth.currentUser!.uid;
    DatabaseReference recipesRef =
    FirebaseDatabase.instance.reference().child('Users/$uId/bookmarks/');

    List<Recipe> recipes = [];

    Completer<List<Recipe>> completer = Completer<List<Recipe>>();

    recipesRef.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;

      dynamic rawData = dataSnapshot.value;

      if (rawData != null && rawData is Map) {
        List<Recipe> updatedRecipes = [];

        rawData.forEach((key, value) {
          if (value is Map<Object?, Object?>) {
            Map<String, dynamic> jsonValue = Map<String, dynamic>.from(value);
            String jsonString = jsonEncode(jsonValue);
            Recipe recipe = Recipe.fromJson(jsonDecode(jsonString));
            updatedRecipes.add(recipe);
          }
        });

        recipes = updatedRecipes;
      }

      completer.complete(recipes); // Complete the completer with the populated recipes list
    }, onError: (error) {
      if (kDebugMode) {
        print("Error fetching recipes: $error");
      }
      completer.completeError(error); // Complete the completer with an error if necessary
    });

    return completer.future; // Return the future of the completer
  }
  Future<void> removeBookmark(String userId, String recipeName) async {
    try {
      final database = FirebaseDatabase.instance;
      final userBookmarksRef =
      database.ref().child('Users/$userId/bookmarks/');

      await userBookmarksRef.child(recipeName).remove();

      Utils.showToast("Removed from Bookmarks");
      setState(() {});
    } catch (error) {
      developer.log('Error removing bookmark: $error');
    }
  }
}

//Tile
class BookmarkTile extends StatelessWidget {
  const BookmarkTile({super.key,
    required this.recipe,
    required this.onTap});
final VoidCallback onTap;
final Recipe recipe;
  @override
  Widget build(BuildContext context) {
    String timeToBake=recipe.timeToBake??"";
    String hours = timeToBake.substring(0, 2);
    String minutes = timeToBake.substring(2, 4);

    return Stack(
      alignment: Alignment.center,
      children: [
        //remove
        InkWell(
          onTap: onTap,
          child: Container(
            alignment: Alignment.bottomCenter,
            width: 90.w,
            height: 20.h,
            margin:  EdgeInsets.only(left: 5,right: 5,top: 10.h,bottom: 0),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Remove',style: GoogleFonts.aBeeZee(fontSize: 16.sp),),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 5,right: 5,top: 0,bottom: 10),
          width: 90.w,
            height: 20.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(recipe.imageForeground ?? ""),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), // Adjust the opacity as needed
                BlendMode.darken,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                recipe.name ?? "",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.aBeeZee(
                  fontSize: 23.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Rs/: ${recipe.price ?? ""}",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.aBeeZee(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Spacer(),
                  IconUnderTextWidget(
                    icon: SizedBox(
                      height: 25,width: 25,
                      child: Image.asset("assets/chef_hat.png",color: Colors.white,),),
                    text: recipe.difficulty??"",
                  ),
                  const Spacer(),
                  IconUnderTextWidget(
                    icon: const SizedBox(
                      height: 25,width: 25,
                      child: Icon(CupertinoIcons.time,),),
                    text: "${hours=="00"?"":"$hours hr"} ${minutes=="00"?"":"$minutes min"}",
                  ),
                  const Spacer(),
                  IconUnderTextWidget(
                    icon: const SizedBox(
                      height: 25,width: 25,
                      child: Icon(CupertinoIcons.person_2,),),
                    text:"${recipe.perPerson??""}",
                  ),
                  const Spacer(),
                  IconUnderTextWidget(
                    icon: SizedBox(
                      height: 25,width: 25,
                      child: Image.asset("assets/ingredient_no.png",color: Colors.white,),),
                    text:recipe.ingredients!.length.toString(),
                  ),
                  const Spacer(),
                ],
              )
            ],
          ),
        ),
      ],
    );

  }
}