import 'package:flutter/material.dart';
import 'package:foodzik/const/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class UserApprovalTile extends StatelessWidget {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String imagePath;
  String address;
  VoidCallback approve;
   UserApprovalTile({Key? key,
    required this.imagePath,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.address,
    required this.email,
     required this.approve
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: greenPrimary,
        borderRadius: BorderRadius.circular(20),),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(imagePath),
            ),
            Text("$firstName $lastName",style: GoogleFonts.aBeeZee(fontSize: 18,color: Colors.white),),
          ],),
          Text(email,style: GoogleFonts.aBeeZee(fontSize: 18,color: Colors.white),),
          Text(address,style: GoogleFonts.aBeeZee(fontSize: 18,color: Colors.white),),
          Text(phoneNumber,style: GoogleFonts.aBeeZee(fontSize: 18,color: Colors.white),),
          InkWell(
            onTap: approve,
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text("Approve",style: GoogleFonts.aBeeZee(color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}
