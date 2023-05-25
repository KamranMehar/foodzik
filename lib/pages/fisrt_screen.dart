import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:foodzik/pages/home/home_page.dart';
import 'package:foodzik/pages/home/ui_componets/foodzik_title.dart';
import 'package:foodzik/pages/login_page.dart';
import 'package:foodzik/pages/sign_up.dart';
import 'package:foodzik/theme/colors.dart';
import 'package:foodzik/utils/dialogs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
  bool showPinDialog;
   FirstScreen({Key? key,this.showPinDialog=true}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  @override
  void initState() {
    checkIfUserIsLoggedIn();
     checkAppPin();
    super.initState();
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
      if(widget.showPinDialog) {
        showPinDialog(value);
      }
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
  bool isLoggedIn=false;
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: FoodzikTitle(fontSize: 70,),
        centerTitle: true,
      ),
      body: Container(
       // height: size.height+500,
       // width: size.width,
        child: Stack(
          children:[
            Positioned(
              bottom: -170,
              child: SizedBox(
                width: size.width,
                child: Image.asset('assets/first_screen_bg.png',
                ),
              ),
            ),

            Column(
            children: [
              Text("Order what you cock today",style: GoogleFonts.aBeeZee(color: greenPrimary,fontSize: 21),),
               SizedBox(height: size.width*1/5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                child: CustomButton(
                  onTap: (){
                      Navigator.pushNamed(context, "/login");
                    //  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
                  },
                  title: "Login",
                  padding: 10,
                fontSize: 25,),
              ),
              const SizedBox(height: 50,),
               Padding(padding: const EdgeInsets.all(15),
              child: Text("Don\'t have account",style: GoogleFonts.aBeeZee(fontSize: 16),),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                child: CustomButton(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                  },
                  title: "Sign up",
                  padding: 10,
                  fontSize: 25,),
              ),
            ],
          ),

          ]
        ),
      ),
    );
  }
}
