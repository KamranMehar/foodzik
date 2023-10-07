import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:foodzik/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../provider classes/theme_model.dart';
import '../../../tab_pages/cart_tab/components/cart_ingredient_tile.dart';

class PendingOrderTile extends StatelessWidget {
  const PendingOrderTile({super.key,
    required this.recipeMap,
    this.isDelivered=false
  });
  final Map recipeMap;
  final isDelivered;
  @override
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ModelTheme>(context);
    bool isThemeDark=themeProvider.isDark;
    List<Map<dynamic, dynamic>> orderList=List<Map<dynamic, dynamic>>.from(recipeMap['orderRecipes']);

    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, "/pendingOrderDetailScreen",arguments: orderList);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
              color: isThemeDark?Colors.white:Colors.black,width: 1),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Text("${recipeMap["userName"]}",
              style: GoogleFonts.abel(fontSize: 20.sp,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
            Text("Address ${recipeMap["address"]}",
                maxLines: 4,
                style: GoogleFonts.abel(fontSize: 18.sp),overflow: TextOverflow.ellipsis),
            Text("RS:/ ${recipeMap["totalPrice"]}",
                style: GoogleFonts.abel(fontSize: 18.sp),overflow: TextOverflow.ellipsis),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 10),
              child: LoadingButton(
                shadowColor: Colors.transparent,
                  fontSize: 15.sp,
                  text: "Contact and Map", click: (){
                showDialog(context: context,
                    builder: (context){
                      return   ContactUsDialog(phone: recipeMap["phoneNumber"], latLong: recipeMap["coordinates"],);
                    });
              }),
            ),
          if(isDelivered)
            Icon(Icons.check_circle,color: Colors.green,size: 15.w,)
          ],
        ),
      ),
    );
  }
}



class ContactUsDialog extends StatelessWidget {

   ContactUsDialog({super.key,required this.phone,required this.latLong});
String phone;
String latLong;
  @override
  Widget build(BuildContext context) {
    final themeModel=Provider.of<ModelTheme>(context);
    bool isThemeDark=themeModel.isDark;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 20.h,
        width: 60.w,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isThemeDark?Colors.grey.shade800.withOpacity(0.7):Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.green,width: 1)
        ),
        child: Column(
          children: [
            Text("Contact",
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 18.sp),),
            const Spacer(),
            Row(
              children: [
                const Spacer(),
                InkWell(
                    onTap: (){
                      _openMap(latLong);
                    },
                    child:  Icon(Icons.location_on_rounded,size: 30.sp,)),
                const Spacer(),
                InkWell(
                    onTap: (){
                      openPhone(phone, context);
                    },
                    child:   Icon(Icons.call,size: 30.sp,)),
                const Spacer()
              ],
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }



  void openPhone(String phoneNumber,BuildContext context)async{
    final Uri uri=Uri(scheme: 'tel',path: phoneNumber);
    try{
      launchUrl(uri);
    }catch (e){

      Utils.showToast("unable to launch telephone");
    }
  }
   void _openMap(String latLong) async {
    print(latLong);
     final mapUrl = "https://www.google.com/maps/search/?api=1&query=$latLong";

     try{
       if (await canLaunch(mapUrl)) {
         await launch(mapUrl);
       } else {
         throw 'Could not launch $mapUrl';
       }
     }catch(e){
       print(e);
     }

   }
}

