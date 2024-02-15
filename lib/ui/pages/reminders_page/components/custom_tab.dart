import 'package:chance_app/ui/constans.dart';
import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({super.key, required this.isSelected, required this.onTap});

  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isSelected ? darkNeutral600 : null),
      ),
    ));
  }
}
