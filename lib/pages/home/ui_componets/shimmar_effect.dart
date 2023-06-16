import 'package:flutter/material.dart';
import 'package:foodzik/const/colors.dart';

class ShimmerEffect extends StatefulWidget {
  final double width;
  final double height;
  bool isCircular;
   ShimmerEffect({required this.width, required this.height,this.isCircular=true});

  @override
  _ShimmerEffectState createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final gradientColors = [
          greenTextColor.withOpacity(0.1),
          greenPrimary.withOpacity(0.7),
          greenTextColor.withOpacity(0.1),
        ];

        final begin = Alignment(-1.0 - _animationController.value * 3, 0.0);
        final end = Alignment(3.0 - _animationController.value * 3, 0.0);

        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            shape:widget.isCircular? BoxShape.circle:BoxShape.rectangle,
            gradient: LinearGradient(
              colors: gradientColors,
              begin: begin,
              end: end,
            ),
          ),
        );
      },
    );
  }
}
