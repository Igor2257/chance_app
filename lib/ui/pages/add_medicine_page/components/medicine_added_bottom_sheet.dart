import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/model/medicine_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MedicineAddedBottomSheet extends StatelessWidget {
  const MedicineAddedBottomSheet(
    this.medicine, {
    super.key,
  });

  final MedicineModel medicine;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              medicine.type.svgIcon,
              height: 64,
              color: beige500,
            ),
            const SizedBox(height: 8),
            Text(
              '${medicine.name} додано',
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            RoundedButton(
              onPress: () => Navigator.of(context).pop(true),
              color: primary1000,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Додати інший препарат",
                    style: TextStyle(color: primary50, fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.add, color: primary50),
                ],
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Ні, все додано"),
            ),
          ],
        ),
      ),
    );
  }
}