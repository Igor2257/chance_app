import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/custom_bottom_sheets/input_reminders_layout.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:chance_app/ux/model/tasks_model.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstTaskPage extends StatefulWidget {
  const FirstTaskPage({super.key});

  @override
  State<FirstTaskPage> createState() => _FirstTaskPageState();
}

class _FirstTaskPageState extends State<FirstTaskPage> {
  final TextEditingController nameTextEditingController =
      TextEditingController();

  @override
  void initState() {
    BlocProvider.of<RemindersBloc>(context)
        .add(LoadDataForSelectDateForTasks());
    super.initState();
  }
  @override
  void dispose() {
    nameTextEditingController.dispose();
    super.dispose();
  }
  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemindersBloc, RemindersState>(
        builder: (context, state) {
      TaskModel? taskModel = state.taskModel;

      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputRemindersLayout(
            textEditingController: nameTextEditingController,
            title: 'Введіть завдання',
            subTitle: '',
            saveData: (String value) {
              BlocProvider.of<RemindersBloc>(context)
                  .add(SaveTaskName(name: value));
            },
            clearData: () {
              BlocProvider.of<RemindersBloc>(context)
                  .add(SaveTaskName(name: ""));
            },
          ),
          if (state.taskTitle.trim().isNotEmpty)
            GestureDetector(
              onTap: () async {
                if (state.taskTitle.trimLeft().length > 1) {
                  if (state.taskTitle.trimLeft().length <= 300) {

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
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        message: name,
                        date: date,
                        //notificationsBefore: state.oldNotificationsBefore.name,
                      );
                      BlocProvider.of<RemindersBloc>(context).add(SaveTask(taskModel: taskModel));
                      await Repository().saveTask(taskModel).then((value) {
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
                                                fontSize: 24,
                                                color: primaryText),
                                          ),
                                          Text(
                                            "”${taskModel.message}”",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: primaryText),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: SizedBox(
                                          height: 44,
                                          child: Text(
                                            "OK",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: primary500),
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
                  }
                }
              },
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: darkNeutral600))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.taskTitle,
                      style: TextStyle(fontSize: 16, color: primaryText),
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
          const SizedBox(
            height: 100,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                  "/date_picker_for_tasks");
            },
            child: Container(
              height: 40,
              constraints: const BoxConstraints(minWidth: 120),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                  color: primary100, borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/icons/calendar.svg"),
                  Text(
                    (taskModel == null) ||
                            (taskModel.date == null) ||
                            (taskModel.date != null &&
                                taskModel.date!.day == now.day &&
                                taskModel.date!.month == now.month &&
                                taskModel.date!.year == now.year)
                        ? "Сьогодні"
                        : "${taskModel.date!.day.toString().padLeft(2, "0")}.${taskModel.date!.month.toString().padLeft(2, "0")}.${taskModel.date!.year}",
                    style: TextStyle(fontSize: 14, color: primaryText),
                  ),
                    ],
                  ),
                ),
              ),
            ],
          );
    });
  }
}
