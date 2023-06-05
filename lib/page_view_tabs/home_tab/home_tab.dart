import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/model%20classes/Recipe.dart';
import 'package:foodzik/page_view_tabs/home_tab/ui_components/loading_recipe_widget.dart';
import 'package:foodzik/page_view_tabs/home_tab/ui_components/recipe_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../pages/home/ui_componets/bnv_custom_painter_class.dart';
import '../../pages/home/ui_componets/foodzik_title.dart';
import '../../provider classes/theme_model.dart';

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
  final ref=FirebaseDatabase.instance.ref("/Recipes/Rice Dishes/");
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    final modelTheme=Provider.of<ModelTheme>(context);
    bool isThemeDark=modelTheme.isDark;
    return Scaffold(
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
            Expanded(
                child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot){
                    if(!snapshot.hasData){
                      return  GridView.builder(
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
                          });
                    }else{
                      Map<dynamic, dynamic> map = snapshot.data!.snapshot
                          .value as dynamic;
                      List<dynamic> list = [];
                      list.clear();
                      if(map!=null){
                        list = map.values.toList();
                        return GridView.builder(
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                childAspectRatio: 1 / 1.6,
                                maxCrossAxisExtent: 200
                            ),
                            itemCount: list.length,
                            itemBuilder: (context,index){

                              return
                                RecipeTile(
                                  isThemeDark: isThemeDark, name: list![index]['name'],
                                  price:list![index]["price"],
                                  image:list![index]["image"],
                                );
                            });
                      }else{
                        return Center(child: Text("No Recipe Found"),);
                      }
                    }
                  },
                ),
            )
          ],
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
