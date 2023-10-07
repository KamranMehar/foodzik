import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:foodzik/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../const/colors.dart';
import '../../../provider classes/cart_provider.dart';
import '../../../provider classes/theme_model.dart';

class PersonDialog extends StatefulWidget {
  final Map recipeMap;
  final VoidCallback onClose;

  const PersonDialog({Key? key, required this.recipeMap, required this.onClose}) : super(key: key);

  @override
  State<PersonDialog> createState() => _PersonDialogState();
}

class _PersonDialogState extends State<PersonDialog> {
  late PersonDialogProvider personProvider;

  @override
  void initState() {
    super.initState();
    personProvider = Provider.of<PersonDialogProvider>(context, listen: false);
    Future.delayed(Duration.zero,(){
      personProvider.minPerson = widget.recipeMap["perPerson"];
      personProvider.price = (widget.recipeMap["price"] / widget.recipeMap["perPerson"]).toInt();
      personProvider.reset();
    });

  }

  @override
  Widget build(BuildContext context) {
    final modelTheme = Provider.of<ModelTheme>(context, listen: false);
    bool isThemeDark = modelTheme.isDark;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    Map recipe = widget.recipeMap;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Consumer<PersonDialogProvider>(
        builder: (context, personProvider, child) {
          return Container(
            width: 80.w,
            height: 40.h,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isThemeDark ? Colors.grey.shade800 : Colors.white,
            ),
            child: Column(
              children: [
                Text(
                  "Add Number of Persons",
                  style: GoogleFonts.abel(fontSize: 18.sp),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 30.w,
                          width: 30.w,
                          child: Image.network(widget.recipeMap["image"]),
                        ),
                        Icon(
                          CupertinoIcons.person_2,
                          size: 21.sp,
                        ),
                        Text(
                          "${personProvider.person}",
                          style: GoogleFonts.abel(fontSize: 25.sp),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        PersonDialogBtnPlus(
                          onTap: () {
                            if (personProvider.person >= 9) {
                              Utils.showToast("Make Special Order");
                            } else {
                              personProvider.addPerson();
                            }
                          },
                        ),
                        PersonDialogDec(
                          onTap: () {
                            personProvider.decreasePerson();
                          },
                        ),
                      ],
                    )
                  ],
                ),
                Text(
                  "RS: ${personProvider.totalPrice}",
                  style: GoogleFonts.abel(fontSize: 21.sp),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: LoadingButton(
                    spreadShadow: 2,
                    blurShadow: 10,
                    padding: 5,
                    fontSize: 15.sp,
                    text: "Add To Cart",
                    click: () {
                      Map cartRecipe = Map.from(recipe);
                      cartRecipe["perPerson"] = personProvider.person;
                      cartRecipe["price"] = personProvider.totalPrice;
                      cartProvider.addToCart(cartRecipe);
                      Utils.showToast("${widget.recipeMap["name"]} is Added To Cart");
                      Future.delayed(Duration.zero, () {
                        personProvider.reset();
                        Navigator.pop(context);
                        widget.onClose();
                      });
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class PersonDialogBtnPlus extends StatelessWidget {
  final VoidCallback onTap;

  const PersonDialogBtnPlus({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 3),
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Icon(
          CupertinoIcons.add,
          size: 25.sp,
          color: greenPrimary,
        ),
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
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Icon(
          CupertinoIcons.minus,
          size: 25.sp,
          color: greenPrimary,
        ),
      ),
    );
  }
}



class PersonDialogProvider with ChangeNotifier {
  int _minPerson = 0;
  int _person = 0;
  int _price = 0;
  int _totalPrice = 0;

  int get minPerson => _minPerson;

  int get person => _person;

  int get price => _price;

  int get totalPrice => _totalPrice;

  set minPerson(int value) {
    _minPerson = value;
    if (_person < _minPerson) {
      _person = _minPerson;
    }
    notifyListeners();
  }

  set person(int value) {
    _person = value;
    _totalPrice = _person * _price;
    notifyListeners();
  }

  set price(int value) {
    _price = value;
    _totalPrice = _person * _price;
    notifyListeners();
  }

  void reset() {
    _person = _minPerson;
    _totalPrice = _person * _price;
    notifyListeners();
  }

  void addPerson() {
    if (_person < 9) {
      _person++;
      _totalPrice = _person * _price;
      notifyListeners();
    } else {
      Utils.showToast("Make Special Order");
    }
  }

  void decreasePerson() {
    if (_person > _minPerson) {
      _person--;
      _totalPrice = _person * _price;
      notifyListeners();
    } else {
      Utils.showToast("Minimum Person Should be $_minPerson");
    }
  }
}

