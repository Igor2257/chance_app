part of 'reminders_bloc.dart';

@immutable
abstract class RemindersEvent {}

class LoadData extends RemindersEvent {
  LoadData();
}



class ChangeCalendarState extends RemindersEvent {
  ChangeCalendarState();
}

class SelectedDate extends RemindersEvent {
  final Map<String, dynamic> selectedDate;

  SelectedDate({required this.selectedDate});
}

class ChangeMonth extends RemindersEvent {
  final SideSwipe sideSwipe;

  ChangeMonth({required this.sideSwipe});
}


class SelectTask extends RemindersEvent {
  final TaskModel task;

  SelectTask({required this.task});
}

class LoadTasksForToday extends RemindersEvent {
  final DateTime datetime;

  LoadTasksForToday({required this.datetime});
}

class ChangeIsDoneForTask extends RemindersEvent {
  final String id;

  ChangeIsDoneForTask({required this.id});
}

class DeleteTask extends RemindersEvent {
  final String id;

  DeleteTask({required this.id});
}

class SaveTask extends RemindersEvent {
  final TaskModel taskModel;

  SaveTask({required this.taskModel});
}
class SaveMedicine extends RemindersEvent {
  final MedicineModel medicineModel;

  SaveMedicine({required this.medicineModel});
}
class UpdateMedicine extends RemindersEvent {
  final MedicineModel medicineModel;

  UpdateMedicine({required this.medicineModel});
}
class DeleteMedicine extends RemindersEvent {
  final String id;

  DeleteMedicine({required this.id});
}