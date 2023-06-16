import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodzik/const/colors.dart';

class MyEditText extends StatelessWidget {
   MyEditText({Key? key,required this.child}) : super(key: key);
Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(
            padding: const EdgeInsets.only(left: 10,),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors:
              [
                Colors.grey.withOpacity(0.2),
                Colors.grey.withOpacity(0.7),
              ]),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: greenTextColor,width: 1),
            ),
            child:
              child
          ),
        ),
      ),
    );
  }
}
