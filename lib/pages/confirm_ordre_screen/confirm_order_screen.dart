import 'dart:ui';
import 'dart:developer'as developer show log;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/back_button.dart';
import 'package:foodzik/const/colors.dart';
import 'package:foodzik/model%20classes/Recipe.dart';
import 'package:foodzik/model%20classes/order_model.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:foodzik/provider%20classes/cart_provider.dart';
import 'package:foodzik/provider%20classes/is_admin_provider.dart';
import 'package:foodzik/provider%20classes/special_order_cart_provider.dart';
import 'package:foodzik/utils/sendNotification.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../my_widgets/my_edit_text.dart';
import '../../utils/dialogs.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({super.key});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  List<Map> orderList = [];
   String? totalPrice;
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? latLong;
  String? userName;
  bool isLoadingLoc=false;
  bool isLoading=false;
  Order order=Order();
  //String adminFcm="";

  @override
  void initState() {
    super.initState();
    setUserDataToControllers();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    orderList = (ModalRoute.of(context)?.settings.arguments as List<Map>?)!;
  //  getAdminFcmToken();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackLeadingBtn(),
        title: Text(
          "Order Confirmation",
          style: GoogleFonts.aBeeZee(fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer<CartProvider>(builder: (context, value, child) {
            if(value.totalPrice==0){
              return Consumer<SpecialOrderCartProvider>(builder: (context,special,child){
                totalPrice=special.totalPrice.toString();
                return Text(
                  "Total: ${special.totalPrice}",
                  style: GoogleFonts.aBeeZee(
                      fontSize: 18.sp, fontWeight: FontWeight.bold),
                );
              });
            }else{
              totalPrice=value.totalPrice.toString();
              return Text(
                "Total: ${value.totalPrice}",
                style: GoogleFonts.aBeeZee(
                    fontSize: 18.sp, fontWeight: FontWeight.bold),
              );
            }

          }),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyEditText(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      helperText: "phone",
                    ),
                  ),
                )),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Text("Order on Current Location  "),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: MyEditText(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: addressController,
                            style: GoogleFonts.aBeeZee(
                                color: Colors.white, fontSize: 18),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Address",
                              hintStyle: TextStyle(
                                  color: Colors.white70, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
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
                                  colors: [
                                    Colors.white.withOpacity(0.5),
                                    Colors.grey.withOpacity(0.7),
                                  ]),
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: greenTextColor, width: 1),
                            ),
                            child:isLoadingLoc?
                            const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            )
                                :const Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Align(
              alignment: Alignment.centerLeft, child: Text(" Your Orders")),
          Expanded(
              child: ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      elevation: 2,
                      color: Colors.grey.withOpacity(0.3),
                      child: ListTile(
                        title: Text("${orderList[index]['name']}"),
                        trailing: Text("Price ${orderList[index]['price']}"),
                      ),
                    );
                  })),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 5.h),
            child: LoadingButton(
                fontSize: 18.sp,
                text: "Place Order",
                click: (){
                  if(phoneController.text.isNotEmpty || addressController.text.isNotEmpty
                  || latLong!=null
                  ){

                    setState(() {
                      isLoading=true;
                    });
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final uid = auth.currentUser?.uid;

                    if (uid != null) {
                      final ordersRef = FirebaseDatabase.instance.ref('Orders/PendingOrders/$uid');
                      ordersRef.set({
                        "address": addressController.text,
                        "coordinates": latLong,
                        "orderRecipes": orderList,
                        "phoneNumber": phoneController.text,
                        "userName":userName,
                        'totalPrice': totalPrice
                      }).then((value)async{
                        Utils.showToast("Order Placed Successfully");
                        setState(() {
                          isLoading=false;
                        });

                          SendPushNotification.sendNotification("New Order","$userName is Placed Order",);
                          Future.delayed(const Duration(seconds: 2),(){
                            final cartProvider=Provider.of<CartProvider>(context,listen: false);
                            cartProvider.clearList();
                            Navigator.pushNamedAndRemoveUntil(context, "/mainScreen", (route) => false);
                          });

                      }).onError((error, stackTrace){
                        Utils.showToast("Unable To place Order \nCheck our Internet And try Again");
                        setState(() {
                          isLoading=false;
                        });
                      });

                    }
                  }else{
                    Utils.showToast("Incorrect Data or Fill all Data");
                  }
                }),
          ),
        ],
      ),
    );
  }

  Future<bool> setUserDataToControllers() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final uid = auth.currentUser?.uid;

    if (uid != null) {
      final userRef = FirebaseDatabase.instance.ref('Users/$uid');
      final snapshot = await userRef.get();

      if (snapshot.exists) {
        final userData = snapshot.value as Map<dynamic, dynamic>;

        if (userData.containsKey('address')) {
          addressController.text = userData['address'] ?? "";
        }

        if (userData.containsKey('phoneNumber')) {
          phoneController.text = userData['phoneNumber'].toString();
        }
        if (userData.containsKey('coordinates')) {
          latLong = userData['coordinates'].toString();
        }
        if (userData.containsKey('firstName') || userData.containsKey('lastName')) {
          userName ="${userData['firstName'].toString()} ${userData['lastName'].toString()}";
        }
       // setState(() {});
      } else {
        return false;
        // The user data does not exist.
        // Handle this case according to your requirement.
      }
    }
    return false;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Utils.showErrorDialog(
        "Location Access",
        "Location services are disabled!\n Go to Settings>>Location>>Location Turn On.",
        context,
        () => Navigator.pop(context),
      );
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
        Utils.showErrorDialog(
          "Location Access",
          "Location permissions are denied !",
          context,
          () => Navigator.pop(context),
        );
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Utils.showErrorDialog(
          "Location Access",
          'Location permissions are permanently denied, we cannot request permissions.',
          context,
          () => Navigator.pop(context));
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getLatLong() {
    setState(() {
      isLoadingLoc=true;
    });
    Future<Position> data = _determinePosition();
    data.then((value) {
      if (kDebugMode) {
        print("value $value");
      }
      setState(() {
        latLong="${value.latitude},${value.longitude}";
        isLoadingLoc=false;
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
      String address =
          "${placemarks[0].subLocality!},${placemarks[0].locality!},${placemarks[0].subAdministrativeArea!},"
          " ${placemarks[0].administrativeArea}, ${placemarks[0].country}";

      addressController.text = address;
    });

    for (int i = 0; i < placemarks.length; i++) {
      if (kDebugMode) {
        print("INDEX $i ${placemarks[i]}");
      }
    }
  }

/*  Future<void> getAdminFcmToken() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("admin_token/fcmToken");
    ref.once().then((event) async {
      final dataSnapshot = event.snapshot;

      final adminFcm = dataSnapshot.value as String; // Treat it as a String
      developer.log("Fetch Token: $adminFcm");
    });
  }*/

}
