import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const/catefories_list.dart';

class CategoryDropDownMenu extends StatefulWidget {
  final void Function(String? selectedValue)? onChanged;
  bool isThemeDark;
   CategoryDropDownMenu({Key? key, this.onChanged,required this.isThemeDark}) : super(key: key);

  @override
  _CategoryDropDownMenuState createState() => _CategoryDropDownMenuState();
}

class _CategoryDropDownMenuState extends State<CategoryDropDownMenu> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: Container(),
      icon: Icon(Icons.fastfood_rounded,color: widget.isThemeDark?Colors.white70:Colors.black54,),
      value: _selectedOption,
      hint:  Text("Select Category",overflow: TextOverflow.ellipsis,
      style: GoogleFonts.aBeeZee(color: widget.isThemeDark?Colors.white70:Colors.black54,fontSize: 14),), // Set the hint text to "Select Category"
      onChanged: (String? newValue) {
        setState(() {
          _selectedOption = newValue!;
        });

        // Call the onChanged callback function with the selected value
        if (widget.onChanged != null) {
          widget.onChanged!(_selectedOption);
        }
      },
      items: categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(

          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
