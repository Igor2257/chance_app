import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/calendar.dart';
import 'package:chance_app/ui/pages/reminders_page/reminders_page.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/custom_bottom_sheet_notificatenion_picker.dart';
import 'package:chance_app/ux/model/tasks_model.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/material.dart';

part 'reminders_event.dart';
part 'reminders_state.dart';

class RemindersBloc extends Bloc<RemindersEvent, RemindersState> {
  RemindersBloc() : super(RemindersState()) {
    on<ChangeReminders>(_onChangeReminders);
    on<LoadData>(_onLoadData);
    on<SelectedDate>(_onSelectedDate);
    on<ChangeCalendarState>(_onChangeCalendarState);
    on<ChangeMonth>(_onChangeMonth);
    on<SelectWhatPersonWouldLikeToAdd>(_onSelectWhatPersonWouldLikeToAdd);
    on<SaveTaskName>(_onSaveTaskName);
    on<ChangeMonthForTasks>(_onChangeMonthForTasks);
    on<SelectedDateForTasks>(_onSelectedDateForTasks);
    on<SaveDeadlineForTask>(_onSaveDeadlineForTask);
    on<SelectNotificationBefore>(_onSelectNotificationBefore);
    on<CancelNotificationBefore>(_onCancelNotificationBefore);
    on<CancelAllDataNotificationBefore>(_onCancelAllDataNotificationBefore);
    on<LoadDataForSelectDateForTasks>(_onLoadDataForSelectDateForTasks);
    on<SaveTasks>(_onSaveTasks);
    on<SelectTask>(_onSelectTask);
    on<LoadTasksForToday>(_onLoadTasksForToday);
    on<ChangeIsDoneForTask>(_onChangeIsDoneForTask);
    on<DeleteTask>(_onDeleteTask);
  }

  FutureOr<void> _onChangeReminders(
      ChangeReminders event, Emitter<RemindersState> emit) {
    emit(state.copyWith(reminders: event.reminders));
  }

  bool checkIfDayHasTask(
      List<TaskModel> myTasks, int day, int month, int year) {
    for (int i = 0; i < myTasks.length; i++) {
      DateTime taskDate = myTasks[i].date!;
      print(taskDate);
      print(day);
      print(month);
      print(year);
      print("---------");
      if (taskDate.day == day &&
          taskDate.month == month &&
          taskDate.year == year) {
        return true;
      }
    }
    return false;
  }

  FutureOr<void> _onLoadData(
      LoadData event, Emitter<RemindersState> emit) async {
    List<Map<String, dynamic>> dates = [], week = [];
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;
    int day = now.day;
    int daysInMonth = DateTime(year, month + 1, 0).day;
    List<TaskModel>? myTasks = List.from(Repository().myTasks);

    print(myTasks.map((e) => e.date));
    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(year, month, i);
      String weekDay = getWeekdayName(date.weekday);
      dates.add({
        "weekDay": weekDay,
        "number": (i.toString()).padLeft(2, "0"),
        "month": month,
        "year": year,
        "isSelected": day == i ||
            (state.selectedDate != null &&
                (state.selectedDate!.day == i &&
                    state.selectedDate!.month == month &&
                    state.selectedDate!.year == year)),
        "hasTasks": checkIfDayHasTask(myTasks, i, month, year),
      });
    }
    myTasks = myTasks
        .where((element) =>
            element.date!.day == now.day &&
            element.date!.month == now.month &&
            element.date!.year == now.year)
        .toList();
    myTasks.sort((a, b) => a.date!.compareTo(b.date!));
    int startOfWeek = day - now.weekday;
    int endOfWeek = startOfWeek + 6;
    week = dates.getRange(startOfWeek, endOfWeek).toList();

    emit(state.copyWith(
      days: dates,
      week: week,
      selectedDate: DateTime.now(),
      dateForSwiping: DateTime.now(),
      myTasks: myTasks,
    ));
  }

  FutureOr<void> _onSelectedDate(
      SelectedDate event, Emitter<RemindersState> emit) {
    List<Map<String, dynamic>> dates = state.days, week = state.week;
    Map<String, dynamic> date = event.selectedDate;
    date["isSelected"] = true;

    int index = dates.indexWhere((e) => e["number"] == date["number"]);
    for (int i = 0; i < dates.length; i++) {
      dates[i]["isSelected"] = false;
    }
    dates[index]["isSelected"] = true;

    int index2 = week.indexWhere((e) => e["number"] == date["number"]);
    for (int i = 0; i < week.length; i++) {
      week[i]["isSelected"] = false;
    }
    if (index2 != -1) {
      week[index2]["isSelected"] = true;
    }
    DateTime selectedDate = DateTime(dates[index]["year"],
        dates[index]["month"], int.parse(dates[index]["number"]));
    List<TaskModel>? myTasks = List.from(Repository().myTasks);
    myTasks = myTasks
        .where((element) =>
            element.date!.day == selectedDate.day &&
            element.date!.month == selectedDate.month &&
            element.date!.year == selectedDate.year)
        .toList();
    myTasks.sort((a, b) => a.date!.compareTo(b.date!));
    emit(state.copyWith(
        myTasks: myTasks, week: week, days: dates, selectedDate: selectedDate));
  }

  FutureOr<void> _onChangeCalendarState(
      ChangeCalendarState event, Emitter<RemindersState> emit) {
    emit(state.copyWith(isCalendarOpened: !state.isCalendarOpened));
  }

  FutureOr<void> _onChangeMonth(
      ChangeMonth event, Emitter<RemindersState> emit) {
    List<Map<String, dynamic>> dates = [], week = [];
    DateTime now = state.dateForSwiping ?? DateTime.now();
    int plusOrMinus = event.sideSwipe == SideSwipe.left ? -1 : 1;
    int year = now.year;
    int month = now.month;
    if (month + plusOrMinus <= 12 && month + plusOrMinus >= 0) {
      month = now.month + plusOrMinus;
    } else {
      if (event.sideSwipe == SideSwipe.left) {
        year = now.year - 1;
        month = 12;
      } else {
        year = now.year + 1;
        month = 1;
      }
    }

    int daysInMonth = DateTime(year, month + 1, 0).day;
    DateTime? selectedDate = state.selectedDate;
    List<TaskModel>? myTasks = List.from(Repository().myTasks);

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(year, month, i);
      String weekDay = getWeekdayName(date.weekday);
      dates.add({
        "weekDay": weekDay,
        "number": (i.toString()).padLeft(2, "0"),
        "month": month,
        "year": year,
        "isSelected": (selectedDate != null &&
            (selectedDate.day == i &&
                selectedDate.month == month &&
                selectedDate.year == year)),
        "hasTasks": checkIfDayHasTask(myTasks, i, month, year)
      });
    }

    int startOfWeek =
        (month == DateTime.now().month && year == DateTime.now().year)
            ? DateTime.now().day - DateTime.now().weekday + 1
            : 1;
    int endOfWeek = startOfWeek + 6;
    for (int i = startOfWeek; i <= endOfWeek; i++) {
      if (i <= 0 || i > DateTime(year, month + 1, 0).day) {
        continue;
      }
      DateTime date = DateTime(year, month, i);
      String weekDay = getWeekdayName(date.weekday);
      week.add({
        "weekDay": weekDay,
        "number": (i.toString()).padLeft(2, "0"),
        "month": month,
        "year": year,
        "isSelected": (selectedDate != null &&
            (selectedDate.day == i &&
                selectedDate.month == month &&
                selectedDate.year == year)),
        "hasTasks": checkIfDayHasTask(myTasks, i, month, year)
      });
    }
    myTasks = myTasks
        .where((element) =>
            element.date!.day == now.day &&
            element.date!.month == now.month &&
            element.date!.year == now.year)
        .toList();
    myTasks.sort((a, b) => a.date!.compareTo(b.date!));
    emit(state.copyWith(
        days: dates, week: week, dateForSwiping: DateTime(year, month)));
  }

  FutureOr<void> _onSelectWhatPersonWouldLikeToAdd(
      SelectWhatPersonWouldLikeToAdd event, Emitter<RemindersState> emit) {
    emit(state.copyWith(reminders: event.reminders));
  }

  FutureOr<void> _onSaveTaskName(
      SaveTaskName event, Emitter<RemindersState> emit) {
    emit(state.copyWith(taskTitle: event.name));
  }

  FutureOr<void> _onChangeMonthForTasks(
      ChangeMonthForTasks event, Emitter<RemindersState> emit) {
    List<Map<String, dynamic>> dates = [];
    DateTime now = state.dateForSwiping ?? DateTime.now();
    int plusOrMinus = event.sideSwipe == SideSwipe.left ? -1 : 1;
    int year = now.year;
    int month = now.month;
    if (month + plusOrMinus <= 12 && month + plusOrMinus >= 0) {
      month = now.month + plusOrMinus;
    } else {
      if (event.sideSwipe == SideSwipe.left) {
        year = now.year - 1;
        month = 12;
      } else {
        year = now.year + 1;
        month = 1;
      }
    }

    int daysInMonth = DateTime(year, month + 1, 0).day;
    DateTime? selectedDate = state.selectedDate;
    List<TaskModel>? myTasks = List.from(Repository().myTasks);

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(year, month, i);
      String weekDay = getWeekdayName(date.weekday);
      dates.add({
        "weekDay": weekDay,
        "number": (i.toString()).padLeft(2, "0"),
        "month": month,
        "year": year,
        "isSelected": (selectedDate != null &&
            (selectedDate.day == i &&
                selectedDate.month == month &&
                selectedDate.year == year)),
        "hasTasks": checkIfDayHasTask(myTasks, i, month, year)
      });
    }
    myTasks = myTasks
        .where((element) =>
            element.date!.day == now.day &&
            element.date!.month == now.month &&
            element.date!.year == now.year)
        .toList();
    myTasks.sort((a, b) => a.date!.compareTo(b.date!));
    emit(state.copyWith(
        daysForTasks: dates, dateForSwipingForTasks: DateTime(year, month)));
  }

  FutureOr<void> _onSelectedDateForTasks(
      SelectedDateForTasks event, Emitter<RemindersState> emit) {
    List<Map<String, dynamic>> dates = state.daysForTasks;
    Map<String, dynamic> date = event.selectedDate;
    int index = dates.indexWhere((e) => e["number"] == date["number"]);
    for (int i = 0; i < dates.length; i++) {
      dates[i]["isSelected"] = false;
    }
    dates[index]["isSelected"] = true;
    emit(state.copyWith(
        daysForTasks: dates,
        oldSelectedDateForTasks: state.newSelectedDateForTasks,
        newSelectedDateForTasks: DateTime(dates[index]["year"],
            dates[index]["month"], int.parse(dates[index]["number"]))));
  }

  FutureOr<void> _onSaveDeadlineForTask(
      SaveDeadlineForTask event, Emitter<RemindersState> emit) {
    emit(state.copyWith(
        oldDeadlineForTask: state.newDeadlineForTask,
        newDeadlineForTask: event.dateTime));
  }

  FutureOr<void> _onSelectNotificationBefore(
      SelectNotificationBefore event, Emitter<RemindersState> emit) {
    emit(state.copyWith(
        oldNotificationsBefore: state.newNotificationsBefore,
        newNotificationsBefore: event.notificationsBefore,
        sessionForNotification: event.session));
  }

  FutureOr<void> _onCancelNotificationBefore(
      CancelNotificationBefore event, Emitter<RemindersState> emit) {
    if (event.session == state.sessionForNotification) {
      emit(
          state.copyWith(newNotificationsBefore: state.oldNotificationsBefore));
    }
  }

  FutureOr<void> _onCancelAllDataNotificationBefore(
      CancelAllDataNotificationBefore event, Emitter<RemindersState> emit) {
    if (event.session == state.sessionForSelectingDateForTask) {
      emit(state.copyWith(
          newNotificationsBefore: state.fromLastSession,
          newDeadlineForTask: 0,
          newSelectedDateForTasks: state.oldSelectedDateForTasks));
    }
  }

  FutureOr<void> _onLoadDataForSelectDateForTasks(
      LoadDataForSelectDateForTasks event, Emitter<RemindersState> emit) {
    List<Map<String, dynamic>> dates = [];
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;
    int day = now.day;
    int daysInMonth = DateTime(year, month + 1, 0).day;
    List<TaskModel>? myTasks = List.from(Repository().myTasks);

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(year, month, i);
      String weekDay = getWeekdayName(date.weekday);
      dates.add({
        "weekDay": weekDay,
        "number": (i.toString()).padLeft(2, "0"),
        "month": month,
        "year": year,
        "isSelected": day == i ||
            (state.selectedDate != null &&
                (state.selectedDate!.day == i &&
                    state.selectedDate!.month == month &&
                    state.selectedDate!.year == year)),
        "hasTasks": checkIfDayHasTask(myTasks, i, month, year)
      });
    }
    myTasks = myTasks
        .where((element) =>
            element.date!.day == now.day &&
            element.date!.month == now.month &&
            element.date!.year == now.year)
        .toList();
    myTasks.sort((a, b) => a.date!.compareTo(b.date!));
    emit(state.copyWith(
      daysForTasks: dates,
      selectedDate: DateTime.now(),
      newSelectedDateForTasks: DateTime.now(),
      dateForSwiping: DateTime.now(),
    ));
  }

  Future delay(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/reminders", (route) => false);
    });
  }

  FutureOr<void> _onSaveTasks(SaveTasks event, Emitter<RemindersState> emit)async {
    DateTime now = DateTime.now();
    String name = state.taskTitle;
    if (name.trim().isNotEmpty) {
      TaskModel taskModel = TaskModel(
        message: name,
        date: state.newSelectedDateForTasks,
        //notificationsBefore: state.oldNotificationsBefore.name,
      );
      List<TaskModel>? myTasks = List.from(Repository().myTasks);
      myTasks = myTasks
          .where((element) =>
              element.date!.day == now.day &&
              element.date!.month == now.month &&
              element.date!.year == now.year)
          .toList();
      myTasks.add(taskModel);
      myTasks.sort((a, b) => a.date!.compareTo(b.date!));

      emit(state.copyWith(
        taskModel: taskModel,
        myTasks: myTasks,
      ));
      await Repository().saveTask(taskModel).then((value) {
        showDialog(
            barrierDismissible: false,
            context: event.context,
            builder: (context) {
              return SizedBox(
                height: 160,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                    future: delay(context),
                    builder: (context, snapshot) {
                      return AlertDialog(
                        backgroundColor: beige100,
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
                                style:
                                TextStyle(fontSize: 24, color: primaryText),
                              ),
                              Text(
                                "”${state.taskModel!.message}”",
                                style:
                                    TextStyle(fontSize: 16, color: primaryText),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              );
            });
      });
    }
  }

  FutureOr<void> _onSelectTask(
      SelectTask event, Emitter<RemindersState> emit) async {
    List<TaskModel> myTasks = List.from(state.myTasks);
    myTasks[event.position] = myTasks[event.position]
        .copyWith(isDone: !myTasks[event.position].isDone);
    await Repository().updateTask(myTasks[event.position]).then((value) {
      emit(state.copyWith(myTasks: myTasks));
    });
  }

  FutureOr<void> _onLoadTasksForToday(
      LoadTasksForToday event, Emitter<RemindersState> emit) async {
    DateTime now = event.datetime;
    List<TaskModel> myTasks = List.from(Repository()
        .myTasks
        .where((element) =>
            element.date!.day == now.day &&
            element.date!.month == now.month &&
            element.date!.year == now.year)
        .toList());
    emit(state.copyWith(tasksForToday: myTasks));
  }

  FutureOr<void> _onChangeIsDoneForTask(
      ChangeIsDoneForTask event, Emitter<RemindersState> emit) async {
    TaskModel myTask =
        Repository().myTasks.firstWhere((element) => element.id == event.id);
    myTask = myTask.copyWith(isDone: !myTask.isDone);
    await Repository().updateTask(myTask).then((value) {
      add(LoadTasksForToday(
          datetime: DateTime(
              myTask.date!.year, myTask.date!.month, myTask.date!.day)));
    });
  }

  FutureOr<void> _onDeleteTask(
      DeleteTask event, Emitter<RemindersState> emit) async {
    List<TaskModel> tasksForToday = state.tasksForToday
            .where((element) => element.id != event.id)
            .toList(),
        myTasks =
            state.myTasks.where((element) => element.id != event.id).toList();
    await Repository().removeTask(event.id).then((value) {
      add(LoadData());
      emit(state.copyWith(tasksForToday: tasksForToday, myTasks: myTasks));
    });
  }
}
