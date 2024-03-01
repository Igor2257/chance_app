part of 'reminders_bloc.dart';
@immutable
class RemindersState {
  final String taskTitle;
  final DateTime? selectedDate,
      dateForSwiping,
      oldSelectedDateForTasks,
      newSelectedDateForTasks,
      dateForSwipingForTasks,
      oldDeadlineForTask,
      newDeadlineForTask;
  final bool isCalendarOpened;
  final List<Map<String, dynamic>> week;
  final List<Map<String, dynamic>> days, daysForTasks;
  final int pageForPills, pageForTasks;
  final NotificationsBefore oldNotificationsBefore,
      newNotificationsBefore,
      fromLastSession;
  final TaskModel? taskModel;

  final int sessionForNotification, sessionForSelectingDateForTask;
  final List<String> notifications = [
    "Немає",
    "Вчасно",
    "за 5хв",
    "за 30хв",
    "за 1 год",
    "за 1 день",
  ];
  final List<TaskModel> myTasks;
  final bool isLoading;

  RemindersState({
    this.taskTitle = "",
    this.isCalendarOpened = false,
    this.isLoading = true,
    this.days = const [],
    this.week = const [],
    this.myTasks = const [],
    this.daysForTasks = const [],
    this.selectedDate,
    this.dateForSwiping,
    this.pageForPills = 0,
    this.pageForTasks = 0,
    this.sessionForNotification = 0,
    this.sessionForSelectingDateForTask = 0,
    this.oldSelectedDateForTasks,
    this.newSelectedDateForTasks,
    this.dateForSwipingForTasks,
    this.oldDeadlineForTask,
    this.newDeadlineForTask,
    this.fromLastSession = NotificationsBefore.no,
    this.oldNotificationsBefore = NotificationsBefore.no,
    this.newNotificationsBefore = NotificationsBefore.no,
    this.taskModel,
  });

  RemindersState copyWith({
    String? taskTitle,
    DateTime? selectedDate,
    DateTime? dateForSwiping,
    DateTime? oldSelectedDateForTasks,
    DateTime? newSelectedDateForTasks,
    DateTime? dateForSwipingForTasks,
    DateTime? oldDeadlineForTask,
    DateTime? newDeadlineForTask,
    List<Map<String, dynamic>>? days,
    List<Map<String, dynamic>>? week,
    List<Map<String, dynamic>>? daysForTasks,
    bool? isCalendarOpened,
    int? pageForPills,
    int? pageForTasks,
    int? sessionForNotification,
    int? sessionForSelectingDateForTask,
    NotificationsBefore? oldNotificationsBefore,
    NotificationsBefore? newNotificationsBefore,
    NotificationsBefore? fromLastSession,
    TaskModel? taskModel,
    List<TaskModel>? myTasks,
    bool? isLoading,
  }) {
    return RemindersState(
      taskTitle: taskTitle ?? this.taskTitle,
      selectedDate: selectedDate ?? this.selectedDate,
      days: days ?? this.days,
      week: week ?? this.week,
      isCalendarOpened: isCalendarOpened ?? this.isCalendarOpened,
      dateForSwiping: dateForSwiping ?? this.dateForSwiping,
      pageForPills: pageForPills ?? this.pageForPills,
      pageForTasks: pageForTasks ?? this.pageForTasks,
      oldSelectedDateForTasks:
          oldSelectedDateForTasks ?? this.oldSelectedDateForTasks,
      newSelectedDateForTasks:
          newSelectedDateForTasks ?? this.newSelectedDateForTasks,
      dateForSwipingForTasks:
          dateForSwipingForTasks ?? this.dateForSwipingForTasks,
      daysForTasks: daysForTasks ?? this.daysForTasks,
      newDeadlineForTask: newDeadlineForTask ?? this.newDeadlineForTask,
      oldDeadlineForTask: oldDeadlineForTask ?? this.oldDeadlineForTask,
      oldNotificationsBefore:
          oldNotificationsBefore ?? this.oldNotificationsBefore,
      newNotificationsBefore:
          newNotificationsBefore ?? this.newNotificationsBefore,
      sessionForNotification:
          sessionForNotification ?? this.sessionForNotification,
      fromLastSession: fromLastSession ?? this.fromLastSession,
      taskModel: taskModel ?? this.taskModel,
      sessionForSelectingDateForTask:
          sessionForSelectingDateForTask ?? this.sessionForSelectingDateForTask,
      myTasks: myTasks ?? this.myTasks,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  RemindersState clear() {
    return RemindersState(
      taskTitle: "",
      selectedDate: DateTime.now(),
      days: const [],
      week: const [],
      isCalendarOpened: false,
      dateForSwiping: DateTime.now(),
      pageForPills: 0,
      pageForTasks: 0,
      oldSelectedDateForTasks: DateTime.now(),
      newSelectedDateForTasks: DateTime.now(),
      dateForSwipingForTasks: DateTime.now(),
      daysForTasks: const [],
      newDeadlineForTask: DateTime.now(),
      oldDeadlineForTask: DateTime.now(),
      oldNotificationsBefore: NotificationsBefore.no,
      newNotificationsBefore: NotificationsBefore.no,
      sessionForNotification: 0,
      taskModel: null,
      sessionForSelectingDateForTask: 0,
      myTasks: const [],
      isLoading: true,
    );
  }
}
