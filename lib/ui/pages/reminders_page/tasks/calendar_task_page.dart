import 'dart:io';

import 'package:chance_app/ui/components/custom_time_picker.dart';
import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/calendar_for_tasks.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/custom_bottom_sheet_notification_picker.dart';
import 'package:chance_app/ux/bloc/registration_bloc/registration_bloc.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarTaskPage extends StatefulWidget {
  const CalendarTaskPage({super.key});

  @override
  State<CalendarTaskPage> createState() => _CalendarTaskPageState();
}

class _CalendarTaskPageState extends State<CalendarTaskPage> {
  @override
  void initState() {
    BlocProvider.of<RemindersBloc>(context).add(LoadDataForSelectDateForTasks());
    super.initState();
  }

  final int session = DateTime.now().millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<RemindersBloc, RemindersState>(
        builder: (context, state) {
      DateTime? deadlineForTask = state.newDeadlineForTask;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Коли потрібно зробити?",
            style: TextStyle(fontSize: 22, color: primaryText),
          ),
          leading: IconButton(
              onPressed: () {
                BlocProvider.of<RemindersBloc>(context)
                    .add(CancelAllDataNotificationBefore(session));
                Navigator.of(context).pop();
              },
              icon: Icon(Platform.isAndroid
                  ? Icons.arrow_back
                  : Icons.arrow_back_ios)),
          actions: [
            IconButton(
                onPressed: () {
                  BlocProvider.of<RemindersBloc>(context)
                      .add(SaveTasks(context: context));
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.done,
                  color: primaryText,
                )),
          ],
        ),
        backgroundColor: beigeBG,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CalendarForTasks(),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  color: darkNeutral600),
              child: Column(
                children: [
                  RoundedButton(
                      onPress: () async {
                        final dateTime = await CustomTimePicker.show(
                          context,
                          title: const Text("Термін виконання"),
                        );
                        if (dateTime != null && context.mounted) {
                          BlocProvider.of<RemindersBloc>(context)
                              .add(SaveDeadlineForTask(dateTime: dateTime));
                        }
                      },
                      tapColor: primary100,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 48,
                      border: Border.all(color: primary50),
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/clock.svg",
                            color: primary50,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Термін виконання",
                            style: TextStyle(fontSize: 16, color: primary50),
                          ),
                          const Spacer(),
                          Text(
                            deadlineForTask != null
                                ? "${deadlineForTask.hour.toString().padLeft(2, "0")}:${deadlineForTask.minute.toString().padLeft(2, "0")}"
                                : "немає",
                            style: TextStyle(fontSize: 16, color: primary50),
                          ),
                          Icon(Icons.arrow_forward_ios, color: primary50)
                        ],
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  RoundedButton(
                      onPress: () {
                        CustomBottomSheetNotificationPicker().show(context);
                      },
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 48,
                      border: Border.all(color: primary50),
                      color: Colors.transparent,
                      tapColor: primary100,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/notification.svg",
                            color: primary50,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Нагадування",
                            style: TextStyle(fontSize: 16, color: primary50),
                          ),
                          const Spacer(),
                          Text(
                            state.notifications[NotificationsBefore.values
                                .indexOf(state.newNotificationsBefore)],
                            style: TextStyle(fontSize: 16, color: primary50),
                          ),
                          Icon(Icons.arrow_forward_ios, color: primary50)
                        ],
                      )),
                  SizedBox(
                    height: size.height / 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
