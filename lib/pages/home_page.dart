import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
     body: SafeArea(
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10),
         child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           //app bar
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 5,),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 CircleAvatar(radius: 25,
                   backgroundColor: Colors.grey[300],
                   backgroundImage: const NetworkImage("https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),),
                 SizedBox(
                     height: 40,
                     width: 40,
                     child: Image.asset("assets/menu.png")),

               ],),
           ),
           //slogan
           Text("Let\'s find\nWhat to cock today",style: GoogleFonts.viga(fontSize: 21,color: Colors.black),)
         ],
     ),
       ),
     )
    );
  }
}
