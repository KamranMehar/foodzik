import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/my_widgets/user_approval_tile.dart';
import 'package:foodzik/const/colors.dart';
import 'package:foodzik/utils/dialogs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApprovalPage extends StatefulWidget {
  const UserApprovalPage({Key? key}) : super(key: key);

  @override
  State<UserApprovalPage> createState() => _UserApprovalPageState();
}

class _UserApprovalPageState extends State<UserApprovalPage> {
  DatabaseReference ref = FirebaseDatabase.instance.ref("/PendingApprovalUsers/");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading:  IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 30,
            )),
      ),
      body: StreamBuilder(
          stream: ref.onValue,
          builder: (context,AsyncSnapshot<DatabaseEvent> snapshot){
            if(snapshot.hasData){
              Map<dynamic, dynamic> ?map = snapshot.data!.snapshot
                  .value as dynamic;
              List<dynamic> list = [];
              list.clear();
              if(map!=null){
                list = map.values.toList();
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context,index){
                      return UserApprovalTile(
                          imagePath: list[index]['imagePath'],
                          firstName: list[index]['firstName'],
                          lastName: list[index]['lastName'],
                          phoneNumber: list[index]['phoneNumber'],
                          address: list[index]['address'],
                          email: list[index]['email'],
                        approve: ()async {
                          DatabaseReference ref = FirebaseDatabase.instance.ref("/PendingApprovalUsers/"+list[index]['userId']);
                          ref.remove().then((value){
                            DatabaseReference newRef = FirebaseDatabase.instance.ref("Users");
                            newRef.child(list[index]['userId']).set({
                              "address": list[index]['address'],
                              "email": list[index]['email'],
                              "firstName":list[index]['firstName'],
                              "lastName":list[index]['lastName'],
                              "phoneNumber":list[index]['phoneNumber'],
                              "imagePath":list[index]['imagePath'],
                              "pin":list[index]['pin'],
                              "userId":list[index]['userId'],
                            }).then((value){
                              sendEmail(list[index]['firstName']+" "+list[index]['lastName'],
                                  "Foodzik Account Registration Approved",
                                  "congratulations dear user the Foodzik team reviewed your account "
                                      "details and approved your registration you can access all the services provided by Foodzik",
                                  list[index]['email'] ).then((value){
                                Utils.showToast(list[index]['firstName']+"\'s registration approved successfully");
                              });
                            });

                          });
                        },);
                    });
              }else{
                return const Center(child: Text("No Data Found",style: TextStyle(color: Colors.grey),),);
              }

            }else{
              return Center(child: CircularProgressIndicator(color: greenPrimary,),);
            }
      }),
    );
  }
  Future sendEmail(String name,String subject,String message,String userEmail)async{
    final url=Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    const templateId="template_8pr17w3";
    const serviceId="service_8fmud2o";
    const userId="3qHuUrDtyZxC4hSBK";
  try {
    final response = await http.post(url,
        headers: {
        'origin':'http:localhost',
          'Content-Type':'application/json'
        },
        body: json.encode({
          "service_id": serviceId,
          "template_id": templateId,
          "user_id": userId,
          "template_params": {
            "name": name,
            "user_subject": subject,
            "message": message,
            "email": userEmail,
          }
        })
    );
    if (response.statusCode == 200) {
      print('Email sent successfully!');
    } else {
      print('Failed to send email: ${response.statusCode}');
    }

  }catch(e){
    print(e);
  }
  }


}
