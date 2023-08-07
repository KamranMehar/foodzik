import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IconUnderTextWidgetFv extends StatelessWidget {
  const IconUnderTextWidgetFv({Key? key,
    required this.icon,
    required this.text,
    this.fontSize=16,
  }) : super(key: key);
  final Widget icon;
  final String text;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        Text(text,style: GoogleFonts.robotoMono(fontSize: fontSize,color: Colors.white),)
      ],
    );
  }
}