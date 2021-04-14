import 'package:flutter/material.dart';

class CustomRing extends StatelessWidget {
  final double diameter;
  final double strokeWidth;
  final Color color;
  final Color backgroundColor;
  final double value;

  const CustomRing({
    Key key,
    @required this.diameter,
    @required this.strokeWidth,
    @required this.color,
    @required this.backgroundColor,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: diameter,
      width: diameter,
      child: CircularProgressIndicator(
        value: value,
        backgroundColor: backgroundColor,
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation(color),
      ),
    );
  }
}
