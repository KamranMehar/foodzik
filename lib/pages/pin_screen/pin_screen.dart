import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/pages/home/ui_componets/foodzik_title.dart';
import 'package:foodzik/pages/pin_screen/ui_components/loading_pin_widget.dart';
import 'package:foodzik/pages/pin_screen/ui_components/numeric_keyboard.dart';
import 'package:foodzik/provider%20classes/pin_input_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../notificationservice/notificationservice.dart';
import '../../utils/utils.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  @override
  void initState() {
    checkIfUserIsLoggedIn();
    Future.delayed(const Duration(seconds: 3),(){
      setState(() {
        isLoading=false;
      });
    });
    super.initState();
  }

  bool isLoggedIn=false;
  late String pin;
  bool isLoading=true;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    InputProvider inputProvider = Provider.of<InputProvider>(context, listen: false);

    LocalNotificationService.initialize(context);

    //String input="";
    return Scaffold(
      appBar: AppBar(title: FoodzikTitle(),
      elevation: 0,
        centerTitle: true,
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Enter The Pin You Have Set",style: GoogleFonts.aBeeZee(fontSize: 14),),
          SizedBox(width: MediaQuery.of(context).size.width,),
          const Spacer(),
       isLoading==true?const Center(child: LoadingPinRow(),):
       FutureBuilder<String?>(
          future: getPinPref(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While waiting for the data to load, show a loading indicator
              return const Center(child: LoadingPinRow());
            } else if (snapshot.data == null) {
              // if data is null means user has not set pin before
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(context, '/firstScreen', (route) => false);
              });
              return const Center(child: LoadingPinRow()); // Return an empty Loading Widget while waiting for the navigation to occur
            } else {
               pin=snapshot.data??"";
              return
                SizedBox(
                  height: 60,
                  child: Consumer<InputProvider>(
                    builder: (context,val,child) {
                      Color color=theme.brightness==Brightness.light?Colors.black:Colors.white;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration:
                              BoxDecoration(
                                 color: val.input.isNotEmpty? color:Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: theme.brightness==Brightness.light?Colors.black:Colors.white,width: 5)
                              ),
                            ),
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration:
                              BoxDecoration(
                                  color: val.input.length>=2? color:Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: theme.brightness==Brightness.light?Colors.black:Colors.white,width: 5)
                              ),
                            ),
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration:
                              BoxDecoration(
                                  color: val.input.length>=3? color:Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: theme.brightness==Brightness.light?Colors.black:Colors.white,width: 5)
                              ),
                            ),
                            Container(
                              width: 50.0,
                              height: 50.0,
                              decoration:
                              BoxDecoration(
                                  color: val.input.length>=4? color:Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: theme.brightness==Brightness.light?Colors.black:Colors.white,width: 5)
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                );
            }
          },
        ),
        Spacer(),
          NumericKeyboard(
            onNumberPressed: (number) {
             // print("pressed: $number");
              if(number.contains("<")){
                print("decrement called");
                inputProvider.decrementInput();
                print(inputProvider.input);
              }else if(number.contains("C")){
                print("clear");
                inputProvider.clearInput();
              } else{
                inputProvider.input=number;
                print(inputProvider.input);
              }

              if (inputProvider.input.length == 4) {
                if (inputProvider.input.contains(pin)) {
                  print("Correct Pin");
                  if (isLoggedIn) {
                    Navigator.pushNamedAndRemoveUntil(context, '/mainScreen', (route) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(context, '/firstScreen', (route) => false);
                  }
                } else {
                  Utils.showToast("Wrong Pin");
                  inputProvider.clearInput();
                }
              }
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

  Future<String?> getPinPref()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('pin');
    return value;
  }
}

