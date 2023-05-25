import 'package:flutter/material.dart';
import 'package:foodzik/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomButton extends StatelessWidget {
   CustomButton({Key? key,required this.onTap,required this.title,this.fontSize=32.0,
   this.padding=10,
   }) : super(key: key);
VoidCallback onTap;
String title;
double fontSize;
double padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: greenPrimary,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.greenAccent,width: 1),
        boxShadow: const [
          BoxShadow(color: greenPrimary,
          spreadRadius: 4,
          blurRadius: 20,
          offset: Offset(4, 4))
        ]
        ),
        child: Center(child: Text(title.toUpperCase(),style: GoogleFonts.aBeeZee(
            color: Colors.white,
          fontSize: fontSize,
        ),),),
      ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  String text;
  bool isLoading;
  double padding;

  VoidCallback click;
  LoadingButton({Key? key,
    required this.text,
    required this.click,
    this.padding=10,
    this.isLoading=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      child: Container(
       // height: 40,
        padding: EdgeInsets.all(padding),
        decoration:BoxDecoration(
            color: greenPrimary,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.greenAccent,width: 1),
            boxShadow: const [
              BoxShadow(color: greenPrimary,
                  spreadRadius: 4,
                  blurRadius: 20,
                  offset: Offset(4, 4))
            ]
        ),
        child:isLoading?
        const Center(
            child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(color: Colors.white,strokeWidth: 1,))):
        Center(child: Text(text,style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)),
      ),
    );
  }
}