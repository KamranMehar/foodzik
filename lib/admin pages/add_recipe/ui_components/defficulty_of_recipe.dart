import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const/catefories_list.dart';

class DifficultyDropDownMenu extends StatefulWidget {
   const DifficultyDropDownMenu({Key? key,required this.isThemeDark,
  required this.onChanged}) : super(key: key);
 final  void Function(String? selectedValue)? onChanged;
 final bool isThemeDark;
  @override
  State<DifficultyDropDownMenu> createState() => _DifficultyDropDownMenuState();
}

class _DifficultyDropDownMenuState extends State<DifficultyDropDownMenu> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: Container(),
     icon: SizedBox(
         height: 25,
         width: 25,
         child: Image.asset("assets/chef_hat.png",color: widget.isThemeDark?Colors.white70:Colors.black54,)),
      value: _selectedOption,
      hint:  Text("Select Difficulty  ",overflow: TextOverflow.ellipsis,
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
      items: difficultyLevelList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
