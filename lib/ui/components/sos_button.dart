import 'package:chance_app/ui/constans.dart';
import 'package:flutter/material.dart';

class SosButton extends StatefulWidget {
  const SosButton({super.key});

  @override
  State<SosButton> createState() => _SosButtonState();
}

class _SosButtonState extends State<SosButton> {
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Ink(
      decoration: ShapeDecoration(
        color: red900,
        shape: CircleBorder(),
      ),
      child: InkWell(
        canRequestFocus: true,
        borderRadius: BorderRadius.circular(67),
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/sos',
            (route) => false,
          );
        },
        onHover: (_) {},
        splashColor: red1000,
        focusColor: red1000,
        highlightColor: red1000,
        hoverColor: red1000,
        child: Container(
          width: size.width / 4,
          height: size.width / 4,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(67)),
          child: Center(
            child: Text(
              "SOS",
              style: TextStyle(
                  color: primary50, fontSize: 22, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
