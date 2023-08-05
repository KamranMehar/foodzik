import 'package:flutter/material.dart';
import 'package:foodzik/provider%20classes/special_order_cart_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../const/colors.dart';
import '../cart_tile.dart';

class SpecialCartSubTab extends StatefulWidget {
  const SpecialCartSubTab({super.key});

  @override
  State<SpecialCartSubTab> createState() => _SpecialCartSubTabState();
}

class _SpecialCartSubTabState extends State<SpecialCartSubTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SpecialOrderCartProvider>(
        builder: (context,cartProvider,child) {
          if(cartProvider.totalPrice==0){
            return const Center(child: Text("Special Order Cart"),);
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
                      itemCount: SpecialOrderCartProvider.recipeList.length,
                      itemBuilder: (context, index) {
                        if (index <
                            SpecialOrderCartProvider.recipeList.length - 1) {
                          return CartTile(onDelete: () {
                            cartProvider.removeFromCart(
                                SpecialOrderCartProvider.recipeList[index]);
                          },
                              recipeMap: SpecialOrderCartProvider
                                  .recipeList[index]
                          );
                        } else {
                          return Column(
                            children: [
                              CartTile(
                                  onDelete: () {
                                    cartProvider.removeFromCart(
                                        SpecialOrderCartProvider
                                            .recipeList[index]);
                                  },
                                  recipeMap: SpecialOrderCartProvider
                                      .recipeList[index]
                              ),
                              Container(
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
                              SizedBox(height: 15.h,)
                            ],
                          );
                        }
                      }),
                )
              ],
            );
          }
        }
    );
  }
}
