import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/custom_bottom_sheets/input_reminders_layout.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:chance_app/ux/model/tasks_model.dart';
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
              onTap: () {
                BlocProvider.of<RemindersBloc>(context).add(SaveTasks(context: context));
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
