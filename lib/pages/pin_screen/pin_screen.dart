import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/pages/home/ui_componets/foodzik_title.dart';
import 'package:foodzik/pages/pin_screen/ui_components/loading_pin_widget.dart';
import 'package:foodzik/pages/pin_screen/ui_components/numeric_keyboard.dart';
import 'package:foodzik/pages/pin_screen/ui_components/pin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/dialogs.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
late  final Future<int> pin;
  @override
  void initState() {
    checkIfUserIsLoggedIn();
   // checkAppPin();
    super.initState();
  }
  bool isLoggedIn=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: FoodzikTitle(),
      elevation: 0,
        centerTitle: true,
      ),
      body:  Column(
        children: [
          Text("Enter The Pin You Have Set",style: GoogleFonts.aBeeZee(fontSize: 14),),
          Spacer(),
          const Center(
              child:
              LoadingPinRow(),),
          Spacer(),
          NumericKeyboard(
            onNumberPressed: (number) {
              print('Number pressed: $number');
            },
          ),
        ],
      ),
    );
  }

  checkIfUserIsLoggedIn() async {
    // Check if the current user is null
    User? user = FirebaseAuth.instance.currentUser;
    if(user==null){
      isLoggedIn=false;
    }else{
      isLoggedIn=true;
    }
  }

  checkAppPin()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('pin');
    if(value!=null){
      print(value);
        showPinDialog(value);
    }else{
      Utils.showToast("pin  not found");
    }
  }

  showPinDialog(String value){
    TextEditingController textController = TextEditingController();
    AwesomeDialog(
      onDismissCallback: (type) {
        // SystemNavigator.pop();
      },
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.SCALE,
      title: 'Enter Pin',
      desc: 'Enter your Pin:',
      body: TextFormField(
        maxLength: 4,
        keyboardType: TextInputType.number,
        obscureText: true,
        controller: textController,
        decoration: InputDecoration(
          hintText: 'pin',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      btnOkText: 'OK',
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      isDense: true,
      btnOkOnPress: () async {
        if (textController.text.contains(value)) {
          Utils.showToast("Correct Pin");
          if (isLoggedIn) {
            Navigator.pushNamedAndRemoveUntil(context, "/mainScreen",(route) => false,);
          } else {
            Navigator.pushNamedAndRemoveUntil(context, "/login",(route) => false,);
          }
        } else {
          Utils.showToast("Wrong Pin");
          showPinDialog(value);
        }
      },
    ).show();
  }

}

