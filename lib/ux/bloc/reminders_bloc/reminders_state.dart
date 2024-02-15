part of 'reminders_bloc.dart';

class RemindersState {
  Reminders reminders;
  String taskTitle;
  DateTime? selectedDate = DateTime.now(),
      dateForSwiping = DateTime.now(),
      selectedDateForTasks = DateTime.now(),
      dateForSwipingForTasks = DateTime.now();
  bool isCalendarOpened;
  List<Map<String, dynamic>> week;
  List<Map<String, dynamic>> days, daysForTasks;
  int pageForPills, pageForTasks;

  RemindersState({
    this.reminders = Reminders.empty,
    this.taskTitle = "",
    this.isCalendarOpened = false,
    this.days = const [],
    this.week = const [],
    this.daysForTasks = const [],
    this.selectedDate,
    this.dateForSwiping,
    this.pageForPills = 0,
    this.pageForTasks = 0,
    this.selectedDateForTasks,
    this.dateForSwipingForTasks,
  });

  RemindersState copyWith({
    Reminders? reminders,
    String? taskTitle,
    DateTime? selectedDate,
    dateForSwiping,
    selectedDateForTasks,
    dateForSwipingForTasks,
    List<Map<String, dynamic>>? days,
    week,
    daysForTasks,
    bool? isCalendarOpened,
    int? pageForPills,
    pageForTasks,
  }) {
    return RemindersState(
      reminders: reminders ?? this.reminders,
      taskTitle: taskTitle ?? this.taskTitle,
      selectedDate: selectedDate ?? this.selectedDate,
      days: days ?? this.days,
      week: week ?? this.week,
      isCalendarOpened: isCalendarOpened ?? this.isCalendarOpened,
      dateForSwiping: dateForSwiping ?? this.dateForSwiping,
      pageForPills: pageForPills ?? this.pageForPills,
      pageForTasks: pageForTasks ?? this.pageForTasks,
      selectedDateForTasks: selectedDateForTasks ?? this.selectedDateForTasks,
      dateForSwipingForTasks:
          dateForSwipingForTasks ?? this.dateForSwipingForTasks,
      daysForTasks: daysForTasks ?? this.daysForTasks,
    );
  }
}
