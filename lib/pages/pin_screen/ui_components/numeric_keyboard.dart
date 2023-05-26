import 'package:flutter/material.dart';
import 'package:foodzik/pages/pin_screen/ui_components/pin_button.dart';

class NumericKeyboard extends StatelessWidget {
  final void Function(int?) onNumberPressed;

  NumericKeyboard({required this.onNumberPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumericKeyboardButton(
                number: "C",
                onNumberPressed: (_) {
                  print(_);
                },
              ),
              NumericKeyboardButton(
                number: "0",
                onNumberPressed: (_) {
                  print(_);
                },
              ),
              NumericKeyboardButton(
                number: "<",
                onNumberPressed: (_) {
                  print(_);
                },
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumericKeyboardButton(
                number: "1",
                onNumberPressed: (_) {
                  print(_);
                },
              ),
              NumericKeyboardButton(
                number: "2",
                onNumberPressed: (_) {
                  print(_);
                },
              ),
              NumericKeyboardButton(
                number: "3",
                onNumberPressed: (_) {
                  print(_);
                },
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumericKeyboardButton(
                number: "4",
                onNumberPressed: (_) {
                  print(_);
                },
              ),
              NumericKeyboardButton(
                number: "5",
                onNumberPressed: (_) {
                  print(_);
                },
              ),
              NumericKeyboardButton(
                number: "6",
                onNumberPressed: (_) {
                  print(_);
                },
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumericKeyboardButton(
                number: "7",
                onNumberPressed: (_) {
                  print(_);
                },
              ),
              NumericKeyboardButton(
                number: "8",
                onNumberPressed: (_) {
                  print(_);
                },
              ),
              NumericKeyboardButton(
                number: "9",
                onNumberPressed: (_) {
                  print(_);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
