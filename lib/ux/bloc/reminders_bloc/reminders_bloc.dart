import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/calendar.dart';
import 'package:chance_app/ui/pages/reminders_page/reminders_page.dart';
import 'package:meta/meta.dart';

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
  }

  FutureOr<void> _onChangeReminders(
      ChangeReminders event, Emitter<RemindersState> emit) {
    emit(state.copyWith(reminders: event.reminders));
  }

  FutureOr<void> _onLoadData(LoadData event, Emitter<RemindersState> emit) {
    List<Map<String, dynamic>> dates = [], week = [];
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;
    int day = now.day;
    int daysInMonth = DateTime(year, month + 1, 0).day;

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(year, month, i);
      String weekDay = getWeekdayName(date.weekday);
      dates.add({
        "weekDay": weekDay,
        "number": i.toString(),
        "month": month,
        "year": year,
        "isSelected": day == i ||
            (state.selectedDate != null &&
                (state.selectedDate!.day == i &&
                    state.selectedDate!.month == month &&
                    state.selectedDate!.year == year))
      });
    }

    int startOfWeek = day - now.weekday + 1;
    int endOfWeek = startOfWeek + 6;
    for (int i = startOfWeek; i <= endOfWeek; i++) {
      if (i <= 0 || i > DateTime(year, month + 1, 0).day) {
        continue;
      }
      DateTime date = DateTime(year, month, i);
      String weekDay = getWeekdayName(date.weekday);
      week.add({
        "weekDay": weekDay,
        "number": i.toString(),
        "month": month,
        "year": year,
        "isSelected": day == i ||
            (state.selectedDate != null &&
                (state.selectedDate!.day == i &&
                    state.selectedDate!.month == month &&
                    state.selectedDate!.year == year))
      });
    }

    emit(state.copyWith(
      days: dates,
      week: week,
      selectedDate: DateTime.now(),
      dateForSwiping: DateTime.now(),
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
    emit(state.copyWith(
        week: week,
        days: dates,
        selectedDate: DateTime(dates[index]["year"], dates[index]["month"],
            int.parse(dates[index]["number"]))));
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

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(year, month, i);
      String weekDay = getWeekdayName(date.weekday);
      dates.add({
        "weekDay": weekDay,
        "number": i.toString(),
        "month": month,
        "year": year,
        "isSelected": (selectedDate != null &&
            (selectedDate.day == i &&
                selectedDate.month == month &&
                selectedDate.year == year))
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
        "number": i.toString(),
        "month": month,
        "year": year,
        "isSelected": (selectedDate != null &&
            (selectedDate.day == i &&
                selectedDate.month == month &&
                selectedDate.year == year))
      });
    }

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

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(year, month, i);
      String weekDay = getWeekdayName(date.weekday);
      dates.add({
        "weekDay": weekDay,
        "number": i.toString(),
        "month": month,
        "year": year,
        "isSelected": (selectedDate != null &&
            (selectedDate.day == i &&
                selectedDate.month == month &&
                selectedDate.year == year))
      });
    }

    emit(state.copyWith(
        daysForTasks: dates, dateForSwipingForTasks: DateTime(year, month)));
  }

  FutureOr<void> _onSelectedDateForTasks(
      SelectedDateForTasks event, Emitter<RemindersState> emit) {
    List<Map<String, dynamic>> dates = state.daysForTasks;
    Map<String, dynamic> date = event.selectedDate;
    date["isSelected"] = true;

    int index = dates.indexWhere((e) => e["number"] == date["number"]);
    for (int i = 0; i < dates.length; i++) {
      dates[i]["isSelected"] = false;
    }
    dates[index]["isSelected"] = true;

    emit(state.copyWith(
        daysForTasks: dates,
        selectedDateForTasks: DateTime(dates[index]["year"], dates[index]["month"],
            int.parse(dates[index]["number"]))));
  }
}
