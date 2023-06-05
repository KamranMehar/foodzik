import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/pages/drawer/components/drawer_greeting.dart';
import 'package:foodzik/provider%20classes/theme_model.dart';
import 'package:foodzik/my_widgets/drawer_tile.dart';
import 'package:foodzik/utils/dialogs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../../provider classes/is_admin_provider.dart';


class MyDrawer extends StatefulWidget {
  bool isAdmin;
   MyDrawer({Key? key,this.isAdmin=false, }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}



class _MyDrawerState extends State<MyDrawer> {
  double height=10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,),
      body: SafeArea(
        child: Column(
          children: [
            const DrawerGreetingText(),
            const SizedBox(height: 10,),
              SizedBox(height: height,),
            DrawerTile(onTap: (){}, text: "Notifications"),
             SizedBox(height: height,),
            DrawerTile(onTap: (){}, text: "History"),
             SizedBox(height: height,),
            DrawerTile(onTap: (){
              Utils.showAlertDialog("Are you Sure to Logout", context, ()async{
                await FirebaseAuth.instance.signOut().then((value){
                  Navigator.pushNamedAndRemoveUntil(context, "/firstScreen", (route) => false);
                });
              });
            }, text: "Logout"),
            SizedBox(height: height,),
            Consumer<IsAdminProvider>(
              builder: (context,isAdminProvider,_) {
                return Visibility(
                  visible: isAdminProvider.isAdmin,
                  child: DrawerTile(onTap: (){
                    Navigator.pushNamed(context, "/addRecipe");
                  }, text: "Add Recipe"),
                );
              }
            ),
            SizedBox(height: height,),
            Consumer<IsAdminProvider>(
              builder: (context,isAdminProvider,_) {
                return Visibility(
                  visible: isAdminProvider.isAdmin,
                  child: DrawerTile(onTap: (){
                    Navigator.pushNamed(context, "/userApprovalPage");
                  }, text: "Approve User"),
                );
              }
            ),
             SizedBox(height: height,),
            const ThemeChangeWidget(),
            SizedBox(height: height,),
            //app version
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('Version : ${snapshot.data!.version}',style: GoogleFonts.aBeeZee(fontSize: 14),);
                } else   {
                  return Text('');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  Future<int> getVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return int.parse(packageInfo.buildNumber);
  }

  @override
  void initState() {
    getVersionCode();
    super.initState();
  }


}


class ThemeChangeWidget extends StatefulWidget {
  const ThemeChangeWidget({Key? key}) : super(key: key);

  @override
  State<ThemeChangeWidget> createState() => _ThemeChangeWidgetState();
}

class _ThemeChangeWidgetState extends State<ThemeChangeWidget> {
  @override
  Widget build(BuildContext context) {
    final modelTheme =Provider.of<ModelTheme>(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: modelTheme.isDark?Color(0xffD9D9D9):Color(0xff888282),
          borderRadius: BorderRadius.circular(15)
      ),
     width: MediaQuery.of(context).size.width* 4/5,
      child: Row(
        children: [
          const SizedBox(width: 10,),
          Icon(modelTheme.isDark==true?Icons.brightness_2:Icons.brightness_7,color: modelTheme.isDark?Colors.black:Colors.white,),
          const Spacer(),
          SizedBox(
            child: CupertinoSwitch(
              trackColor: Colors.grey.shade800,
              activeColor: CupertinoColors.activeGreen,
              value: modelTheme.isDark,
              onChanged: (value) {
                modelTheme.isDark=value;
              },
            ),
          ),
        ],
      ),
    );
  }
}