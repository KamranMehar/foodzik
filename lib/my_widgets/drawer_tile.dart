import 'package:flutter/material.dart';
import 'package:foodzik/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerTile extends StatelessWidget {
  VoidCallback onTap;
  String text;
   DrawerTile({Key? key,required this.onTap,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width* 4/5,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(4,4),
            blurRadius: 7,
            spreadRadius: 2
          )
        ],
        gradient: const LinearGradient(colors: [
          Colors.blue,
          greenTextColor,
        ]),

       // color: greenTextColor,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Center(child: Text(text,style: GoogleFonts.aBeeZee(fontSize: 18,color: Colors.white),)),
    );
  }
}
