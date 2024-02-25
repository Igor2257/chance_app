part of 'reminders_bloc.dart';

class RemindersState {
  Reminders reminders;
  String taskTitle;
  DateTime? selectedDate = DateTime.now(),
      dateForSwiping = DateTime.now(),
      oldSelectedDateForTasks = DateTime.now(),
      newSelectedDateForTasks = DateTime.now(),
      dateForSwipingForTasks = DateTime.now(),
      oldDeadlineForTask = DateTime.now(),newDeadlineForTask=DateTime.now();
  bool isCalendarOpened;
  List<Map<String, dynamic>> week;
  List<Map<String, dynamic>> days, daysForTasks;
  int pageForPills, pageForTasks;
  NotificationsBefore oldNotificationsBefore, newNotificationsBefore,fromLastSession;
  TaskModel? taskModel;

  int sessionForNotification, sessionForSelectingDateForTask;
  final List<String> notifications = [
    "Немає",
    "Вчасно",
    "за 5хв",
    "за 30хв",
    "за 1 год",
    "за 1 день",
  ];
  List<TaskModel> myTasks, tasksForToday;
  bool isLoading;
  SideSwipe sideSwipe;

  RemindersState({
    this.reminders = Reminders.empty,
    this.taskTitle = "",
    this.isCalendarOpened = false,
    this.isLoading = true,
    this.days = const [],
    this.week = const [],
    this.myTasks = const [],
    this.tasksForToday = const [],
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
    this.sideSwipe = SideSwipe.left,
  });

  RemindersState copyWith({
    Reminders? reminders,
    String? taskTitle,
    DateTime? selectedDate,
    dateForSwiping,
    oldSelectedDateForTasks,newSelectedDateForTasks,
    dateForSwipingForTasks,
    oldDeadlineForTask,
    newDeadlineForTask,
    List<Map<String, dynamic>>? days,
    week,
    daysForTasks,
    bool? isCalendarOpened,
    int? pageForPills,
    pageForTasks,
    sessionForNotification,
    sessionForSelectingDateForTask,
    NotificationsBefore? oldNotificationsBefore,
    newNotificationsBefore,
    fromLastSession,
    TaskModel? taskModel,
    List<TaskModel>? myTasks,
    tasksForToday,
    bool? isLoading,
    SideSwipe? sideSwipe,
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
      tasksForToday: tasksForToday ?? this.tasksForToday,
      isLoading: isLoading ?? this.isLoading,
      sideSwipe: sideSwipe ?? this.sideSwipe,
    );
  }

  RemindersState clear() {
    return RemindersState(
      reminders: Reminders.empty,
      taskTitle: "",
      selectedDate: null,
      days: [],
      week: [],
      isCalendarOpened: false,
      dateForSwiping: null,
      pageForPills: 0,
      pageForTasks: 0,
      oldSelectedDateForTasks: null,
      newSelectedDateForTasks: null,
      dateForSwipingForTasks: null,
      daysForTasks: [],
      newDeadlineForTask: null,
      oldDeadlineForTask: null,
      oldNotificationsBefore: NotificationsBefore.no,
      newNotificationsBefore: NotificationsBefore.no,
      sessionForNotification: 0,
      taskModel: null,
      sessionForSelectingDateForTask: 0,
      myTasks: [],
      tasksForToday: [],
      isLoading: true,
      sideSwipe: SideSwipe.left,
    );
  }
}
