import 'package:flutter/material.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/colors.dart';

class InputTimeDialog extends StatelessWidget {
  Size size;
  void Function(String) onTimeInputDone;
  InputTimeDialog({Key? key,required this.size,
    required this.onTimeInputDone
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String hour="00";
    String minute="00";
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: size.height* 5/10,
        width: size.width* 4/5,
        child: Stack(
          children: [
            Row(children: [
              Text("Hours",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 30),),
              Spacer(),
              Text("Minutes",style:  GoogleFonts.aBeeZee(color: Colors.white,fontSize: 30),),
            ],),
            Center(
              child: Row(
                children: [
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                        itemExtent:50,
                        perspective: 0.01,
                        onSelectedItemChanged: (currentIndex){
                         hour='${currentIndex.toString()} hr ';
                        },
                        physics: const FixedExtentScrollPhysics(),
                        childDelegate: ListWheelChildBuilderDelegate(
                            childCount: 24,
                            builder: (context,index){
                              return Container(
                                child: Text("$index",style: GoogleFonts.aBeeZee(color:Colors.white,fontSize: 25),),
                              );
                            }
                        )),
                  ),
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                        itemExtent:50,
                        perspective: 0.01,
                        physics: FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (currentIndex){
                         minute='${currentIndex.toString()} min';
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                            childCount: 60,
                            builder: (context,index){
                              return Container(
                                child: Text("$index",style: GoogleFonts.aBeeZee(color:Colors.white,fontSize: 25),),
                              );
                            }
                        )),
                  )
                ],
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: greenPrimary,width: 2)
                ),
              ),
            ),
            Positioned(
                top: size.height* 5/11,
                left: 20,
                right: 20,
                bottom: 0,
                child: MyButton(
                    fontSize: 15,
                    onTap: (){
                          onTimeInputDone("$hour$minute");
                          Navigator.pop(context);
                    }, title: "Done"))
          ],
        ),
      ),
    );
  }
}
