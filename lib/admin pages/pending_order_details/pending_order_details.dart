import 'package:flutter/material.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/back_button.dart';
import 'package:foodzik/provider%20classes/theme_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../tab_pages/cart_tab/components/cart_ingredient_tile.dart';

class PendingOrderDetails extends StatefulWidget {
  const PendingOrderDetails({super.key});

  @override
  State<PendingOrderDetails> createState() => _PendingOrderDetailsState();
}

class _PendingOrderDetailsState extends State<PendingOrderDetails> {
  List<Map<dynamic, dynamic>> orderList=[];

  @override
  Widget build(BuildContext context) {
    final themModel=Provider.of<ModelTheme>(context);
    bool isThemeDark=themModel.isDark;
    orderList=ModalRoute.of(context)?.settings.arguments as List<Map<dynamic,dynamic>>;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackLeadingBtn(),
        centerTitle: true,
        title: Text("Order Details",style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,fontSize: 18.sp),),
      ),
      body: ListView.builder(
          itemCount: orderList.length,
          itemBuilder: (context,index){
            List<Map<dynamic, dynamic>> ingredients=List<Map<dynamic, dynamic>>.from(orderList[index]['ingredients']);

            return Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                    color: isThemeDark?Colors.white:Colors.black,width: 1),
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: NetworkImage(orderList[index]["imageForeground"]),
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
                        child: Image.network(orderList[index]["image"]),
                      ),
                    ],
                  ),
                  Text("${orderList[index]["name"]}",
                    style: GoogleFonts.abel(fontSize: 20.sp,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                  Text("for ${orderList[index]["perPerson"]} Persons",
                      style: GoogleFonts.abel(fontSize: 18.sp),overflow: TextOverflow.ellipsis),
                  Text("RS:/ ${orderList[index]["price"]}",
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
          })
    );
  }
}
