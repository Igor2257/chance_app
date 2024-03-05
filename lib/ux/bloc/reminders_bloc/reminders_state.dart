part of 'reminders_bloc.dart';
@immutable
class RemindersState {
  final bool isCalendarOpened;
  final List<Map<String, dynamic>> week;
  final List<Map<String, dynamic>> days;

  final List<TaskModel> myTasks;
  final List<MedicineModel> myMedicines;
  final bool isLoading;
  final DateTime? selectedDate, dateForSwiping;

  const RemindersState({
    this.isCalendarOpened = false,
    this.isLoading = true,
    this.days = const [],
    this.week = const [],
    this.myTasks = const [],
    this.myMedicines = const [],
    this.selectedDate,
    this.dateForSwiping,
  });

  RemindersState copyWith({
    DateTime? selectedDate,
    DateTime? dateForSwiping,
    List<Map<String, dynamic>>? days,
    List<Map<String, dynamic>>? week,
    bool? isCalendarOpened,
    List<TaskModel>? myTasks,
    List<MedicineModel>? myMedicines,
    bool? isLoading,
  }) {
    return RemindersState(
      selectedDate: selectedDate ?? this.selectedDate,
      dateForSwiping: dateForSwiping ?? this.dateForSwiping,
      days: days ?? this.days,
      week: week ?? this.week,
      isCalendarOpened: isCalendarOpened ?? this.isCalendarOpened,
      myTasks: myTasks ?? this.myTasks,
      myMedicines: myMedicines ?? this.myMedicines,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  RemindersState clear() {
    return RemindersState(
      days: const [],
      week: const [],
      isCalendarOpened: false,
      myTasks: HiveCRUM().myTasks,
      myMedicines: HiveCRUM().myMedicines,
      isLoading: true,
      selectedDate: DateTime.now(),
      dateForSwiping: DateTime.now(),
    );
  }
}
