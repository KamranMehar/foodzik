import 'package:flutter/material.dart';
import 'package:foodzik/const/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainImageRecipeDetailPage extends StatelessWidget {
  const MainImageRecipeDetailPage({Key? key,
  required this.url}) : super(key: key);
final String url;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                spreadRadius: 10,
                blurRadius: 30,
                color: Colors.black.withOpacity(0.3),
                offset:const Offset(0,0)
            )
          ]
      ),
      child: ClipOval(
        child: Image(
          errorBuilder: (context,obj,stackTrace){
            return Container(
              padding: EdgeInsets.all(20.w),
                color: greenPrimary,
                child: const Icon(Icons.error_outline,color: Colors.red,));
          },
          image: NetworkImage(url,),
          fit: BoxFit.contain,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
