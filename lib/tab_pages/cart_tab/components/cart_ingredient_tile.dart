import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../pages/home/ui_componets/shimmar_effect.dart';


class CartIngredientTile extends StatelessWidget {
  const CartIngredientTile({
    Key? key,
    required this.name,
    required this.quantity,
    required this.image, required this.isThemeDark,
    required this.unit, required this.price,

  }) : super(key: key);
  final bool isThemeDark;
  final String name;
  final int quantity;
  final String image;
  final String unit;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 5.h,
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
              spreadRadius: 2,
              blurRadius: 7,
              color: Colors.black26,
              offset:Offset(0,4)
          )
        ],
        color:isThemeDark?Colors.grey.shade700:Colors.grey.shade300,
      ),
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          SizedBox(
              height: 7.h,
              width: 7.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(image,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return
                        ShimmerEffect(height: 7.h,
                          width: 7.h,isCircular: false,);
                    }
                  },),
              )
          ),
          Text(name,
            maxLines: 1,
            style: GoogleFonts.aBeeZee(fontSize: 14,fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,),
          Text("$quantity $unit",style: GoogleFonts.aBeeZee(fontSize: 12),overflow: TextOverflow.ellipsis,),
          Text("Rs. $price",style: GoogleFonts.aBeeZee(fontSize: 12),overflow: TextOverflow.ellipsis,),
        ],
      ),
    );
  }
}