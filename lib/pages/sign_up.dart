import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:foodzik/my_widgets/my_edit_text.dart';
import 'package:foodzik/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController phoneNumberController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Positioned(
              child: Transform.rotate(
            angle: -90 * pi / 180,
            child: Image.asset('assets/signup_bg.png'),
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.black,
                      size: 30,
                    )),
              ),
              Center(
                  child: Text(
                "Sign up",
                style: GoogleFonts.aBeeZee(color: greenTextColor, fontSize: 30),
              )),
              const SizedBox(height: 10,),
              //image
              Center(
                child:Stack(
                  children:[
                    ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: greenTextColor,width: 1),
                          color: Colors.white24,
                          shape: BoxShape.circle
                        ),
                        ///Replace with Image here---
                          child: Image.asset('assets/avatar.png',color: greenTextColor,fit: BoxFit.fitWidth,),
                      ),
                    ),
                  ),
                     Positioned(
                       bottom: 0,
                       right: 0,
                       child: IconButton(onPressed: (){},
                            icon: const Icon(Icons.add_a_photo,color: Colors.white,size: 40,)),
                     ),
                ]
                )
                ),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    child: Column(children: [
                      MyEditText(
                        child:  TextFormField(
                          controller: firstNameController,
                          style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 18),
                          decoration:  const InputDecoration(
                            border: InputBorder.none,
                            hintText: "First Name",
                            hintStyle: TextStyle(color: Colors.white70,fontSize: 18),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return "First Name is EMpty";
                            }
                          },
                        ),
                      ),
                      MyEditText(
                       child:  TextFormField(
                         controller: lastNameController,
                         style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 18),
                         decoration:  InputDecoration(
                           border: InputBorder.none,
                           hintText: "Last Name",
                           hintStyle: const TextStyle(color: Colors.white70,fontSize: 18),
                         ),
                         validator: (value){
                          if(value!.isEmpty){
                            return "Last Name is Empty";
                          }
                         },
                       ),
                      ),
                      CustomButton(onTap: (){
                        if(_formKey.currentState!.validate()){
                          print("valid");
                        }
                      }, title: "Register",
                      fontSize: 18,)
              ],),
                  ))
            ],
          ),
        ]),
      ),
    );
  }
}
