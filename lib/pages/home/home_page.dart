
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:foodzik/model%20classes/user.dart';
import 'package:foodzik/pages/home/ui_componets/foodzik_title.dart';
import 'package:foodzik/pages/home/ui_componets/user_profile.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum MenuAction{
  logout,
  settings,
  approveNewUsers,
  }

class _HomePageState extends State<HomePage> {

  FirebaseAuth auth=FirebaseAuth.instance;
  bool isAdmin=false;
  bool isRegistrationApproved=false;
  String userImage='';
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    bool isDark=false;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      // backgroundColor: ,
      appBar: AppBar(
       // backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 60,
        leading:   InkWell(
          onTap: ()=>ZoomDrawer.of(context)!.toggle(),
          child:  Padding(
            padding: const EdgeInsets.only(left: 10),
            child:ProfileImage(userImageFuture: fetchUserImage(),size: 40,)
          ),
        ),
        title:  FoodzikTitle(),
          centerTitle: true,
        actions: [
          ///notifications
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Badge(
                alignment: Alignment.center,
                label: Text("5",style: GoogleFonts.aBeeZee(),),
                child: IconButton(onPressed: (){},
                    icon:  Icon(Icons.notifications,size: 35,color: theme.brightness==Brightness.light?Colors.black:
                      Colors.white,))),
          )
        ],
      ),
     body: SafeArea(
       child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
        ///admin banner
       AdminBanner(isAdmin: isAdmin, size: size),
         //Slogan
          Padding(
           padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
           child: SloganText(fontSize: 16,)
         ),
         const Spacer(),
          //Approval Waiting Text fo user
          Visibility(
            visible: isRegistrationApproved,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text("Your Registration is not currently approved by Admin\nWait For Admin Approval",
               style: GoogleFonts.readexPro(color: Colors.red,fontSize: 18),),),
            ),
          ),
         const Spacer(),
       ],
     ),
     )
    );
  }
  @override
  void initState() {
    checkUserIsAdmin();
    checkRegistrationApproval();

    super.initState();
  }
  Future<String> fetchUserImage() async {
    try {
      var userId = FirebaseAuth.instance.currentUser!.uid;
      DatabaseReference ref =
      FirebaseDatabase.instance.ref('/Users/$userId');
      var snapshot = await ref.get();
      if (snapshot.exists) {
        Map<dynamic, dynamic> mapList = snapshot.value as dynamic;
        if (mapList.isNotEmpty) {
          MyUser myUser = MyUser.fromJson(mapList);
          return myUser.imagePath;
        } else {
          print("No user data found");
          return '';
        }
      } else {
        print("No snapshot found");
        return '';
      }
    } catch (error) {
      print("Error fetching user image: $error");
      return '';
    }
  }

  checkUserIsAdmin()async{
    FirebaseAuth auth=FirebaseAuth.instance;
   final uId=  auth.currentUser!.uid;
     DatabaseReference ref = FirebaseDatabase.instance.ref("admin_uid/$uId");
     ref.once().then((event){
       final dataSnapshot=event.snapshot;
       if(dataSnapshot.exists){
         print("Is Admin");
         setState(() {

         });
         isAdmin=true;
        final myValue=dataSnapshot.value;
        print(myValue);
       }else{
         setState(() {

         });
         print("Not Admin");
         isAdmin=false;
       }
     });
  }

  checkRegistrationApproval()async{
    FirebaseAuth auth=FirebaseAuth.instance;
    final uId=  auth.currentUser!.uid;
    final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

    databaseReference.child('/PendingApprovalUsers/$uId').once().then((event) {
      final dataSnapshot=event.snapshot;
      if (dataSnapshot.exists) {
        setState(() {
          print("User Registration is not approved");
          isRegistrationApproved=true;
        });

      } else {
        setState(() {
          print("User Registration is  approved");
          isRegistrationApproved=false;
        });

      }
    });
  }


}
