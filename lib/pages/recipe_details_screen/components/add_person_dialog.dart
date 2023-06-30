import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/const/colors.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:foodzik/provider%20classes/theme_model.dart';
import 'package:foodzik/utils/dialogs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PersonDialog extends StatelessWidget {
  final Map recipeMap;
  const PersonDialog({Key? key,required this.recipeMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final modelTheme=Provider.of<ModelTheme>(context,listen: false);
    bool isThemeDark=modelTheme.isDark;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Consumer<PersonDialogProvider>(
        builder: (context,personProvider,child) {
          personProvider._minPerson=recipeMap["perPerson"];
          return Container(
            width: 80.w,
            height: 35.h,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isThemeDark?Colors.grey.shade800:Colors.white
            ),
            child: Column(
              children: [
                Text("Add Number of Persons",style: GoogleFonts.abel(fontSize: 18.sp),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 30.w,
                          width: 30.w,
                          child: Image.network(recipeMap["image"]),
                        ),
                        Icon(CupertinoIcons.person_2,size: 21.sp,),
                        Text("${personProvider._person}",style: GoogleFonts.abel(fontSize: 25.sp),)
                      ],
                    ),
                    //buttons
                    Column(
                      children: [
                        PersonDialogBtnPlus(onTap: () {
                          personProvider.addPerson();
                        },),
                        PersonDialogDec(onTap: (){
                          personProvider.decreasePerson();
                        }),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: LoadingButton(
                      spreadShadow: 2,
                      blurShadow: 10,
                      padding: 5,
                      fontSize: 15.sp,
                      text: "Add To Cart",
                      click: (){

                      }),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}

class PersonDialogBtnPlus extends StatelessWidget {
  final VoidCallback onTap;
  const PersonDialogBtnPlus({Key? key,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
        child: Icon(CupertinoIcons.add,size: 25.sp,color: greenPrimary,),
      ),
    );
  }
}

class PersonDialogDec extends StatelessWidget {
  final VoidCallback onTap;
  const PersonDialogDec({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
        child: Icon(CupertinoIcons.minus,size: 25.sp,color: greenPrimary,),
      ),
    );
  }
}



class PersonDialogProvider with ChangeNotifier{
   int _minPerson=0;
   int _person=0;

  set minPerson(int value) {
    _minPerson = value;
    _person=_minPerson;
    notifyListeners();
  }

  int get minPerson => _minPerson;

  int get person => _person;

  addPerson(){
    if(_person>=9){
      Utils.showToast("Make Special Order");
    }else {
      _person = _person + 1;
      notifyListeners();
    }
  }

  decreasePerson(){
   if(_person==_minPerson){
     Utils.showToast("Minimum Person Should be $_minPerson");
   }else{
     _person=_person-1;
     notifyListeners();
   }
  }
}