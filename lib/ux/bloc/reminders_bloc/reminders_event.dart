part of 'reminders_bloc.dart';

@immutable
abstract class RemindersEvent {}

class LoadData extends RemindersEvent{
  LoadData();
}
class ChangeCalendarState extends RemindersEvent{
  ChangeCalendarState();
}
class ChangeReminders extends RemindersEvent{
  final Reminders reminders;

  ChangeReminders({required this.reminders});
}

class SelectedDate extends RemindersEvent{
  final Map<String,dynamic> selectedDate;

  SelectedDate({required this.selectedDate});
}


class ChangeMonth extends RemindersEvent{
  final SideSwipe sideSwipe;

  ChangeMonth({required this.sideSwipe});
}

class SelectWhatPersonWouldLikeToAdd extends RemindersEvent{
  final Reminders reminders;

  SelectWhatPersonWouldLikeToAdd({required this.reminders});
}

class SaveTaskName extends RemindersEvent{
final String name;

  SaveTaskName({required this.name});
}

class ChangeMonthForTasks extends RemindersEvent{
  final SideSwipe sideSwipe;

  ChangeMonthForTasks({required this.sideSwipe});
}

class SelectedDateForTasks extends RemindersEvent{
  final Map<String,dynamic> selectedDate;

  SelectedDateForTasks({required this.selectedDate});
}