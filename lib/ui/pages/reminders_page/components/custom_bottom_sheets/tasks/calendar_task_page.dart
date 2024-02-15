import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/custom_bottom_sheets/tasks/calendar_for_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarTaskPage extends StatelessWidget {
  const CalendarTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Нагадування",
          style: TextStyle(fontSize: 22, color: primaryText),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/icons/dots_vertical.svg")),
        ],
      ),
      backgroundColor: beigeBG,
      body: Column(
        children: [
          const CalendarForTasks(),
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                color: darkNeutral600),
            child: Column(
              children: [
                RoundedButton(color: Colors.transparent, child: Row(children: [
                  Icon(Icons.watch)
                ],)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
