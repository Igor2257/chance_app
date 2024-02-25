import 'package:chance_app/ui/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MedicineItem extends  StatelessWidget {
  const MedicineItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: 40,
            child: Text(
              "data",
              style: TextStyle(fontSize: 32, color: primaryText),
            )),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: primary100),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                      height: 12,
                      width: 12,
                      child: SvgPicture.asset(
                          "assets/icons/alarm_icon.svg")),
                  SizedBox(
                    height: 44,
                    width: 44,
                    child:
                    SvgPicture.asset("assets/icons/pills_big.svg"),
                  ),
                ],
              ),
              Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(left: BorderSide(color: beige400))),
                    child: Column(
                      children: [
                        Text(
                          "data",
                          style:
                          TextStyle(fontSize: 22, color: primaryText),
                        ),
                        Text(
                          "data",
                          style:
                          TextStyle(fontSize: 16, color: primaryText),
                        ),
                        Text(
                          "data",
                          style:
                          TextStyle(fontSize: 16, color: primaryText),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        )
      ],
    );
  }
}
