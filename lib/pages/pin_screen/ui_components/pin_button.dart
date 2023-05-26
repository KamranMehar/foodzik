import 'package:flutter/material.dart';
import 'package:foodzik/theme/colors.dart';

class NumericKeyboardButton extends StatefulWidget {
  final String number;
  final void Function(String) onNumberPressed;
  NumericKeyboardButton({
    required this.number,
    required this.onNumberPressed,
  });

  @override
  _NumericKeyboardButtonState createState() => _NumericKeyboardButtonState();
}

class _NumericKeyboardButtonState extends State<NumericKeyboardButton> {
  bool _isPressed = false;

  void _handleTapDown(_) {
    setState(() {
      _isPressed = true;
    });
  }

  void _handleTapUp(_) {
    setState(() {
      _isPressed = false;
    });
    _handleNumberPressed(widget.number);
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  void _handleNumberPressed(String number) {
    if (widget.onNumberPressed != null) {
      widget.onNumberPressed(number);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isPressed ? Colors.grey.shade300 : greenPrimary,
        ),
        child: Center(
          child: Text(
            widget.number,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}
