part of 'reminders_bloc.dart';

class RemindersState {
  Reminders reminders;
  String title;
  DateTime? selectedDate = DateTime.now(),currentDate= DateTime.now(),chosenDate= DateTime.now();
  bool isCalendarOpened;
  List<Map<String, dynamic>> week;
  List<Map<String, dynamic>> days;


  RemindersState({
    this.reminders = Reminders.medicine,
    this.title = "",
    this.isCalendarOpened = false,
    this.days = const [],
    this.week = const [],
    this.selectedDate,
    this.chosenDate,
    this.currentDate,
  });

  RemindersState copyWith({
    Reminders? reminders,
    String? title,
    DateTime? selectedDate,currentDate,chosenDate,
    List<Map<String, dynamic>>? days,
    week,
    bool? isCalendarOpened,
  }) {
    return RemindersState(
      reminders: reminders ?? this.reminders,
      title: title ?? this.title,
      selectedDate: selectedDate ?? this.selectedDate,
      days: days ?? this.days,
      week: week ?? this.week,
      currentDate: currentDate ?? this.currentDate,
      isCalendarOpened: isCalendarOpened ?? this.isCalendarOpened,
      chosenDate: chosenDate ?? this.chosenDate,
    );
  }
}
