import 'package:chance_app/ui/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum Reminders {
  medicine,
  tasks,
}

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 50),
        DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop(Reminders.tasks);
                },
                child: Container(
                  width: size.width / 2.5,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: darkNeutral600,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/tasks_small.svg",
                        color: primary50,
                      ),
                      Text(
                        "Завдання",
                        style: TextStyle(fontSize: 16, color: primary50),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop(Reminders.medicine);
                },
                child: Container(
                  width: size.width / 2.5,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: darkNeutral600,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/pills_small.svg",
                        color: primary50,
                      ),
                      Text(
                        "Медикамент",
                        style: TextStyle(fontSize: 16, color: primary50),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
