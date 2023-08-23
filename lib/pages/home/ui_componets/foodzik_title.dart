import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const/colors.dart';
class FoodzikTitle extends StatelessWidget {
  double fontSize;
   FoodzikTitle({Key? key,this.fontSize=55}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkTheme ? Colors.white : Colors.black;
    return  Text("Foodzik",style: GoogleFonts.kolkerBrush(fontSize:fontSize,color: textColor),);
  }
}

class AdminBanner extends StatelessWidget {
  bool isAdmin;
  Size size;
 AdminBanner({required this.isAdmin,required this.size,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Visibility(
      visible: isAdmin,
      child: Container(
        //height: 11,
        width: size.width,
        color: greenPrimary,
        child: Center(child: Text("Admin",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 10,),),),
      ),
    );
  }
}
class SloganText extends StatelessWidget {
  double fontSize;
   SloganText({Key? key,this.fontSize=21}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Let\'s find\nWhat to cook today",style: GoogleFonts.viga(fontSize: fontSize,));
  }
}
