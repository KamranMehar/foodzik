import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../const/colors.dart';
import '../../../../model classes/Recipe.dart';
import '../../../../provider classes/cart_provider.dart';
import '../cart_tile.dart';

class CartSubTab extends StatefulWidget {
  const CartSubTab({super.key});

  @override
  State<CartSubTab> createState() => _CartSubTabState();
}

class _CartSubTabState extends State<CartSubTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
        builder: (context,cartProvider,child) {
          if(cartProvider.totalPrice==0){
           return const Center(child: Text("Cart is Empty"),);
          }else {
            return Column(
              children: [
                Container(
                  width: 95.w,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 5),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: greenPrimary
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total: ", style: GoogleFonts.abel(fontSize: 21.sp),),
                      Text("${cartProvider.totalPrice}",
                        style: GoogleFonts.abel(fontSize: 21.sp),),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: cartProvider.recipeList!.length,
                      itemBuilder: (context, index) {
                        if (index < cartProvider.recipeList!.length - 1) {
                          return CartTile(onDelete: () {
                            cartProvider.removeFromCart(
                                cartProvider.recipeList![index]);
                          },
                              recipeMap: cartProvider.recipeList![index]
                          );
                        } else {
                          return Column(
                            children: [
                              CartTile(
                                  onDelete: () {
                                    cartProvider.removeFromCart(
                                        cartProvider.recipeList[index]);
                                  },
                                  recipeMap: cartProvider.recipeList[index]
                              ),
                              InkWell(
                                onTap:(){
                                  Navigator.pushNamed(context, "/confirmOrderScreen", arguments: cartProvider.recipeList);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 95.w,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: greenPrimary
                                  ),
                                  child: Text("Place Order",
                                    style: GoogleFonts.abel(fontSize: 18.sp),),
                                ),
                              ),
                              SizedBox(height: 15.h,)
                            ],
                          );
                        }
                      }),
                ),
              ],
            );
          }
        }
    );
  }
}
