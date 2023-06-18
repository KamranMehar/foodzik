import 'package:flutter/material.dart';

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
          image: NetworkImage(url,),
          fit: BoxFit.contain,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
