import 'package:flutter/material.dart';
import 'package:foodzik/const/colors.dart';
import 'package:foodzik/provider%20classes/cart_provider.dart';
import 'package:foodzik/tab_pages/cart_tab/components/cart_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../provider classes/theme_model.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  @override
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ModelTheme>(context);
    bool isThemeDark=themeProvider.isDark;

    return Scaffold(
     body: Consumer<CartProvider>(
       builder: (context,cartProvider,child) {
         return Column(
           children: [
             Container(
               width: 95.w,
               margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
               padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(15),
                 color: greenPrimary
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("Total: ",style: GoogleFonts.abel(fontSize: 21.sp),),
                   Text("${cartProvider.totalPrice}",style: GoogleFonts.abel(fontSize: 21.sp),),
                 ],
               ),
             ),
             Expanded(
               child: ListView.builder(
                   itemCount: CartProvider.recipeList.length,
                   itemBuilder: (context,index){
                     if(index < CartProvider.recipeList.length - 1) {
                       return CartTile(onDelete: () {
                         cartProvider.removeFromCart(
                             CartProvider.recipeList[index]);
                       },
                           recipeMap: CartProvider.recipeList[index]
                       );
                     }else{
                       return Column(
                         children: [
                           CartTile(
                               onDelete: () {
                             cartProvider.removeFromCart(
                                 CartProvider.recipeList[index]);
                           },
                               recipeMap: CartProvider.recipeList[index]
                           ),
                           Container(
                             alignment: Alignment.center,
                             width: 95.w,
                             margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                             padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15),
                                 color: greenPrimary
                             ),
                             child:  Text("Place Order",style: GoogleFonts.abel(fontSize: 18.sp),),
                           ),
                           SizedBox(height: 15.h,)
                         ],
                       );
                     }
               }),
             )
           ],
         );
       }
     ),
    );
  }
}

