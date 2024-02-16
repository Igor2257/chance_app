import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      required this.color,
      required this.child,
      this.onPress,
      this.border,
      this.height,
      this.padding,
      this.tapColor, this.margin});

  final Color color;
  final Widget child;
  final Function()? onPress;
  final BoxBorder? border;
  final double? height;
  final EdgeInsets? padding,margin;
  final Color? tapColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin??EdgeInsets.zero,
      child: InkWell(
          onTap: onPress,
          onHover: (v){

          },
          splashColor: tapColor ?? Colors.transparent,
          focusColor: tapColor ?? Colors.transparent,
          highlightColor: tapColor ?? Colors.transparent,
          hoverColor: tapColor ?? Colors.transparent,
          child: Container(
            padding: padding,
            height: height ?? 56,
            decoration: BoxDecoration(
                color: color,
                border: border,
                borderRadius: BorderRadius.circular(16)),
            child: Center(
              child: child,
            ),
          )),
    );
  }
}
