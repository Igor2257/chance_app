import 'dart:io';

import 'package:chance_app/ui/components/custom_time_picker.dart';
import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/calendar_for_tasks.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/custom_bottom_sheet_notification_picker.dart';
import 'package:chance_app/ux/bloc/add_task_bloc/add_task_bloc.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';

import 'package:chance_app/ux/model/task_model.dart';
import 'package:chance_app/ux/repository/tasks_repository.dart';
import 'package:chance_app/ux/repository/user_repository.dart';
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
    BlocProvider.of<AddTaskBloc>(context).add(LoadDataForSelectDateForTasks());
    super.initState();
  }

  final int session = DateTime.now().millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<AddTaskBloc, AddTaskState>(
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
                BlocProvider.of<AddTaskBloc>(context)
                    .add(CancelAllDataNotificationBefore(session));
                Navigator.of(context).pop();
              },
              icon: Icon(Platform.isAndroid
                  ? Icons.arrow_back
                  : Icons.arrow_back_ios)),
          actions: [
            IconButton(
                onPressed: ()async {
                  DateTime now = DateTime.now();
                  String name = state.taskTitle;
                  if (name.trim().isNotEmpty) {
                    DateTime date = state.newSelectedDateForTasks!;
                    if (state.newDeadlineForTask != null) {
                      date = DateTime(
                          state.newSelectedDateForTasks!.year,
                          state.newSelectedDateForTasks!.month,
                          state.newSelectedDateForTasks!.day,
                          state.newDeadlineForTask!.hour,
                          state.newDeadlineForTask!.minute);
                    } else {
                      date = DateTime(
                          state.newSelectedDateForTasks!.year,
                          state.newSelectedDateForTasks!.month,
                          state.newSelectedDateForTasks!.day,
                          now.hour,
                          now.minute);
                    }

                    TaskModel taskModel = TaskModel(
                      message: name,
                      date: date,
                      //notificationsBefore: state.oldNotificationsBefore.name,
                    );

                    BlocProvider.of<RemindersBloc>(context)
                        .add(SaveTask(taskModel: taskModel));
                    await TasksRepository().saveTask(taskModel).then((value) {

                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return SizedBox(
                                height: 160,
                                width: MediaQuery.of(context).size.width,
                                child: AlertDialog(
                                  backgroundColor: beigeBG,
                                  content: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Icon(Icons.done),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        Text(
                                          "Завдання додано",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 24, color: primaryText),
                                        ),
                                        Text(
                                          "”${taskModel.message}”",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16, color: primaryText),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop(true);
                                        BlocProvider.of<RemindersBloc>(context)
                                            .add(LoadData());

                                      },
                                      child: SizedBox(
                                        height: 44,
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                              fontSize: 20, color: primary500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                          }).whenComplete(() {
                        Navigator.of(context).pop();
                      });
                    });
                  }
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
                          BlocProvider.of<AddTaskBloc>(context)
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
                            style: TextStyle(
                                fontSize: 16,
                                color: primary50,
                                fontWeight: FontWeight.w500),
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
                        const CustomBottomSheetNotificationPicker().show(context);
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
                            style: TextStyle(
                                fontSize: 16,
                                color: primary50,
                                fontWeight: FontWeight.w500),
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
