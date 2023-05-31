import 'package:flutter/material.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/back_button.dart';
import 'package:foodzik/admin%20pages/add_recipe/ui_components/forground_img.dart';
import 'package:foodzik/theme/colors.dart';
import 'package:provider/provider.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
      leading: const BackLeadingBtn(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ForegroundRecipeImg(size: size),
          ],
        ),
      ),
    );
  }
}
