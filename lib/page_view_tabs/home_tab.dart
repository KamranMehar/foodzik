import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/home/ui_componets/bnv_custom_painter_class.dart';
import '../pages/home/ui_componets/foodzik_title.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    checkRegistrationApproval();
    super.initState();
  }

  bool isRegistrationApproved=false;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //Slogan
            Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SloganText(fontSize: 16,)
            ),
            //Approval Waiting Text fo user
            Visibility(
              visible: isRegistrationApproved,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("Your Registration is not currently approved by Admin\nWait For Admin Approval",
                    style: GoogleFonts.readexPro(color: Colors.red,fontSize: 18),),),
                ),
              ),
            ),

          ],
        ),
      );

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
