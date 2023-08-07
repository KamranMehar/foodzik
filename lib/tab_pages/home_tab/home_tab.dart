import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/const/catefories_list.dart';
import 'package:foodzik/tab_pages/home_tab/ui_components/loading_recipe_widget.dart';
import 'package:foodzik/tab_pages/home_tab/ui_components/recipe_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:developer' as developer show log;
import '../../const/colors.dart';
import '../../pages/home/ui_componets/foodzik_title.dart';
import '../../provider classes/delete_recipe_provider.dart';
import '../../provider classes/theme_model.dart';
import '../../utils/dialogs.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    checkRegistrationApproval();
    super.initState();
  }

  bool isRegistrationApproved=false;
  String category="all";

  @override
  Widget build(BuildContext context) {
    final ref=FirebaseDatabase.instance.ref("/Recipes/$category/");
    Size size=MediaQuery.of(context).size;
    final modelTheme=Provider.of<ModelTheme>(context);
    bool isThemeDark=modelTheme.isDark;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Slogan
            Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SloganText(fontSize: 16,)
            ),
            //Approval Waiting Text fo user
            if(isRegistrationApproved)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text("Your Registration is not currently approved by Admin\nWait For Admin Approval",
                  style: GoogleFonts.readexPro(color: Colors.red,fontSize: 18),),),
              ),
            ),
            ///Categories
            SizedBox(
              width: size.width,
              height: size.width* 1/8,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context,index){
                  Color color=isThemeDark?Colors.grey.shade700:Colors.grey.shade300;
                  if(index==0){
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          category="all";
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: category.contains("all")?greenPrimary:color,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(child: Text("All",style: GoogleFonts.aBeeZee(color: isThemeDark?Colors.white:Colors.black),)),
                      ),
                    );
                  }else {
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          category=categories.elementAt(index);
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        decoration: BoxDecoration(
                          color: category.contains(categories[index])?greenPrimary:color,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(child: Text(categories[index].toString(),
                          style: GoogleFonts.aBeeZee(color: isThemeDark ? Colors
                              .white : Colors.black),)),
                      ),
                    );
                  }
            }),
            ),
            Visibility(
              visible: !isRegistrationApproved,
              child: Expanded(
                  child: StreamBuilder(
                    stream: ref.onValue,
                    builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot){
                      if(!snapshot.hasData){
                        //Shimmer effect of items
                        return  MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GridView.builder(
                              padding: const EdgeInsets.only(bottom: 30),
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                  childAspectRatio: 1/1.6,
                                  maxCrossAxisExtent: 200
                              ),
                              itemCount: 4,
                              itemBuilder: (context,index){
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: LoadingRecipe(isThemeDark: isThemeDark,),
                                );
                              }),
                        );
                      }else if(snapshot.hasError){
                        return const Center(child: Text("Something went wrong\nTry again"),);
                      }else{
                        //if data found
                        Map<dynamic, dynamic>? map = snapshot.data!.snapshot
                            .value as dynamic;
                        List<dynamic> list = [];
                        list.clear();
                        if(map!=null){
                          list = map.values.toList();
                          return MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                  childAspectRatio: 1 / 1.7,
                                  maxCrossAxisExtent: 180,
                                ),
                                itemCount: list.length,
                                itemBuilder: (context,index){
                                  return
                                    RecipeTile(
                                      recipeMap: list[index],
                                      isThemeDark: isThemeDark,
                                      name: list[index]!['name'],
                                      price:list[index]!["price"],
                                      image:list[index]!["image"],
                                    );
                                }),
                          );
                        }else{
                          return const Center(child: Text("No Recipe Found"),);
                        }
                      }
                    },
                  ),
              ),
            )
          ],
        ),
      floatingActionButton: Consumer<DeleteRecipeProvider>(
        builder: (context,deleteRecipeProvider,_) {
      return Visibility(
          visible: deleteRecipeProvider.deleteRecipeList.isNotEmpty,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Column(
              children: [
                const Spacer(),
                ///edit
                Visibility(
                  visible: deleteRecipeProvider.deleteRecipeList.isNotEmpty && deleteRecipeProvider.deleteRecipeList.length==1,
                  child: InkWell(
                    onTap: (){
                      if(deleteRecipeProvider.deleteRecipeList.length==1){
                          Navigator.pushNamed(context,"/editRecipeScreen",
                              arguments: deleteRecipeProvider.editRecipe);

                      }else{
                        Utils.showToast("Only One Recipe is Editable at a time");
                      }
                    },
                    child: Badge(
                      alignment: Alignment.topLeft,
                      label: Text(deleteRecipeProvider.deleteRecipeList.length.toString(),
                        style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 16),),
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white,width: 0.5),
                            color: CupertinoColors.activeBlue,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: CupertinoColors.activeBlue.withOpacity(0.5),
                                  offset: const Offset(0,0),
                                  blurRadius: 12,
                                  spreadRadius: 7
                              )
                            ]
                        ),
                        child: const Icon(Icons.edit,color: Colors.white,),
                      ),
                    ),
                  ),
                ),
                ///remove
                InkWell(
                  onTap: (){
                    Utils.showErrorDialog("Delete Recipes","Are you sure to Delete These Recipes", context,
                            ()async{
                          await deleteRecipeProvider.deleteFromDB();
                          Navigator.pop(context);
                        }
                    );
                  },
                  child: Badge(
                    alignment: Alignment.topLeft,
                    label: Text(deleteRecipeProvider.deleteRecipeList.length.toString(),
                      style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 16),),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white,width: 0.5),
                          color: CupertinoColors.systemRed,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: CupertinoColors.destructiveRed.withOpacity(0.5),
                                offset: const Offset(0,0),
                                blurRadius: 12,
                                spreadRadius: 7
                            )
                          ]
                      ),
                      child: const Icon(CupertinoIcons.delete,color: Colors.white,),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ));
    }
    ),
      );

  }

  checkRegistrationApproval()async{
    FirebaseAuth auth=FirebaseAuth.instance;
    final uId=  auth.currentUser!.uid;
    final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

    databaseReference.child('/PendingApprovalUsers/$uId').once().then((event) {
      final dataSnapshot=event.snapshot;
      if (dataSnapshot.exists) {
        setState(() {
          print("User Registration is not approved");
          isRegistrationApproved=true;
        });

      } else {
        setState(() {
          print("User Registration is  approved");
          isRegistrationApproved=false;
        });

      }
    });
  }
}
