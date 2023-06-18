import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../const/colors.dart';

class BackLeadingBtn extends StatelessWidget {
   BackLeadingBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        FocusManager.instance.primaryFocus?.unfocus();
       await Future.delayed(const Duration(milliseconds: 600),(){
          Navigator.of(context).pop();
        });
      },
      child: Container(
        height: 30,
        width: 90,
        decoration:  const BoxDecoration(
          color: greenPrimary,
          borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight: Radius.circular(50)),
        ),
        child: const Icon(Icons.arrow_back_ios_new_rounded,size: 35,),
      ),
    );
  }
}
