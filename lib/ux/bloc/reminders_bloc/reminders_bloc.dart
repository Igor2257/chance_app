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
            (state.selectedDate != null ??
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
            (state.selectedDate != null ??
                (state.selectedDate!.day == i &&
                    state.selectedDate!.month == month &&
                    state.selectedDate!.year == year))
      });
    }

    emit(state.copyWith(
      days: dates,
      week: week,
      currentDate: DateTime.now(),
      selectedDate: DateTime.now(),
      chosenDate: DateTime.now(),
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
    emit(state.copyWith(week: week, days: dates));
  }

  FutureOr<void> _onChangeCalendarState(
      ChangeCalendarState event, Emitter<RemindersState> emit) {
    emit(state.copyWith(isCalendarOpened: !state.isCalendarOpened));
  }

  FutureOr<void> _onChangeMonth(
      ChangeMonth event, Emitter<RemindersState> emit) {
    List<Map<String, dynamic>> dates = [], week = [];
    DateTime now = state.chosenDate ?? DateTime.now();
    int plusOrMinus = event.sideSwipe == SideSwipe.left ? -1 : 1;
    int year = now.year;
    int month = now.month;
    int day = now.day;
    if (month + plusOrMinus <= 12 && month + plusOrMinus >= 0) {
      month = now.month + plusOrMinus;
    } else {
      if (event.sideSwipe == SideSwipe.left) {
        year = now.year - 1;
        month=12;
      } else {
        year = now.year + 1;
        month=1;
      }
    }

    int daysInMonth = DateTime(year, month + 1, 0).day;

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(year, month, i);
      String weekDay = getWeekdayName(date.weekday);
      dates.add({
        "weekDay": weekDay,
        "number": i.toString(),
        "month": month,
        "year": year,
        "isSelected": false
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
        "isSelected": false
      });
    }

    emit(state.copyWith(
        days: dates, week: week, chosenDate: DateTime(year, month)));
  }
}
