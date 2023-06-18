import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoTab extends StatelessWidget {
  const InfoTab({Key? key, required this.size, required this.info, required this.isThemeDark}) : super(key: key);
  final Size size;
  final String info;
  final bool isThemeDark;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text("Information About Recipe",style: GoogleFonts.aBeeZee(
              color: isThemeDark?Colors.white:Colors.black,
              fontSize: 21,
              fontWeight: FontWeight.bold
          ),),
          Text(info,style: GoogleFonts.abel(fontSize: 18),)
        ],
      ),
    );
  }
}
