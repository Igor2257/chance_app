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
    BlocProvider.of<RemindersBloc>(context).add(LoadDataForSelectDateForTasks());
    super.initState();
  }

  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemindersBloc, RemindersState>(
        builder: (context, state) {
      TaskModel? taskModel = state.taskModel;
      print(taskModel);
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputRemindersLayout(
            textEditingController: nameTextEditingController,
            title: '',
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
                Container(
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
              const SizedBox(
                height: 100,
              ),
              InkWell(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/date_picker_for_tasks", (route) => true);
            },
            child: Container(
              height: 40,
              width: 120,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                  color: primary100, borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset("assets/icons/calendar.svg"),
                      Text(
                    (taskModel == null) ||
                            (taskModel.taskTo == null) ||
                            (taskModel.taskTo != null &&
                                taskModel.taskTo!.day == now.day &&
                                taskModel.taskTo!.month == now.month &&
                                taskModel.taskTo!.year == now.year)
                        ? "Сьогодні"
                        : "${taskModel.taskTo!.day.toString().padLeft(2, "0")}.${taskModel.taskTo!.month.toString().padLeft(2, "0")}.${taskModel.taskTo!.year}",
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
