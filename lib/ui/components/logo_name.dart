import 'package:flutter/material.dart';

class LogoName extends  StatelessWidget {
  const LogoName({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(children: [
      Image.asset("assets/logo.png"),
      const Text(
        "Chance app",
        style: TextStyle(
            fontSize: 38,
            fontFamily: "TiroBangla",
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            color: Color(0xffC18E3B)),
      ),
    ],);
  }
}
