import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      required this.color,
      required this.child,
      this.onPress,
      this.border});

  final Color color;
  final Widget child;
  final Function()? onPress;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: Container(
          height: 56,
          decoration: BoxDecoration(color: color,
              border: border, borderRadius: BorderRadius.circular(16)),
        child: Center(child: child,),));
  }
}
