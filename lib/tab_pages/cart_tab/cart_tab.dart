import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/model%20classes/ingredient.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:foodzik/provider%20classes/cart_provider.dart';
import 'package:foodzik/provider%20classes/special_order_cart_provider.dart';
import 'package:foodzik/provider%20classes/theme_model.dart';
import 'package:foodzik/tab_pages/cart_tab/components/sub_tabs/cart_sub_tab.dart';
import 'package:foodzik/tab_pages/cart_tab/components/sub_tabs/special_cart_sub_tab.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../const/colors.dart';
import '../../model classes/Recipe.dart';
import '../../model classes/steps_to_bake.dart';
import '../../utils/utils.dart';
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
    //FirebaseAuth auth = FirebaseAuth.instance;
    //final uId = auth.currentUser!.uid;
   // DatabaseReference ref = FirebaseDatabase.instance.ref("/Orders/PendingOrders/$uId/");

    return Scaffold(
     body: FutureBuilder<bool?>(
       future: checkUserOrder(),
       builder: (context,snap) {
         if(snap.data==true){
           return FutureBuilder<List<Recipe>>(
               future: fetchOrderPlaced(),
               builder: (context,snapOrder){
                 if(snapOrder.connectionState==ConnectionState.waiting){
                   return const Center(
                     child: Column(
                       children: [
                         Text("Checking Your Order Status"),
                         CircularProgressIndicator(color: greenPrimary,strokeWidth: 1,)
                       ],
                     ),
                   );
                 }else if(snapOrder.hasData){
                     List<Recipe>? recipesList=[];
                   recipesList=snapOrder.data;
                   return ListView.builder(
                       itemCount: recipesList!.length+1,
                       itemBuilder: (context,index){
                         if(index==recipesList!.length){
                           return Padding(
                               padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10),
                           child: Column(
                             children: [
                               LoadingButton(
                                  isLoading: isLoading,
                                   shadowColor: Colors.transparent,
                                   fontSize: 16.sp,
                                   text: "Order Received", click: (){
                                    orderReceived(snapOrder.data??[]);
                               }),
                               SizedBox(height: 15.h,),
                             ],
                           ),
                           );
                         }else{
                           Recipe recipe=recipesList[index];
                           return Container(
                             margin: const EdgeInsets.all(5),
                             padding: const EdgeInsets.all(10),
                             decoration: BoxDecoration(
                               border: Border.all(
                                   color: isThemeDark?Colors.white:Colors.black,width: 1),
                               borderRadius: BorderRadius.circular(25),
                               image: DecorationImage(
                                 image: NetworkImage(recipe.imageForeground??""),
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
                                       child: Image.network(recipe.image??""),
                                     ),
                                   ],
                                 ),
                                 Text("${recipe.name}",
                                   style: GoogleFonts.abel(fontSize: 20.sp,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                                 Text("for ${recipe.perPerson} Persons",
                                     style: GoogleFonts.abel(fontSize: 18.sp),overflow: TextOverflow.ellipsis),
                                 Text("RS:/ ${recipe.price}",
                                     style: GoogleFonts.abel(fontSize: 18.sp),overflow: TextOverflow.ellipsis),
                                 SizedBox(
                                   height: 15.h,
                                   child: ListView.builder(
                                       scrollDirection: Axis.horizontal,
                                       itemCount: recipe.ingredients!.length,
                                       itemBuilder: (context,index){
                                         Ingredient ingredient=recipe.ingredients![index];
                                         return CartIngredientTile(
                                           name: ingredient.name??"",
                                           quantity: ingredient.quantity!.toInt(),
                                           image: ingredient.image??"",
                                           isThemeDark: isThemeDark,
                                           unit: ingredient.unit??"",
                                           price: ingredient.price??0,
                                         );
                                       }),
                                 )
                               ],
                             ),
                           );
                         }

                       });

                 }else{
                   return Center(child: Text('${snapOrder.data}'),);
                 }


           });
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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

  void orderReceived(List<Recipe> recipeList) {
    setState(() {
      isLoading=true;
    });
    FirebaseAuth auth = FirebaseAuth.instance;
    final uId = auth.currentUser!.uid;

    final orderHistoryRef = FirebaseDatabase.instance.ref('Users/$uId/OrderHistory'); //for user show

      final cartProvider=Provider.of<CartProvider>(context,listen: false);
      cartProvider.clearList();
      final specialCartProvider=Provider.of<SpecialOrderCartProvider>(context,listen: false);
      specialCartProvider.clearList();
      for(int i=0;i<recipeList.length;i++){
        orderHistoryRef.push().set(recipeList[i].toJson());
      }
      addToDeliveredOrdersAdminSide();

  }

  Future<void> addToDeliveredOrdersAdminSide() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final uId = auth.currentUser!.uid;

    DatabaseReference getRef =
    FirebaseDatabase.instance.ref('/Orders/PendingOrders/$uId');
    DatabaseReference uploadRef =
    FirebaseDatabase.instance.ref('Orders/DeliveredOrders/$uId');

    try {
      // Get the data from the PendingOrders node
      DataSnapshot snapshot = await getRef.get();

      if (snapshot.exists) {
        print(snapshot.value);
        // Move the data to the DeliveredOrders node
        await uploadRef.set(snapshot.value).then((value)async {
          // Remove the data from the PendingOrders node
          await getRef.remove().then((value) {
            isLoading=false;
            Utils.showToast("Order Received");
            Navigator.pushNamedAndRemoveUntil(context, "/mainScreen", (route) => false);
          });
        });
        if (kDebugMode) {
          print('Data moved successfully from PendingOrders to DeliveredOrders');
        }
      } else {
        if (kDebugMode) {
          print('No data available to move');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error moving data: $error');
      }
    }
  }

  Future<List<Recipe>> fetchOrderPlaced() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uId = auth.currentUser!.uid;

    DatabaseReference recipesRef =
    FirebaseDatabase.instance.reference().child("/Orders/PendingOrders/$uId/orderRecipes/");

    List<Recipe> recipes = [];

    Completer<List<Recipe>> completer = Completer<List<Recipe>>();

    recipesRef.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      dynamic rawData = dataSnapshot.value;

      if (rawData != null) {
        List<Recipe> updatedRecipes = [];
        for (int i = 0; i < rawData.length; i++) {
          List<StepsToBake> stepsToBakeList = [];
          for (var step in rawData[i]['steps']) {
            StepsToBake stepToBake = StepsToBake(
              title: step['title'],
              details: step['details'],
            );
            stepsToBakeList.add(stepToBake);
          }

          List<Ingredient> ingredientsList = [];
          for (var ingredient in rawData[i]['ingredients']) {
            Ingredient ingredientObj = Ingredient(
              quantity: ingredient['quantity'],
              name: ingredient['name'],
              image: ingredient['image'],
              price: ingredient['price'],
              unit: ingredient['unit'],
            );
            ingredientsList.add(ingredientObj);
          }

          Recipe recipe = Recipe(
            name: rawData[i]['name'],
            imageForeground: rawData[i]['imageForeground'],
            image: rawData[i]['image'],
            price: rawData[i]['price'],
            category: rawData[i]['category'],
            ingredients: ingredientsList,
            timeToBake: rawData[i]['timeToBake'],
            perPerson: rawData[i]['perPerson'],
            stepsToBakeList: stepsToBakeList,
            difficulty: rawData[i]['difficulty'],
            info: rawData[i]['info'],
          );

          updatedRecipes.add(recipe);
        }

        recipes = updatedRecipes;
      }
      //this line
      completer.complete(recipes);
    }, onError: (error) {
      if (kDebugMode) {
        print("Error fetching recipes: $error");
      }
      completer.completeError(error);
    });

    return completer.future;
  }

}