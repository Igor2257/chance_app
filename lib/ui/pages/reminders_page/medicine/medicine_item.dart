import 'package:chance_app/ui/components/separated_list.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/model/medicine_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MedicineItem extends StatelessWidget {
  const MedicineItem(
    this.medicine, {
    required this.time,
    this.onTap,
    super.key,
  });

  final MedicineModel medicine;
  final TimeOfDay time;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: primary100,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: IntrinsicHeight(
            child: Row(
              children: [
                SizedBox(
                  width: 46,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: SvgPicture.asset(
                          medicine.type.svgIcon,
                          color: beige500,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconTheme(
                          data: const IconThemeData(size: 21),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(Icons.circle, color: primary400),
                              Transform.scale(
                                scale: 0.75,
                                child: const Icon(
                                  Icons.alarm,
                                  color: Colors.white,
                                ),
                              ),
                              // Icon(Icons.check_circle, color: green),
                              // Icon(Icons.error, color: red900),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(width: 1),
                const SizedBox(width: 8),
                Expanded(
                  child: SeparatedList(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    separator: const SizedBox(height: 2),
                    children: [
                      Text(
                        medicine.name,
                        style: TextStyle(fontSize: 22, color: primaryText),
                      ),
                      Text(
                        "data",
                        style: TextStyle(fontSize: 16, color: primaryText),
                      ),
                      Text(
                        "data",
                        style: TextStyle(fontSize: 16, color: primaryText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
