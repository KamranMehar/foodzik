import 'package:flutter/material.dart';
import 'package:foodzik/const/colors.dart';
import 'package:google_fonts/google_fonts.dart';


class MyButton extends StatelessWidget {
   MyButton({Key? key,required this.onTap,required this.title,this.fontSize=32.0,
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
 final String text;
 final bool isLoading;
 final double padding;
 final  double fontSize;
 final VoidCallback click;
 final double spreadShadow;
 final double blurShadow;
  const LoadingButton({Key? key,
    required this.text,
    required this.click,
    this.padding=10,
    this.isLoading=false,
    this.fontSize=20,
    this.spreadShadow=4,
    this.blurShadow=20,
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
            boxShadow:  [
              BoxShadow(color: greenPrimary,
                  spreadRadius: spreadShadow,
                  blurRadius: blurShadow,
                  offset: const Offset(4, 4))
            ]
        ),
        child:isLoading?
        const Center(
            child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(color: Colors.white,strokeWidth: 1,))):
        Center(child: Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: fontSize,color: Colors.white),)),
      ),
    );
  }
}