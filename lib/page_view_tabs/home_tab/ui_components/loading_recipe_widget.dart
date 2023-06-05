import 'package:flutter/material.dart';

class LoadingRecipe extends StatelessWidget {
  bool isThemeDark;
  LoadingRecipe({super.key,
    required this.isThemeDark,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,//size.height* 1/10,
      width: 155,//size.width* 4/10,
      child: Stack(
        children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 145,
            height: 200,//size.height* ((1/10)/2),
            decoration: BoxDecoration(
              color: isThemeDark?Colors.grey.shade600:Colors.grey.shade400,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 150,//size.height* ((1/10)/2),
              width: 155,
              decoration: BoxDecoration(
                color: isThemeDark?Colors.grey.shade700:Colors.grey.shade500,
                shape: BoxShape.circle,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
