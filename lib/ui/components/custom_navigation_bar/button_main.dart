import 'package:chance_app/ui/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonMain extends StatelessWidget {
  const ButtonMain({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            "assets/icons/house_icon.svg",
            semanticsLabel: 'Acme Logo',
            color: primary200,
          ),
          Text(
            "Головна",
            style: TextStyle(fontSize: 16, color: primary200),
          )
        ],
      ),
    );
  }
}
