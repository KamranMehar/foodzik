import 'package:flutter/material.dart';
import 'package:foodzik/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider classes/theme_model.dart';

class DrawerTile extends StatelessWidget {
  VoidCallback onTap;
  String text;
   DrawerTile({Key? key,required this.onTap,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final modelTheme =Provider.of<ModelTheme>(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      width: MediaQuery.of(context).size.width* 4/5,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: modelTheme.isDark?const Color(0xffD9D9D9):Color(0xff888282),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Center(child: Text(text,style: GoogleFonts.aBeeZee(fontSize: 18,color: modelTheme.isDark?Colors.black:Colors.white),)),
    );
  }
}
