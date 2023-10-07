import 'package:flutter/material.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:foodzik/pages/home/ui_componets/foodzik_title.dart';
import 'package:foodzik/pages/sign_up.dart';
import 'package:foodzik/const/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FirstScreen extends StatefulWidget {
 final bool showPinDialog;
   const FirstScreen({Key? key,this.showPinDialog=true}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {


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
      body: Stack(
        fit: StackFit.expand,
        children:[
          Positioned(
            bottom: -22.h,
            child: SizedBox(
              width: size.width,
              child: Image.asset('assets/first_screen_bg.png',
              ),
            ),
          ),

          Column(
          children: [
            Text("Order what you cock today",style: GoogleFonts.aBeeZee(color: greenPrimary,fontSize: 19.sp),),
             SizedBox(height: 10.h),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 18.w,vertical: 3.h),
              child: MyButton(
                onTap: (){
                    Navigator.pushNamed(context, "/login");
                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
                },
                title: "Login",
                padding: 3.w,
              fontSize: 17.sp,),
            ),
            SizedBox(height: 5.h,),
            Padding(
              padding:  EdgeInsets.only(left: 18.w,right: 18.w,top: 5.h,bottom: 1.h),
              child: MyButton(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignupPage()));
                },
                title: "Sign up",
                padding: 3.w,
                fontSize: 17.sp,),
            ),
            Text("Don't have account",style: GoogleFonts.aBeeZee(fontSize: 16.sp),),
          ],
        ),

        ]
      ),
    );
  }
}
