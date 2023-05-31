import 'dart:math';
import 'dart:ui';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:foodzik/my_widgets/my_edit_text.dart';
import 'package:foodzik/theme/colors.dart';
import 'package:foodzik/utils/dialogs.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../model classes/user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final databaseRef=FirebaseDatabase.instance.ref("/PendingApprovalUsers/");
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController phoneNumberController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController pinController=TextEditingController();
  TextEditingController addressController=TextEditingController();
 late MyUser user;
  bool visiblePass=false;
  final picker = ImagePicker();
  File? titleImage;
  double? lat;
  double? long;
  String address = "";
  bool loading=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
        "Sign up",
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
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: titleImage!=null?
                          FileImage(titleImage!.absolute,) :
                          const AssetImage('assets/avatar.png',) as ImageProvider,),
                          border: Border.all(color: greenTextColor,width: 3),
                          color: Colors.white24,
                          shape: BoxShape.circle
                        ),

                      ),
                    ),
                  ),
                     Positioned(
                       bottom: 0,
                       right: 0,
                       child: IconButton(onPressed: (){
                         pickImage();
                       },
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
                      //first name
                      MyEditText(
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
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
                              }else{
                                user.firstName=firstNameController.text;
                              }
                            },
                          ),
                        ),
                      ),
                      //last name
                      MyEditText(
                       child:  Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 10),
                         child: TextFormField(
                           controller: lastNameController,
                           style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 18),
                           decoration:  const InputDecoration(
                             border: InputBorder.none,
                             hintText: "Last Name",
                             hintStyle: TextStyle(color: Colors.white70,fontSize: 18),
                           ),
                           validator: (value){
                            if(value!.isEmpty){
                              return "Last Name is Empty";
                            }else{
                              user.lastName=lastNameController.text;
                            }
                           },
                         ),
                       ),
                      ),
                      //phone number
                      MyEditText(
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: phoneNumberController,
                            style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 18),
                            decoration:  const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone Number",
                              hintStyle: TextStyle(color: Colors.white70,fontSize: 18),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return "Phone number is Empty";
                              }else{
                                user.phoneNumber=phoneNumberController.text;
                              }
                            },
                          ),
                        ),
                      ),
                      //email
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
                      //address
                      Row(
                        children: [
                          Expanded(
                            flex: 9,
                            child: MyEditText(
                              child:  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  controller: addressController,
                                  style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 18),
                                  decoration:   const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Address",
                                    hintStyle: TextStyle(color: Colors.white70,fontSize: 18),
                                  ),

                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Address is Empty";
                                    }else{
                                      user.address=addressController.text;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                         InkWell(
                           onTap: (){
                             getLatLong();
                             setState(() {});
                           },
                           child: ClipRRect(
                             borderRadius: BorderRadius.circular(20),
                             child: BackdropFilter(
                               filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                               child: Container(
                                 padding: const EdgeInsets.all(15),
                                 decoration: BoxDecoration(
                                   gradient: LinearGradient(
                                       begin: Alignment.topRight,
                                       end: Alignment.bottomLeft,
                                       colors:
                                       [
                                         Colors.white.withOpacity(0.5),
                                         Colors.grey.withOpacity(0.7),
                                       ]),
                                   borderRadius: BorderRadius.circular(20),
                                   border: Border.all(color: greenTextColor,width: 1),
                                 ),
                                 child:  const Icon(Icons.location_on,color: Colors.white,),
                               ),
                             ),
                           ),
                         )
                        ],
                      ),
                      //4 digit pin
                      Text("This Pin will be Entered Whenever the App opened",style: GoogleFonts.aBeeZee(fontSize: 13,color: greenTextColor),),
                      MyEditText(
                       child:  Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 20),
                         child: TextFormField(

                           maxLength: 4,
                           maxLines: 1,
                           keyboardType: TextInputType.number,
                           controller: pinController,
                           style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 18),
                           decoration:  const InputDecoration(
                             border: InputBorder.none,
                             hintText: "4 Digit Pin",
                             hintStyle: TextStyle(color: Colors.white70,fontSize: 18),
                           ),
                           validator: (value){
                            if(value!.isEmpty){
                              return "Pin is Empty";
                            }else if(value.length<4){
                              return "Enter 4 Digit Number !";
                            }else{
                             user.pin=int.parse(pinController.text);
                            }
                           },
                         ),
                       ),
                      ),
                      //register button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        child: LoadingButton(
                          isLoading:loading,
                          text: 'Register',
                          click: () {
                            setState(() {
                              loading=true;
                            });
                            if(_formKey.currentState!.validate()&& titleImage!=null){
                              registerUser(emailController.text, passwordController.text);
                            }else{
                              setState(() {
                                loading=false;
                              });
                              Utils.showError("Complete Form","Complete the Form fields also add the image", context);
                            }
                          },
                        ),
                      )
              ],),
                  ))
            ],
          ),
        ]),
      ),
    );
  }
  registerUser(String email,String password)async{
    FirebaseAuth auth=FirebaseAuth.instance;

    try{
      //creating user
      await auth.createUserWithEmailAndPassword(email: email, password: password).then((value)async{
        //after user created uploading image to storage
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref("UsersImages/${user.firstName}_${user.lastName}");
      firebase_storage.UploadTask imageUploadTask= storageRef.putFile(titleImage!.absolute);
      await Future.value(imageUploadTask).then((value) async{
        //after image uploaded get the getting the download url of the stored image
        var imageUrl = await storageRef.getDownloadURL();
        user.imagePath=imageUrl;
        //upload detail to database in the pending approval list for registration
        databaseRef.child(auth.currentUser!.uid.toString()).set({
          "userId": auth.currentUser!.uid,
          "email": email,
          "firstName": user.firstName,
          "lastName":user.lastName,
          "address":user.address,
          "phoneNumber":user.phoneNumber,
          "pin":user.pin,
          "imagePath":user.imagePath,
        }).then((value)async{
          //save pin Locally
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('pin', pinController.text).then((value) => print('pin saved locally'));
          Utils.showToast("user Created Successfully");
          setState(() {
            loading=false;
          });
          Navigator.pushNamedAndRemoveUntil(context, '/mainScreen', (route) => false);
        })
            .onError((error, stackTrace){ Utils.showError("Registration Error", error.toString(),context);
        setState(() {
          loading=false;
        });
            });
      });

      });
    }on FirebaseAuthException catch (e) {
      setState(() {
        loading=false;
      });
      Utils.showError("Registration Error", e.message.toString(),context);
      // Your logic for Firebase related exceptions
    } catch (e) {
      Utils.showToast(e.toString());
      setState(() {
        loading=false;
      });
      // your logic for other exceptions!
    }

  }


  pickImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery,imageQuality: 40);
    setState(() {
      if (pickerFile != null) {
        titleImage = File(pickerFile.path);
       // image = pickerFile.path;
      } else {
        Utils.showToast("No Image Selected");
      }
    });
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Utils.showError("Location Access","Location services are disabled!\n Go to Settings>>Location>>Location Turn On.", context);
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
       Utils.showError("Location Access","Location permissions are denied !", context);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Utils.showError("Location Access",   'Location permissions are permanently denied, we cannot request permissions.', context);
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getLatLong() {
    Future<Position> data = _determinePosition();
    data.then((value) {
      if (kDebugMode) {
        print("value $value");
      }
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });

      getAddress(value.latitude, value.longitude);
    }).catchError((error) {
      if (kDebugMode) {
        print("Error $error");
      }
    });
  }

//For convert lat long to address
  getAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    setState(() {
      address =
      "${placemarks[0].locality!},${placemarks[0].subAdministrativeArea!}, ${placemarks[0].administrativeArea}, ${placemarks[0].country}";
      user.address=address;
      addressController.text=address;
    });

    for (int i = 0; i < placemarks.length; i++) {
      print("INDEX $i ${placemarks[i]}");
    }
  }
}
