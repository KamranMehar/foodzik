import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/model%20classes/user.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:foodzik/my_widgets/my_edit_text.dart';
import 'package:foodzik/utils/dialogs.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/colors.dart';
import 'home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool visiblePass=false;
  late MyUser user;
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
       // backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Login",
          style: GoogleFonts.aBeeZee(color: greenTextColor, fontSize: 30),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 30,
            )),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: SizedBox(
                  height: size.height,
                  child: Image.asset("assets/white_rice.png",fit: BoxFit.fitHeight,)),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text("Welcome back",style: GoogleFonts.aBeeZee(color: greenTextColor,fontSize: 15),),),
                 SizedBox(height: size.height* 1/5,),
                MyEditText(
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 18),
                      decoration:  const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email Address",
                        hintStyle: TextStyle(color: Colors.white70,fontSize: 18),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Email is Empty";
                        }else{
                          user.email=emailController.text;
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                //set Password
                MyEditText(
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      obscureText: visiblePass? false:true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 18),
                      decoration:   InputDecoration(
                        suffixIcon: IconButton(
                            color: Colors.grey,
                            onPressed: (){
                              if(!visiblePass){
                                visiblePass=true;
                              }else{
                                visiblePass=false;
                              }
                              setState(() {});
                            }, icon: visiblePass? const Icon(Icons.visibility_off,color: Colors.white,):  Icon(Icons.visibility,color: Colors.white,)),
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: const TextStyle(color: Colors.white70,fontSize: 18),
                      ),

                      validator: (value){
                        if(value!.isEmpty){
                          return "Password is Empty";
                        }else{
                         // user.password=passwordController.text;
                        }
                      },
                    ),
                  ),
                ),
                  SizedBox(height: size.width* 3/5,),
                  //Button
                  LoadingButton(
                    padding: 15,
                    isLoading: loading,
                      text: "Login",
                      click: (){
                      setState(() {
                        loading=true;
                      });
                      loginUser(emailController.text, passwordController.text);
                      }),
                  SizedBox(height: size.width* 1/5,),
              ],),
            )
          ],
        ),
      ),
    );
  }

  void loginUser(String email, String password) async {
    
    FirebaseAuth auth=FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email, password:password).then((value)
      =>{
        Utils.showToast("Login Successfully"),
      setState(() {
      loading=false;
      }),
        Navigator.pushNamedAndRemoveUntil(context, '/mainScreen', (route) => false)
        //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => true)
      } );
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading=false;
      });
      Utils.showAlertDialog( e.message.toString(),context,() => Navigator.pop(context),);
      // Your logic for Firebase related exceptions
    } catch (e) {
      Utils.showToast(e.toString());
      setState(() {
        loading=false;
      });
      // your logic for other exceptions!
    }

  }
}
