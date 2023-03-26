import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodzik/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
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
              style: GoogleFonts.aBeeZee(color: greenPrimary, fontSize: 30),
            )),
            Center(
              child:ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: greenPrimary,width: 1),
                      color: Colors.white24,
                      shape: BoxShape.circle
                    ),
                    ///Replace with Image here
                    child: Icon(Icons.person,color: greenPrimary,size: 90,),
                  ),
                ),
              ) ),
          ],
        ),
      ]),
    );
  }
}
