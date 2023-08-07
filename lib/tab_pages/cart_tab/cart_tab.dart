import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:foodzik/provider%20classes/theme_model.dart';
import 'package:foodzik/tab_pages/cart_tab/components/sub_tabs/cart_sub_tab.dart';
import 'package:foodzik/tab_pages/cart_tab/components/sub_tabs/special_cart_sub_tab.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:developer'as developer show log;
import '../../const/colors.dart';
import '../../utils/dialogs.dart';
import 'components/cart_ingredient_tile.dart';



class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ModelTheme>(context);
    bool isThemeDark=themeProvider.isDark;
    FirebaseAuth auth = FirebaseAuth.instance;
    final uId = auth.currentUser!.uid;
    DatabaseReference ref = FirebaseDatabase.instance.ref("/Orders/PendingOrders/$uId/orderRecipes/");

    return Scaffold(
     body: FutureBuilder<bool?>(
       future: checkUserOrder(),
       builder: (context,snap) {
         if(snap.data==true){
           return StreamBuilder(
             stream: ref.onValue,
             builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
               if (!snapshot.hasData) {
                 return const Center(child: CircularProgressIndicator(strokeWidth: 1,),);
               } else if (snapshot.hasError) {
                 return const Center(child: Text("Something went wrong\nTry again"),);
               } else {
                 List<dynamic> recipeList = snapshot.data!.snapshot.value as List<dynamic>;

                 return ListView.builder(
                   itemCount: recipeList.length+1,
                   itemBuilder: (context, index) {

                        if(index == recipeList.length){
                          return Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 5),
                                child: LoadingButton(fontSize: 17.sp,
                                  shadowColor: Colors.transparent,
                                    text: "Order Received",
                                    isLoading: false,
                                    click: (){
                                      orderReceived(recipeList);
                                    }),
                              ),
                            SizedBox(height: 20.h,),
                            ],
                          );
                        }else{
                          Map<dynamic, dynamic> recipe = recipeList[index];
                          List<Map<dynamic, dynamic>> ingredients=List<Map<dynamic, dynamic>>.
                          from(recipe['ingredients']);
                          return Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: isThemeDark?Colors.white:Colors.black,width: 1),
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(
                                image: NetworkImage(recipe["imageForeground"]),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.6),
                                  BlendMode.darken,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 30.w,
                                      width: 30.w,
                                      child: Image.network(recipe["image"]),
                                    ),
                                  ],
                                ),
                                Text("${recipe["name"]}",
                                  style: GoogleFonts.abel(fontSize: 20.sp,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                                Text("for ${recipe["perPerson"]} Persons",
                                    style: GoogleFonts.abel(fontSize: 18.sp),overflow: TextOverflow.ellipsis),
                                Text("RS:/ ${recipe["price"]}",
                                    style: GoogleFonts.abel(fontSize: 18.sp),overflow: TextOverflow.ellipsis),
                                SizedBox(
                                  height: 15.h,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: ingredients.length,
                                      itemBuilder: (context,index){
                                        return CartIngredientTile(
                                          name: ingredients[index]["name"],
                                          quantity: ingredients[index]["quantity"],
                                          image: ingredients[index]["image"],
                                          isThemeDark: isThemeDark,
                                          unit: ingredients[index]["unit"],
                                          price: ingredients[index]["price"],
                                        );

                                      }),
                                )
                              ],
                            ),
                          );
                        }


                   },
                 );
               }
             },
           );

         }else if(snap.data==false){
           return Column(
             children: [
               Container(
                 margin: const EdgeInsets.symmetric(horizontal: 10),
                 color: Colors.transparent, // Set the background color of the TabBar
                 child: TabBar(
                   controller: _tabController,
                   indicatorColor: greenTextColor, // Set the color of the underline
                   tabs: [
                     Tab(child: Text("Cart",style: GoogleFonts.aBeeZee(
                         fontWeight: FontWeight.bold,
                         color:isThemeDark?Colors.white:Colors.black,fontSize: 14),
                       overflow: TextOverflow.ellipsis,
                     ),),
                     Tab(child: Text("Special Cart",
                       overflow: TextOverflow.ellipsis,
                       style: GoogleFonts.aBeeZee(
                           fontWeight: FontWeight.bold,
                           color:isThemeDark?Colors.white:Colors.black,fontSize: 14),),),
                   ],
                 ),
               ),
               Expanded(
                 child: TabBarView(
                   controller: _tabController,
                   children: const [
                     CartSubTab(),
                     SpecialCartSubTab()
                   ],
                 ),
               ),
             ],
           );
         }else if(snap.connectionState==ConnectionState.waiting){
           return const Center(
             child: Column(
               children: [
                 Text("Checking Your Order Status"),
                 CircularProgressIndicator(color: greenPrimary,strokeWidth: 1,)
               ],
             ),
           );
         }else if(snap.hasError){
           return  Center(
             child: InkWell(
               onTap: (){
                 setState(() {});
               },
               child: const Column(
                 children: [
                   Text("Something went Wrong try again"),
                   Icon(CupertinoIcons.arrow_counterclockwise)
                 ],
               ),
             ),
           );
         }else{
           return Text(snap.data.toString());
         }

       }
     ),
    );
  }

  Future<bool?> checkUserOrder() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    final uId = auth.currentUser!.uid;
    DatabaseReference ref = FirebaseDatabase.instance.ref("/Orders/PendingOrders/$uId/");

    try {
      DatabaseEvent event = await ref.once();
      DataSnapshot dataSnapshot = event.snapshot;

      if (dataSnapshot.value != null) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print("Error checking user order: $error");
      return null;
    }
  }

  void orderReceived(List recipeList) {
    setState(() {
      isLoading=true;
    });
    FirebaseAuth auth = FirebaseAuth.instance;
    final uId = auth.currentUser!.uid;
    final ordersRef = FirebaseDatabase.instance.ref('Orders/DeliveredOrders/$uId');
    DatabaseReference ref = FirebaseDatabase.instance.ref("/Orders/PendingOrders/");
    ref.child(uId).remove().then((value){

      // Create a list to store the recipe data in the format required
      List<Map<String, dynamic>> orderRecipes = [];

      for (var recipe in recipeList) {
        Map<dynamic, dynamic> recipeData = recipe as Map<dynamic, dynamic>;
        List<Map<dynamic, dynamic>> ingredients = List<Map<dynamic, dynamic>>.from(recipeData['ingredients']);
        List<Map<String, dynamic>> formattedIngredients = [];

        for (var ingredient in ingredients) {
          formattedIngredients.add({
            'name': ingredient['name'],
            'quantity': ingredient['quantity'],
            'image': ingredient['image'],
            'unit': ingredient['unit'],
            'price': ingredient['price'],
          });
        }
        orderRecipes.add({
          'name': recipeData['name'],
          'imageForeground': recipeData['imageForeground'],
          'image': recipeData['image'],
          'price': recipeData['price'],
          'category': recipeData['category'],
          'timeToBake': recipeData['timeToBake'],
          'perPerson': recipeData['perPerson'],
          'difficulty': recipeData['difficulty'],
          'info': recipeData['info'],
          'ingredients': formattedIngredients,
        });
      }

      ordersRef.set({
        'orderRecipes': orderRecipes,
      }).then((value) {
        Utils.showToast("Order Received Successfully");
        Navigator.pushNamed(context, "/mainScreen");
      }).onError((error, stackTrace) {
        Utils.showToast("Unable To Check Order \nCheck our Internet And try Again");
        setState(() {
          isLoading = false;
        });
      });
    });

  }



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
}




