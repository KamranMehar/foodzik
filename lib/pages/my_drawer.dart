import 'package:flutter/material.dart';
import 'package:foodzik/model%20classes/theme_model.dart';
import 'package:foodzik/my_widgets/drawer_tile.dart';
import 'package:foodzik/pages/home/ui_componets/foodzik_title.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../theme/colors.dart';


class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}



class _MyDrawerState extends State<MyDrawer> {



  double height=10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: FoodzikTitle(fontSize: 70),elevation: 0,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [

              const SizedBox(height: 50,),
              DrawerTile(onTap: (){

              }, text: "change Theme"),
                SizedBox(height: height,),
              DrawerTile(onTap: (){}, text: "Profile"),
               SizedBox(height: height,),
              DrawerTile(onTap: (){}, text: "History"),
               SizedBox(height: height,),
              DrawerTile(onTap: (){}, text: "Logout"),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                offset: Offset(4,4),
                blurRadius: 7,
                spreadRadius: 2
            )
          ],
          gradient:  const LinearGradient(colors: [
            Colors.blue,
            greenTextColor,
          ]),
          // color: greenTextColor,
          borderRadius: BorderRadius.circular(15)
      ),
     width: MediaQuery.of(context).size.width* 4/5,
      child: Row(
        children: [
          Text("Dark Theme",style:GoogleFonts.aBeeZee(fontSize: 16,color: Colors.white)),
          const Spacer(),
          Switch.adaptive(
            inactiveThumbColor: Colors.white,
              value: modelTheme.isDark, onChanged: (value){
                modelTheme.isDark=value;
          }),
        ],
      ),
    );
  }
}
