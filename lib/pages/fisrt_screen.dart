import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:foodzik/pages/home_page.dart';
import 'package:foodzik/pages/login_page.dart';
import 'package:foodzik/pages/sign_up.dart';
import 'package:foodzik/theme/colors.dart';
import 'package:foodzik/utils/dialogs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  @override
  void initState() {

    checkAppPin();
    // TODO: implement initState
    super.initState();
  }

  checkAppPin()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('pin');
    if(value!=null){
      print(value);
      Utils.showToast("pin found");
      TextEditingController textController = TextEditingController();

      AwesomeDialog(
        onDismissCallback: checkAppPin(),
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.SCALE,
        title: 'Enter Pin',
        desc: 'Enter your Pin:',
        body: TextFormField(
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
        btnOkOnPress: () {
          if(textController.text.contains(value)){
            Utils.showToast("Correct Pin");
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
          }else{
            Utils.showToast("Wrong Pin");
          }
        },
        btnCancelOnPress: () {},
      ).show();
     // Utils.showInputTextDialog(context);
    }else{
      Utils.showToast("pin  not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Foodzik",style: GoogleFonts.kolkerBrush(color: Colors.black,fontSize:70),),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
                  },
                  title: "Login",
                  padding: 10,
                fontSize: 25,),
              ),
              const SizedBox(height: 50,),
              Padding(padding: const EdgeInsets.all(15),
              child: Text("Don\'t have account",style: GoogleFonts.aBeeZee(color: Colors.black54,),),),
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
