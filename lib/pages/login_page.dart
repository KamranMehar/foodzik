import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/model%20classes/user.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:foodzik/my_widgets/my_edit_text.dart';
import 'package:foodzik/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../const/colors.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  FocusNode emailFocus=FocusNode();
  FocusNode passwordFocus=FocusNode();
  bool visiblePass=false;
  late MyUser user=MyUser();
  bool loading=false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

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
          style: GoogleFonts.aBeeZee(color: greenTextColor, fontSize: 20.sp),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
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
              child: Form(
                key: _key,
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
                        focusNode: emailFocus,
                        autofillHints: const [AutofillHints.email],
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
                            return "  Email is Empty";
                          }else{
                            user.email=emailController.text;
                          }
                          return null;
                        },
                        minLines: 1,
                        textInputAction: TextInputAction.next,
                        onTapOutside: (_){
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        onFieldSubmitted: (_){
                          Utils.fieldFocusChange(context, emailFocus, passwordFocus);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  // Password
                  MyEditText(
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        focusNode: passwordFocus,
                        autofillHints: const [AutofillHints.password],
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
                              }, icon: visiblePass? const Icon(Icons.visibility_off,color: Colors.white,):  const Icon(Icons.visibility,color: Colors.white,)),
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: const TextStyle(color: Colors.white70,fontSize: 18),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "  Password is Empty";
                          }else{
                           // user.password=passwordController.text;
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        onTapOutside: (_){
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        onFieldSubmitted: (_){
                          if(_key.currentState!.validate()){
                            setState(() {
                              loading=true;
                            });
                            loginUser(emailController.text, passwordController.text);
                          }
                        },
                      ),
                    ),
                  ),
                    SizedBox(height: size.width* 3/5,),
                    //Button
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 5.h),
                      child: LoadingButton(
                        padding: 15,
                        isLoading: loading,
                          fontSize: 17.sp,
                          text: "Login",
                          click: (){
                          if(_key.currentState!.validate()){
                            setState(() {
                              loading=true;
                            });
                            loginUser(emailController.text, passwordController.text);
                          }
                          }),
                    ),
                    SizedBox(height: size.width* 1/5,),
                ],),
              ),
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
        Utils.snackBar("Login Successfully",context,false),
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
