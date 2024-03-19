part of 'add_task_bloc.dart';

@immutable
class AddTaskState {
  final String taskTitle;
  final List<String> notifications = [
    AppLocalizations.instance.translate("noDueDate"),
    AppLocalizations.instance.translate("inTime"),
    AppLocalizations.instance.translate("in5Minutes"),
    AppLocalizations.instance.translate("in30Minutes"),
    AppLocalizations.instance.translate("in60Minutes"),
    AppLocalizations.instance.translate("inOneDay"),
  ];
  final int pageForPills, pageForTasks;
  final NotificationsBefore oldNotificationsBefore,
      newNotificationsBefore,
      fromLastSession;
  final TaskModel? taskModel;
  final List<Map<String, dynamic>> daysForTasks;
  final DateTime? selectedDate,
      oldSelectedDateForTasks,
      newSelectedDateForTasks,
      dateForSwipingForTasks,
      oldDeadlineForTask,
      newDeadlineForTask;
  final int sessionForNotification, sessionForSelectingDateForTask;

  AddTaskState(
      {this.taskTitle = "",
      this.pageForPills = 0,
      this.pageForTasks = 0,
      this.fromLastSession = NotificationsBefore.no,
      this.oldNotificationsBefore = NotificationsBefore.no,
      this.newNotificationsBefore = NotificationsBefore.no,
      this.taskModel,
      this.daysForTasks = const [],
      this.selectedDate,
      this.oldSelectedDateForTasks,
      this.newSelectedDateForTasks,
      this.dateForSwipingForTasks,
      this.oldDeadlineForTask,
      this.sessionForNotification = 0,
      this.sessionForSelectingDateForTask = 0,
      this.newDeadlineForTask});

  AddTaskState copyWith({
    String? taskTitle,
    DateTime? selectedDate,
    DateTime? dateForSwiping,
    DateTime? oldSelectedDateForTasks,
    DateTime? newSelectedDateForTasks,
    DateTime? dateForSwipingForTasks,
    DateTime? oldDeadlineForTask,
    DateTime? newDeadlineForTask,
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
  }) {
    return AddTaskState(
      taskTitle: taskTitle ?? this.taskTitle,
      selectedDate: selectedDate ?? this.selectedDate,
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
    );
  }

  AddTaskState clear() {
    return AddTaskState(
      selectedDate: DateTime.now(),
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
      taskTitle: "",
    );
  }
}
