import 'package:flutter/material.dart';

import 'bnv_custom_painter_class.dart';

class BNV extends StatelessWidget {
  Size size;
  bool isThemeLight;
  Function(int) onPress;
   BNV({Key? key,
  required this.size,
  required this.isThemeLight,
  required this.onPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      height: 130,
      width: size.width,
      child: Stack(
        children: [
          //Home

        Align(
          alignment: Alignment.bottomCenter,
          child: CustomPaint(
            size: Size(size.width+50,(80).toDouble()),//size.width*0.23672566371681417).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
            painter: RPSCustomPainter(filColor: isThemeLight?
            Colors.grey.shade300:Colors.grey.shade800,
                stockColor:isThemeLight?Colors.grey.shade500:Colors.grey.shade600 ),
          ),
        ),
          Positioned(
            bottom: 25,
            left: size.width* ((1/2)-60),
            right: size.width* ((1/2)-60),
            child: InkWell(
              onTap: (){
                onPress(1);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                margin: const EdgeInsets.only(bottom: 10),
                height: 70,
                width: 70,
                decoration:
                 BoxDecoration(
                    border: Border.all(color: isThemeLight?Colors.white:Colors.grey.shade800,width: 0.6),
                 //  color: Colors.white,//const Color(0xff00FFE1),
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                        stops: [0.2, 0.7],
                        radius: 1,
                        colors: [Color(0xff00FFE1),Color(0xff009987)]),
                    boxShadow:   [
                      BoxShadow(
                          color: const Color(0xff00FFE1).withOpacity(0.6),//Color(0xff1F8171),
                          spreadRadius: 2,
                          blurRadius: 20,
                          offset: const Offset(0,0)
                      ),
                    ]
                ),
                child: const Icon(Icons.home_filled,color: Colors.white,size: 30,),
              ),
            ),
          ),
        Positioned(
            left: 20,
            bottom: 12,
            child: IconButton(onPressed: (){
              onPress(0);
            }, icon: Icon(Icons.favorite_rounded,color: Colors.grey.shade500,size: 35,))),
          Positioned(
            right: 20,
            bottom: 12,
            child: IconButton(onPressed:(){
              onPress(2);
            }, icon: Icon(Icons.shopping_bag,color: Colors.grey.shade500,size: 35,))),
      ],),
    );
  }
}
