import 'package:flutter/cupertino.dart';
import 'package:foodzik/pages/pin_screen/ui_components/pin_button.dart';

class NumericKeyboard extends StatelessWidget {
  final void Function(String) onNumberPressed;

  NumericKeyboard({required this.onNumberPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumericKeyboardButton(
                number: "C",
                onNumberPressed: onNumberPressed,
              ),
              NumericKeyboardButton(
                number: "0",
                onNumberPressed: onNumberPressed,
              ),
              NumericKeyboardButton(
                number: "<",
                onNumberPressed: onNumberPressed,
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumericKeyboardButton(
                number: "1",
                onNumberPressed: onNumberPressed,
              ),
              NumericKeyboardButton(
                number: "2",
                onNumberPressed: onNumberPressed,
              ),
              NumericKeyboardButton(
                number: "3",
                onNumberPressed: onNumberPressed,
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumericKeyboardButton(
                number: "4",
                onNumberPressed: onNumberPressed,
              ),
              NumericKeyboardButton(
                number: "5",
                onNumberPressed: onNumberPressed,
              ),
              NumericKeyboardButton(
                number: "6",
                onNumberPressed: onNumberPressed,
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumericKeyboardButton(
                number: "7",
                onNumberPressed: onNumberPressed,
              ),
              NumericKeyboardButton(
                number: "8",
                onNumberPressed: onNumberPressed,
              ),
              NumericKeyboardButton(
                number: "9",
                onNumberPressed: onNumberPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
