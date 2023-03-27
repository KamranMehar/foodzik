
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzik/theme/colors.dart';

class Utils{
  static showToast(String text){

    Fluttertoast.showToast(
        msg: text,
        fontSize: 15,
        gravity: ToastGravity.TOP,
        textColor: Colors.white,
        backgroundColor: greenTextColor.withOpacity(0.8));
  }
}