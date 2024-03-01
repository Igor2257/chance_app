import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:chance_app/ux/model/tasks_model.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TasksForToday extends StatefulWidget {
  const TasksForToday({super.key});

  @override
  State<TasksForToday> createState() => _TasksForTodayState();
}

class _TasksForTodayState extends State<TasksForToday> {
  PageController pageController = PageController(viewportFraction: 0.9);

  @override
  void initState() {
    super.initState();
  }

  Future delay(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      Navigator.of(context).pop();
    });
  }
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<RemindersBloc, RemindersState>(
        builder: (context, state) {
      List<TaskModel> tasksForToday = List.from(state.myTasks);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Завдання на сьогодні",
            style: TextStyle(fontSize: 22, color: primaryText),
          ),
          leading: CloseButton(
            onPressed: () {
              //BlocProvider.of<RemindersBloc>(context).add(LoadData());
              Navigator.of(context).pop();
            },
          ),
          actions: [
            if (kDebugMode)
              IconButton(
                  onPressed: () async {
                    await Repository().deleteAllTasks();
                  },
                  icon: const Icon(Icons.delete)),
          ],
        ),
        backgroundColor: beigeBG,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Не забутьте відмітити завдання як виконане",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: primaryText,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: tasksForToday.length,
                      itemBuilder: (context, i) {
                        TaskModel task = tasksForToday[i];
                        return Stack(children: [
                          Container(
                            width: size.width,
                            height: size.height,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: primary100,
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  task.message,
                                  style: TextStyle(
                                      fontSize: 24, color: primaryText),
                                ),
                                const Spacer(),
                                task.isDone
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/alarm_icon.svg"),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Виконано",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: primaryText),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/clock.svg"),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${task.date!.hour.toString().padLeft(2, "0")}:${task.date!.minute.toString().padLeft(2, "0")}",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: primaryText),
                                          ),
                                        ],
                                      ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: darkNeutral800),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<RemindersBloc>(
                                                  context)
                                              .add(ChangeIsDoneForTask(
                                                  id: task.id));
                                          if (!task.isDone) {
                                            delay(context);
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return SizedBox(
                                                    height: 160,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: AlertDialog(
                                                      backgroundColor: beige100,
                                                      content: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 24,
                                                                vertical: 16),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            const Icon(
                                                                Icons.done),
                                                            const SizedBox(
                                                              height: 40,
                                                            ),
                                                            Text(
                                                              "Завдання виконано",textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                  fontSize: 24,
                                                                  color:
                                                                      primaryText),
                                                            ),
                                                            Text(
                                                              "”${task.message}”",textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color:
                                                                      primaryText),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          }
                                        },
                                        child: Container(
                                          height: 56,
                                          width: 56,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(90),
                                              color: primary300),
                                          child: Center(
                                            child: Icon(task.isDone
                                                ? Icons.close
                                                : Icons.done),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        task.isDone
                                            ? "Не виконано"
                                            : "Виконано",
                                        style: TextStyle(
                                            fontSize: 16, color: primary50),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return SizedBox(
                                                    height: 160,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: AlertDialog(
                                                        backgroundColor:
                                                            beige100,
                                                        content: Padding(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  "Ви впевнені, що хочете видалити завдання?",textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                      color:
                                                                          primaryText,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          "Скасувати",textAlign: TextAlign.center,
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: primary700,
                                                                              decoration: TextDecoration.underline,
                                                                              decorationColor: primary700),
                                                                        )),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () async{
                                                                          BlocProvider.of<RemindersBloc>(context).add(DeleteTask(
                                                                              id: task.id,
                                                                             ));
                                                                          Future.delayed(const Duration(seconds: 1)).then((value) async {
                                                                            Navigator.of(context).pop();
                                                                          });
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
                                                                                            "Завдання видалено",
                                                                                            textAlign: TextAlign.center,
                                                                                            style: TextStyle(fontSize: 24, color: primaryText),
                                                                                          ),
                                                                                          Text(
                                                                                            "”${task.message}”",
                                                                                            textAlign: TextAlign.center,
                                                                                            style: TextStyle(fontSize: 16, color: primaryText),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }).whenComplete(() => Navigator.of(context).pop());
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          "Видалити",textAlign: TextAlign.center,
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: primary700,
                                                                              decoration: TextDecoration.underline,
                                                                              decorationColor: primary700),
                                                                        )),
                                                                  ],
                                                                )
                                                              ],
                                                            ))));
                                              });
                                        },
                                        child: Container(
                                          height: 56,
                                          width: 56,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(90),
                                              border: Border.all(
                                                  color: primary300)),
                                          child: Center(
                                            child: Icon(
                                                Icons.delete_outline_rounded,
                                                color: primary50),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Видалити",
                                        style: TextStyle(
                                            fontSize: 16, color: primary50),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]);
                      })),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      );
    });
  }
}
