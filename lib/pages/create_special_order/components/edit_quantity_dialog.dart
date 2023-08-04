import 'package:flutter/material.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:foodzik/my_widgets/my_edit_text.dart';
import 'package:foodzik/provider%20classes/create_special_order_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../provider classes/theme_model.dart';

class EditQuantityDialog extends StatefulWidget {
  const EditQuantityDialog({super.key,
    required this.ingredient,
    required this.onSelected});

  final Map ingredient;
  final Function(String) onSelected;
  @override
  State<EditQuantityDialog> createState() => _EditQuantityDialogState();
}

class _EditQuantityDialogState extends State<EditQuantityDialog> {
  TextEditingController quantityController=TextEditingController();

  @override
  void initState() {
    super.initState();
    quantityController.text=widget.ingredient['quantity'].toString();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider=Provider.of<ModelTheme>(context);
    bool isThemeDark=themeProvider.isDark;


    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 40.h,
        width: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: isThemeDark?Colors.grey.shade800:Colors.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(widget.ingredient['name'],style: GoogleFonts.aBeeZee(fontSize: 18.sp,
                fontWeight: FontWeight.bold),),
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 30.w,
                width: 30.w,
                child: Image.network(widget.ingredient['image']),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: MyEditText(
                        child: TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none
                      ),
                          onEditingComplete: (){
                            widget.onSelected(quantityController.text);
                            Navigator.pop(context,quantityController.text);
                          },
                    )),
                  ),
                  SizedBox(width: 5.w,),
                  Text(widget.ingredient['unit'],style: GoogleFonts.aBeeZee(fontSize: 14.sp),),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: LoadingButton(text: "OK",
                  click: (){
                    widget.onSelected(quantityController.text);
                    Navigator.pop(context,quantityController.text);
                  }),
            ),
            const Spacer(),
          ],
        ),
      ),
    );

}
}
