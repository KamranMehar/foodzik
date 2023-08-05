import 'package:flutter/material.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/colors.dart';

class InputTimeDialog extends StatelessWidget {
 final Size size;
 final void Function(String) onTimeInputDone;
  const InputTimeDialog({Key? key,required this.size,
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
              const Spacer(),
              Text("Minutes",style:  GoogleFonts.aBeeZee(color: Colors.white,fontSize: 30),),
            ],),
            Center(
              child: Row(
                children: [
                  ///Hours Wheel
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                        itemExtent:50,
                        perspective: 0.01,
                        onSelectedItemChanged: (currentIndex){
                         hour=currentIndex.toString();
                        },
                        physics: const FixedExtentScrollPhysics(),
                        childDelegate: ListWheelChildBuilderDelegate(
                            childCount: 25,
                            builder: (context,index){
                              return Text("$index",style: GoogleFonts.aBeeZee(color:Colors.white,fontSize: 25),);
                            }
                        )),
                  ),
                  ///Minutes Wheel
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                        itemExtent:50,
                        perspective: 0.01,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (currentIndex){
                         minute=currentIndex.toString();
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                            childCount: 60,
                            builder: (context,index){
                              if(index<10){
                              return Container(
                                child: Text("0$index",style: GoogleFonts.aBeeZee(color:Colors.white,fontSize: 25),),
                              );
                              }else{
                                return Container(
                                  child: Text("$index",style: GoogleFonts.aBeeZee(color:Colors.white,fontSize: 25),),
                                );
                              }
                            }
                        )),
                  )
                ],
              ),
            ),
            ///Center Container for current value seeing
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
                      if(hour=="00"){
                        onTimeInputDone("$minute min");
                      }else{
                        onTimeInputDone("$hour hr $minute min");
                      }
                      Navigator.pop(context);
                    }, title: "Done"))
          ],
        ),
      ),
    );
  }
}
