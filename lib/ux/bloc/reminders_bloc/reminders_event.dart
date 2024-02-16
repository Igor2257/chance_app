part of 'reminders_bloc.dart';

@immutable
abstract class RemindersEvent {}

class LoadData extends RemindersEvent{
  LoadData();
}
class LoadDataForSelectDateForTasks extends RemindersEvent{
  LoadDataForSelectDateForTasks();
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

class SaveDeadlineForTask extends RemindersEvent{
  final DateTime dateTime;

  SaveDeadlineForTask({required this.dateTime});
}
class SelectNotificationBefore extends RemindersEvent{
  final NotificationsBefore notificationsBefore;
  final int session;

  SelectNotificationBefore({required this.notificationsBefore, required this.session});
}
class CancelNotificationBefore extends RemindersEvent{
  final int session;

  CancelNotificationBefore({ required this.session});
}
class CancelAllDataNotificationBefore extends RemindersEvent{
final int session;
  CancelAllDataNotificationBefore(this.session);
}

class SaveTasks extends RemindersEvent{
  SaveTasks();
}