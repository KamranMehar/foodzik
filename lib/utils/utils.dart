import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzik/const/colors.dart';
import 'package:foodzik/pages/home/ui_componets/foodzik_title.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider classes/theme_model.dart';

class Utils{
  var context;
  static showToast(String text){

    Fluttertoast.showToast(
        msg: text,
        fontSize: 15,
        gravity: ToastGravity.TOP,
        textColor: Colors.white,
        backgroundColor: greenPrimary.withOpacity(0.8));
  }

  static showErrorDialog(String title,error,context,void Function() onTap){
    Size size=MediaQuery.of(context).size;
    showDialog(context: context, builder: (context){
      final modelTheme=Provider.of<ModelTheme>(context);
      bool isThemeDark=modelTheme.isDark;
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          height: size.height* 5/10,
          width: size.width* 4/6,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                 // padding: const EdgeInsets.only(top: 50),
                  margin: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    color: isThemeDark ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        color: greenTextColor,
                        spreadRadius: 5,
                        blurRadius: 12,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const Spacer(flex: 2,),
                    Text(title,style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,fontSize: 23),),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: size.height* 2/10,
                        child: Text(
                        error,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.aBeeZee(fontSize: 18),
                  ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DialogButton(
                          text: "Cancel", color: CupertinoColors.destructiveRed, onTap: (){
                        Navigator.pop(context);
                      }),
                    DialogButton(
                        text: "OK", color: CupertinoColors.activeGreen, onTap:onTap),

                  ],),)
                  ],),
                ),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                   padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: isThemeDark ? Colors.black : Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 0),
                      color: greenTextColor,
                      spreadRadius: 5,
                      blurRadius: 12,
                    )
                  ],
                ),
                  child: FoodzikTitle(fontSize: 40,))),
            ],
          ),
        ),
      );
    });
  }

  static showAlertDialog(String message,BuildContext context,VoidCallback callback){
    Size size=MediaQuery.of(context).size;
    showDialog(context: context, builder: (context){
      final modelTheme=Provider.of<ModelTheme>(context);
      bool isThemeDark=modelTheme.isDark;
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          height: size.height* 5/10,
          width: size.width* 4/6,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  // padding: const EdgeInsets.only(top: 50),
                  margin: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    color: isThemeDark ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        color: greenTextColor,
                        spreadRadius: 5,
                        blurRadius: 12,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2,),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: size.height* 2/10,
                          child: Text(
                            message,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.aBeeZee(fontSize: 18),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                        child: Center(
                          child: DialogButton(
                              text: "OK", color: CupertinoColors.activeGreen, onTap: callback,),
                        ),)
                    ],),
                ),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: isThemeDark ? Colors.black : Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 0),
                            color: greenTextColor,
                            spreadRadius: 5,
                            blurRadius: 12,
                          )
                        ],
                      ),
                      child: FoodzikTitle(fontSize: 40,))),
            ],
          ),
        ),
      );
    });
  }
  static snackBar(String message, BuildContext context,bool isError){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor:isError? Colors.red:CupertinoColors.activeGreen,
            content: Text(message ,style: GoogleFonts.poppins(color: Colors.white),))
    );
  }

  static void fieldFocusChange(BuildContext context , FocusNode current , FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static Future<bool?> showAreYouSureDialog(String title, String question, BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return YesNoDialogWidget(
          title: title,
          question: question,
          onSelect: (bool select) {
            Navigator.pop(context, select);
          },
        );
      },
    );
  }

}

class DialogButton extends StatelessWidget {
final String text;
 final Color color;
 final VoidCallback onTap;
   const DialogButton({Key? key,required this.text,required this.color,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Center(child: Text(text,style: GoogleFonts.aBeeZee(fontSize: 18),),),
      ),
    );
  }
}


class MyAlertDialog extends StatelessWidget {
  final String title;
  final String message;

  const MyAlertDialog({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ModelTheme>(context);
    bool isThemeDark=themeProvider.isDark;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: isThemeDark?Colors.grey.shade800:Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              message,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text("OK"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class YesNoDialogWidget extends StatelessWidget {
  const YesNoDialogWidget({Key? key, required this.title, required this.question, required this.onSelect});
  final String title;
  final String question;
  final Function(bool) onSelect;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(question),
      actions: [
        ElevatedButton(
          onPressed: () {
            onSelect(true);
          },
          child: const Text("Yes"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("No"),
        ),
      ],
    );
  }
}