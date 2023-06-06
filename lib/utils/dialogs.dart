
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzik/pages/home/home_page.dart';
import 'package:foodzik/const/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils{
  static showToast(String text){

    Fluttertoast.showToast(
        msg: text,
        fontSize: 15,
        gravity: ToastGravity.TOP,
        textColor: Colors.white,
        backgroundColor: greenPrimary.withOpacity(0.8));
  }
  static showError(String title,String error, context){
    AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: title,
        desc: error,
      btnOkOnPress: (){},
      btnOkColor: greenPrimary
    ).show();
  }
  static showAlertDialog(String title, context,callBack){
    AwesomeDialog(
        context: context,
        dialogType: DialogType.question,
        animType: AnimType.rightSlide,
        title: title,
      btnCancelText: "No",
      btnOkText: "Yes",
      btnOkOnPress: callBack,
      btnCancelOnPress: (){},
      btnOkColor: greenPrimary
    ).show();
  }

}