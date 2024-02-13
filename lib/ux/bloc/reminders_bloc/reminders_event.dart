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