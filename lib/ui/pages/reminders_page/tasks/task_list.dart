import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:chance_app/ux/model/tasks_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemindersBloc, RemindersState>(
        builder: (context, state) {
      List<TaskModel> myTasks = List.from(state.myTasks);
      if(myTasks.isEmpty){
        return  const Text(
          "Додайте завдання",
          style: TextStyle(fontSize: 24),
        );
      }
      return Column(
              children: [
                SizedBox(
                  height: 44,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Сьогодні",
                          style: TextStyle(fontSize: 28, color: primaryText),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                "/tasks_for_today");
                            BlocProvider.of<RemindersBloc>(context).add(
                                LoadTasksForToday(
                                    datetime: DateTime(
                                        myTasks.first.date!.year,
                                        myTasks.first.date!.month,
                                        myTasks.first.date!.day)));
                          },
                          child: Text(
                            "Всі завдання",
                            style: TextStyle(
                                fontSize: 16,
                                color: primary700,
                                decorationColor: primary700,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: primary50,
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: myTasks.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, position) {
                          bool isSelected = myTasks[position].isDone;
                          TaskModel task = myTasks[position];
                          return GestureDetector(
                            onTap: () {
                              BlocProvider.of<RemindersBloc>(context)
                                  .add(SelectTask(position: position));
                            },
                            child: Container(
                              height: 56,
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/checkbox_${isSelected ? "checked" : "empty"}.svg",
                                    color:
                                        isSelected ? darkNeutral400 : primaryText,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(
                                    task.message,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: isSelected
                                            ? darkNeutral400
                                            : primaryText,
                                        decoration: isSelected
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none),
                                  ),),
                                  const Spacer(),
                                  Text(
                                    "${task.date!.hour.toString().padLeft(2, "0")}:${task.date!.minute.toString().padLeft(2, "0")}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isSelected
                                          ? darkNeutral400
                                          : primaryText,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/clock.svg",
                                    color:
                                        isSelected ? darkNeutral400 : primaryText,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            );
    });
  }
}
