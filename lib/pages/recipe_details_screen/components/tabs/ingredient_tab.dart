import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../home/ui_componets/shimmar_effect.dart';

class IngredientsTab extends StatefulWidget {
  final Size size;
  final ScrollController childScrollController;
  const IngredientsTab({Key? key, required this.ingredients, required this.isThemeDark,
    required this.childScrollController, required this.size}) : super(key: key);
  final List<Map<dynamic, dynamic>> ingredients;
  final bool isThemeDark;
  @override
  State<IngredientsTab> createState() => _IngredientsTabState();
}

class _IngredientsTabState extends State<IngredientsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height*7/10,
      width: widget.size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text("Ingredients",style: GoogleFonts.aBeeZee(fontSize: 21,fontWeight: FontWeight.bold),),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: widget.childScrollController,
              child: Container(
                margin: EdgeInsets.zero,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of items in each row
                    childAspectRatio: 0.7, // Width to height ratio of each item
                  ),
                  itemCount: widget.ingredients.length,
                  itemBuilder: (context, index) {
                    return IngredientTabTile(
                      name: widget.ingredients[index]['name'],
                      quantity: widget.ingredients[index]['quantity'],
                      image: widget.ingredients[index]['image'],
                      isThemeDark: widget.isThemeDark,
                      unit: widget.ingredients[index]['unit'],
                      price: widget.ingredients[index]['price'],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IngredientTabTile extends StatelessWidget {
  const IngredientTabTile({
    Key? key,
    required this.name,
    required this.quantity,
    required this.image, required this.isThemeDark,
    required this.unit, required this.price,
  }) : super(key: key);
  final bool isThemeDark;
  final String name;
  final int quantity;
  final String image;
  final String unit;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
              spreadRadius: 2,
              blurRadius: 7,
              color: Colors.black26,
              offset:Offset(0,4)
          )
        ],
        color:isThemeDark?Colors.grey.shade700:Colors.grey.shade300,
      ),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 90,
            width: 90,
            child: Image.network(image,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return
                    ShimmerEffect(height: 90,
                      width: 90,isCircular: false,);
                }
              },)
          ),
          Text(name,style: GoogleFonts.aBeeZee(fontSize: 14,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
          Text("$quantity $unit",style: GoogleFonts.aBeeZee(fontSize: 12),overflow: TextOverflow.ellipsis,),
          Text("Rs. $price",style: GoogleFonts.aBeeZee(fontSize: 12),overflow: TextOverflow.ellipsis,),
        ],
      ),
    );
  }
}

