
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/admin%20pages/approval_pending_users.dart';
import 'package:foodzik/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseAuth auth=FirebaseAuth.instance;
  bool isAdmin=false;
  bool isRegistrationApproved=false;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
     body: SafeArea(
       child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         //app bar
         Padding(
           padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               CircleAvatar(radius: 25,
                 backgroundColor: Colors.grey[300],
                 backgroundImage: const NetworkImage("https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),),
               Text("Foodzik",style: GoogleFonts.kolkerBrush(color: Colors.black,fontSize:40),),
               SizedBox(
                   height: 40,
                   width: 40,
                   child: Image.asset("assets/menu.png")),

             ],),
         ),
        Visibility(
          visible: isAdmin,
          child: Container(
            height: 12,
            width: size.width,
            color: greenPrimary,
            child: Center(child: Text("Admin",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 12),),),
          ),
        ),
         //slogan
         Padding(
           padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
           child: Text("Let\'s find\nWhat to cock today",style: GoogleFonts.viga(fontSize: 21,color: Colors.black),),
         ),
         const Spacer(),
          Visibility(
            visible: isRegistrationApproved,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text("Your Registration is not currently approved by Admin\nWait For Admin Approval",
               style: GoogleFonts.readexPro(color: Colors.red,fontSize: 18),),),
            ),
          ),
         Visibility(
             visible: isAdmin,
             child: Center(
               child: InkWell(
                 onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserApprovalPage()));
                 },
                 child: Container(
                   margin: const EdgeInsets.all(15),
                   decoration: BoxDecoration(color: greenPrimary,
                      borderRadius: BorderRadius.circular(15)
                   ),
                   padding:const EdgeInsets.all(10),
                  child:Text("Approve new Users Registration",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 15),),
         ),
               ),
             )),
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
