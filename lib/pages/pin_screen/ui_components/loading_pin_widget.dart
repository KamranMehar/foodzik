import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  final bool reverse;

  const LoadingWidget({Key? key, this.reverse = false}) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    final begin = widget.reverse ? 1.0 : 0.5;
    final end = widget.reverse ? 0.5 : 1.0;

    _animation = Tween<double>(
      begin: begin,
      end: end,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            width: 50.0,
            height: 50.0,
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              color: theme.brightness==Brightness.light?Colors.black:
              Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class LoadingPinRow extends StatelessWidget {
  const LoadingPinRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingWidget(reverse: false,),
        LoadingWidget(reverse: true,),
        LoadingWidget(reverse: false,),
        LoadingWidget(reverse: true,),
      ],
    );
  }
}