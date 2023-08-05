import 'package:flutter/material.dart';
import 'package:foodzik/my_widgets/my_button.dart';
import 'package:foodzik/tab_pages/cart_tab/components/sub_tabs/cart_sub_tab.dart';
import 'package:foodzik/tab_pages/cart_tab/components/sub_tabs/special_cart_sub_tab.dart';



class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
     body: Column(
       children: [
         Padding(
           padding: const EdgeInsets.symmetric(vertical: 10),
           child: Row(
             children: [
               const Spacer(),
               LoadingButton(
                   text: "  Cart  ",
                   click: (){
                 pageController.jumpToPage(0);
                   },
                 blurShadow: 30,
                 spreadShadow: 0.0,
                 shadowColor: Colors.transparent,
                   ),
               const Spacer(),
               LoadingButton(
                   text: " Special Cart ",
                   click: (){
                     pageController.jumpToPage(1);
                   },
                 blurShadow: 30,
                 spreadShadow: 0.0,
                 shadowColor: Colors.transparent,
                   ),
               const Spacer(),
             ],
           ),
         ),
         Expanded(
           child: PageView(
             controller: pageController,
             children: const [
               CartSubTab(),
               SpecialCartSubTab()
             ],
           ),
         ),
       ],
     ),
    );
  }
  @override
  void dispose() {
    pageController.dispose(); // Dispose of the PageController
    super.dispose();
  }
}

