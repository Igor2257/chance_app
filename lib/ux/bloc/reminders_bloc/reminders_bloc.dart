import 'dart:async';

import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/calendar.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/custom_bottom_sheet_notification_picker.dart';
import 'package:chance_app/ux/model/medicine_model.dart';
import 'package:chance_app/ux/model/task_model.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reminders_event.dart';
part 'reminders_state.dart';

class RemindersBloc extends Bloc<RemindersEvent, RemindersState> {
  RemindersBloc() : super(RemindersState()) {
    on<LoadData>(_onLoadData);
    on<SelectedDate>(_onSelectedDate);
    on<ChangeCalendarState>(_onChangeCalendarState);
    on<ChangeMonth>(_onChangeMonth);
    on<SaveTaskName>(_onSaveTaskName);
    on<ChangeMonthForTasks>(_onChangeMonthForTasks);
    on<SelectedDateForTasks>(_onSelectedDateForTasks);
    on<SaveDeadlineForTask>(_onSaveDeadlineForTask);
    on<SelectNotificationBefore>(_onSelectNotificationBefore);
    on<CancelNotificationBefore>(_onCancelNotificationBefore);
    on<CancelAllDataNotificationBefore>(_onCancelAllDataNotificationBefore);
    on<LoadDataForSelectDateForTasks>(_onLoadDataForSelectDateForTasks);
    on<SelectTask>(_onSelectTask);
    on<LoadTasksForToday>(_onLoadTasksForToday);
    on<ChangeIsDoneForTask>(_onChangeIsDoneForTask);
    on<DeleteTask>(_onDeleteTask);
    on<SaveTask>(_onSaveTask);
    on<SaveMedicine>(_onSaveMedicine);
    on<UpdateMedicine>(_onUpdateMedicine);
    on<DeleteMedicine>(_onDeleteMedicine);
  }

  bool checkIfDayHasTask(
      List<TaskModel> myTasks, int day, int month, int year) {
    for (int i = 0; i < myTasks.length; i++) {
      DateTime taskDate = myTasks[i].date!;
      if (DateUtils.isSameDay(taskDate, DateTime(year, month, day))) {
        return true;
      }
    }
    return false;
  }

  FutureOr<void> _onLoadData(
      LoadData event, Emitter<RemindersState> emit) async {
    emit(state.clear());
    await Repository().updateLocalTasks().then((tasks) async {
      await Repository().updateLocalMedicines().then((medicines) {
        List<Map<String, dynamic>> dates = [], week = [];
        DateTime now = DateTime.now();
        final int year = now.year;
        final int month = now.month;
        final int day = now.day;
        int daysInMonth = DateTime(year, month + 1, 0).day;
        List<TaskModel> myTasks =
            tasks.where((element) => element.isRemoved == false).toList();
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
                    DateUtils.isSameDay(date, state.selectedDate)),
            "hasTasks": checkIfDayHasTask(myTasks, i, month, year),
          });
        }
        myTasks = myTasks
            .where((element) => DateUtils.isSameDay(element.date, now))
            .toList();
        myTasks.sort((a, b) => a.date!.compareTo(b.date!));
        int startOfWeek = day - now.weekday;
        int endOfWeek = startOfWeek + 7;
        if (dates.length >= endOfWeek) {
          int daysLeftOfMonth = endOfWeek;
          week = dates
              .getRange(startOfWeek < 0 ? 0 : startOfWeek, daysLeftOfMonth)
              .toList();
          int weekLength = week.length;
          int dayInPreviousMonth;
          if (month - 1 > 0) {
            dayInPreviousMonth = DateUtils.getDaysInMonth(year, month - 1);
          } else {
            dayInPreviousMonth = DateUtils.getDaysInMonth(year - 1, 1);
          }
          for (int i = 0; i < (7) - weekLength; i++) {
            DateTime date = DateTime(year, month - 1, dayInPreviousMonth - i);
            String weekDay = getWeekdayName(date.weekday);

            week.insert(0, {
              "weekDay": weekDay,
              "number": ((dayInPreviousMonth - i).toString()).padLeft(2, "0"),
              "month": month - 1,
              "year": year,
              "isSelected": day == dayInPreviousMonth - i ||
                  (state.selectedDate != null &&
                      DateUtils.isSameDay(date, state.selectedDate)),
              "hasTasks": checkIfDayHasTask(
                  myTasks, dayInPreviousMonth - i, month - 1, year),
            });
          }
        } else {
          int daysLeftOfMonth = dates.length;
          week = dates.getRange(startOfWeek, daysLeftOfMonth).toList();
          int weekLength = week.length;
          for (int i = 0; i < 7 - weekLength; i++) {
            DateTime date = DateTime(year, month + 1, i + 1);
            String weekDay = getWeekdayName(date.weekday);

            week.add({
              "weekDay": weekDay,
              "number": ((i + 1).toString()).padLeft(2, "0"),
              "month": month + 1,
              "year": year,
              "isSelected": day == i + 1 ||
                  (state.selectedDate != null &&
                      DateUtils.isSameDay(date, state.selectedDate)),
              "hasTasks": checkIfDayHasTask(myTasks, i + 1, month + 1, year),
            });
          }
        }

        emit(state.copyWith(
            days: dates,
            week: week,
            selectedDate: DateTime.now(),
            dateForSwiping: DateTime.now(),
            myTasks: myTasks,
            isLoading: false,
            myMedicines: medicines
                .where((element) =>
                    //DateUtils.isSameDay(element.date, now) &&
                    element.isRemoved == false)
                .toList()));
      });
    });
  }

  FutureOr<void> _onSelectedDate(
      SelectedDate event, Emitter<RemindersState> emit) {
    List<Map<String, dynamic>> dates = state.days, week = state.week;
    Map<String, dynamic> date = event.selectedDate;
    DateTime now = DateTime(date["year"], date["month"], date["day"]);
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
    List<TaskModel> myTasks = List.from(
        Repository().myTasks.where((element) => element.isRemoved == false));

    myTasks = myTasks
        .where((element) => DateUtils.isSameDay(element.date, selectedDate))
        .toList();
    myTasks.sort((a, b) => a.date!.compareTo(b.date!));
    emit(state.copyWith(
        myTasks: myTasks,
        week: week,
        days: dates,
        selectedDate: selectedDate,
        myMedicines: List.from(Repository().myMedicines.where((element) =>
            // DateUtils.isSameDay(element.date, now) &&
            element.isRemoved == false))));
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
    List<TaskModel> myTasks = List.from(
        Repository().myTasks.where((element) => element.isRemoved == false));

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(year, month, i);
      String weekDay = getWeekdayName(date.weekday);
      dates.add({
        "weekDay": weekDay,
        "number": (i.toString()).padLeft(2, "0"),
        "month": month,
        "year": year,
        "isSelected":
            (selectedDate != null && DateUtils.isSameDay(date, selectedDate)),
        "hasTasks": checkIfDayHasTask(myTasks, i, month, year)
      });
    }
    int day = DateTime.now().day;
    int startOfWeek =
        (month == DateTime.now().month && year == DateTime.now().year)
            ? day - DateTime.now().weekday
            : 0;
    int endOfWeek = startOfWeek + 7;
    if (dates.length >= endOfWeek) {
      int daysLeftOfMonth = endOfWeek;
      week = dates
          .getRange(startOfWeek < 0 ? 0 : startOfWeek, daysLeftOfMonth)
          .toList();
      int weekLength = week.length;
      int dayInPreviousMonth;
      if (month - 1 > 0) {
        dayInPreviousMonth = DateUtils.getDaysInMonth(year, month - 1);
      } else {
        dayInPreviousMonth = DateUtils.getDaysInMonth(year - 1, 1);
      }
      for (int i = 0; i < (7) - weekLength; i++) {
        DateTime date = DateTime(year, month - 1, dayInPreviousMonth - i);
        String weekDay = getWeekdayName(date.weekday);

        week.insert(0, {
          "weekDay": weekDay,
          "number": ((dayInPreviousMonth - i).toString()).padLeft(2, "0"),
          "month": month - 1,
          "year": year,
          "isSelected": day == dayInPreviousMonth - i ||
              (selectedDate != null && DateUtils.isSameDay(date, selectedDate)),
          "hasTasks": checkIfDayHasTask(
              myTasks, dayInPreviousMonth - i, month - 1, year),
        });
      }
    } else {
      int daysLeftOfMonth = dates.length;
      week = dates.getRange(startOfWeek, daysLeftOfMonth).toList();
      int weekLength = week.length;
      for (int i = 0; i < 7 - weekLength; i++) {
        DateTime date = DateTime(year, month + 1, i + 1);
        String weekDay = getWeekdayName(date.weekday);

        week.add({
          "weekDay": weekDay,
          "number": ((i + 1).toString()).padLeft(2, "0"),
          "month": month + 1,
          "year": year,
          "isSelected": day == i + 1 ||
              (selectedDate != null && DateUtils.isSameDay(date, selectedDate)),
          "hasTasks": checkIfDayHasTask(myTasks, i + 1, month + 1, year),
        });
      }
    }
    myTasks = myTasks
        .where((element) => DateUtils.isSameDay(element.date, now))
        .toList();
    myTasks.sort((a, b) => a.date!.compareTo(b.date!));
    emit(state.copyWith(
        days: dates, week: week, dateForSwiping: DateTime(year, month)));
  }

  FutureOr<void> _onSaveTaskName(
      SaveTaskName event, Emitter<RemindersState> emit) {
    emit(state.copyWith(taskTitle: event.name));
  }

  FutureOr<void> _onChangeMonthForTasks(
      ChangeMonthForTasks event, Emitter<RemindersState> emit) {
    List<Map<String, dynamic>> dates = [];
    DateTime now = state.dateForSwipingForTasks ?? DateTime.now();
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
    List<TaskModel> myTasks = List.from(
        Repository().myTasks.where((element) => element.isRemoved == false));

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(year, month, i);
      String weekDay = getWeekdayName(date.weekday);
      dates.add({
        "weekDay": weekDay,
        "number": (i.toString()).padLeft(2, "0"),
        "month": month,
        "year": year,
        "isSelected": (state.selectedDate != null &&
            DateUtils.isSameDay(date, selectedDate)),
        "hasTasks": checkIfDayHasTask(myTasks, i, month, year)
      });
    }
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
          newDeadlineForTask: state.oldDeadlineForTask,
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
    List<TaskModel> myTasks = List.from(
        Repository().myTasks.where((element) => element.isRemoved == false));

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
                DateUtils.isSameDay(date, state.selectedDate)),
        "hasTasks": checkIfDayHasTask(myTasks, i, month, year)
      });
    }
    myTasks = myTasks
        .where((element) =>
            DateUtils.isSameDay(element.date, now) &&
            element.isRemoved == false)
        .toList();
    myTasks.sort((a, b) => a.date!.compareTo(b.date!));
    emit(state.copyWith(
      daysForTasks: dates,
      oldSelectedDateForTasks: DateTime.now(),
      newSelectedDateForTasks: DateTime.now(),
      dateForSwipingForTasks: DateTime.now(),
    ));
  }

  FutureOr<void> _onSelectTask(
      SelectTask event, Emitter<RemindersState> emit) async {
    final task = event.task.copyWith(isDone: !event.task.isDone);
    await Repository().updateTask(id: task.id, isDone: task.isDone);
    emit(
      state.copyWith(
        myTasks: [
          for (final element in state.myTasks)
            if (element.id == task.id) task else element,
        ],
      ),
    );
  }

  FutureOr<void> _onLoadTasksForToday(
      LoadTasksForToday event, Emitter<RemindersState> emit) {
    DateTime now = event.datetime;
    List<TaskModel> myTasks = List.from(Repository()
        .myTasks
        .where((element) =>
            DateUtils.isSameDay(element.date, now) &&
            element.isRemoved == false)
        .toList());
    emit(state.copyWith(myTasks: myTasks));
  }

  FutureOr<void> _onChangeIsDoneForTask(
      ChangeIsDoneForTask event, Emitter<RemindersState> emit) async {
    Repository repository = Repository();
    List<TaskModel> myTasks = List.from(state.myTasks);
    int index = myTasks.indexWhere(
        (element) => element.id == event.id && element.isRemoved == false);
    TaskModel myTask = myTasks[index];
    myTask = myTask.copyWith(isDone: !myTask.isDone);

    await repository
        .updateTask(isDone: myTask.isDone, id: myTask.id)
        .then((value) {
      if (value == null) {
        DateTime now =
            DateTime(myTask.date!.year, myTask.date!.month, myTask.date!.day);
        myTasks[index] = myTask;
        emit(state.copyWith(
            myTasks: myTasks
                .where((element) =>
                    element.date!.day == now.day &&
                    element.date!.month == now.month &&
                    element.date!.year == now.year &&
                    element.isRemoved == false)
                .toList()));
      }
    });
  }

  FutureOr<void> _onDeleteTask(
      DeleteTask event, Emitter<RemindersState> emit) async {
    await Repository().removeTask(event.id).then((value) {
      if (value == null) {
        List<TaskModel> myTasks = state.myTasks
            .where((element) =>
                element.id != event.id && element.isRemoved == false)
            .toList();

        emit(state.copyWith(myTasks: myTasks));
      }
    });
  }

  FutureOr<void> _onSaveTask(SaveTask event, Emitter<RemindersState> emit) {
    List<TaskModel> tasks = List.from(state.myTasks);
    tasks.add(event.taskModel);
    emit(state.copyWith(
      myTasks: tasks,
      taskTitle: "",
      oldSelectedDateForTasks: DateTime.now(),
      newSelectedDateForTasks: DateTime.now(),
      oldDeadlineForTask: DateTime.now(),
      newDeadlineForTask: DateTime.now(),
    ));
  }

  FutureOr<void> _onSaveMedicine(
      SaveMedicine event, Emitter<RemindersState> emit) async {
    await Repository().saveMedicine(event.medicineModel).then((value) {
      if (value == null) {
        List<MedicineModel> myMedicines = state.myMedicines
            .where((element) => element.isRemoved == false)
            .toList();
        myMedicines.add(event.medicineModel);

        emit(state.copyWith(myMedicines: myMedicines));
      }
    });
  }

  FutureOr<void> _onUpdateMedicine(
      UpdateMedicine event, Emitter<RemindersState> emit) async {
    await Repository().updateMedicine(event.medicineModel).then((value) {
      if (value == null) {
        List<MedicineModel> myMedicines = state.myMedicines
            .where((element) =>
                element.id != event.medicineModel.id &&
                element.isRemoved == false)
            .toList();
        myMedicines.add(event.medicineModel);
        emit(state.copyWith(myMedicines: myMedicines));
      }
    });
  }

  FutureOr<void> _onDeleteMedicine(
      DeleteMedicine event, Emitter<RemindersState> emit) async {
    await Repository().removeMedicine(event.id).then((value) {
      if (value == null) {
        List<MedicineModel> myMedicines = state.myMedicines
            .where((element) =>
                element.id != event.id && element.isRemoved == false)
            .toList();

        emit(state.copyWith(myMedicines: myMedicines));
      }
    });
  }
}
