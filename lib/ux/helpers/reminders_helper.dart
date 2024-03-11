import 'dart:developer' show log;
import 'dart:io' show Platform;
import 'dart:math' show Random, pow;

import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/enum/instruction.dart';
import 'package:chance_app/ux/hive_crum.dart';
import 'package:chance_app/ux/model/medicine_model.dart';
import 'package:chance_app/ux/model/task_model.dart';
import 'package:flutter/material.dart' show DateTimeRange, DateUtils, TimeOfDay;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart';

abstract class RemindersHelper {
  /// Requests required permissions.
  static Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      final status = await Permission.scheduleExactAlarm.request();
      return status == PermissionStatus.granted;
    }
    if (Platform.isIOS) {
      final status = await Permission.criticalAlerts.request();
      return status == PermissionStatus.granted ||
          status == PermissionStatus.provisional;
    }
    return true;
  }

  /// Registers new pending notification for the [task].
  static Future<void> addTaskReminder(TaskModel task) async {
    final remindBeforeMinutes = task.remindBeforeMinutes;
    if (remindBeforeMinutes == null) return;

    final reminderOffset = Duration(minutes: remindBeforeMinutes);
    final reminderTime = task.date.subtract(reminderOffset);
    if (reminderTime.isBefore(DateTime.now())) return;

    const notificationChannel = AndroidNotificationChannel(
      "tasks",
      "Завдання",
      description: "Нагадування про виконання завдань",
      enableLights: true,
      ledColor: primary400,
    );
    final notificationConfig = _getNotificationConfig(task) ?? {};
    final notificationId = notificationConfig[task.date];
    final timeText = [
      task.date.hour.toString().padLeft(2, "0"),
      task.date.minute.toString().padLeft(2, "0"),
    ].join(':');

    // Task reminder setup
    final scheduledId = await _scheduleNotification(
      reminderTime,
      androidNotificationChannel: notificationChannel,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      id: notificationId,
      title: task.message,
      body: "Сьогодні $timeText",
    );

    if (scheduledId != notificationId) {
      await _updateNotificationConfig(task, config: {task.date: scheduledId});
    }
  }

  /// Cancels pending notification for the [task].
  static Future<void> cancelTaskReminder(TaskModel task) async {
    final notificationConfig = _getNotificationConfig(task);
    final notificationId = notificationConfig?[task.date];
    if (notificationId == null) return;
    await FlutterLocalNotificationsPlugin().cancel(notificationId);
    await _deleteNotificationConfig(task);
  }

  /// Registers new pending notification for the [medicine] at the [dateTime].
  static Future<void> addMedicineReminder(
    MedicineModel medicine, {
    required DateTime dateTime,
  }) async {
    if (dateTime.isBefore(DateTime.now())) return;
    if (!medicine.hasReminderAt(dateTime)) return;

    // Check if the reminder was rescheduled
    dateTime = medicine.rescheduledOn[dateTime] ?? dateTime;

    const notificationChannel = AndroidNotificationChannel(
      "medicines",
      "Медикаменти",
      description: "Нагадування про прийом ліків",
      enableLights: true,
      ledColor: primary400,
    );
    final notificationConfig = _getNotificationConfig(medicine) ?? {};
    final notificationId = notificationConfig[dateTime];
    final time = TimeOfDay.fromDateTime(dateTime);
    final timeText = [
      time.hour.toString().padLeft(2, "0"),
      time.minute.toString().padLeft(2, "0"),
    ].join(':');
    final count = medicine.doses[time.toTimeOffset()]!;
    final reminderText = [
      count,
      medicine.type.toDoseString(count).toLowerCase(),
      "сьогодні о",
      timeText,
    ].join(' ');
    final shouldShowInstruction = medicine.instruction != Instruction.noMatter;

    // Medicine reminder setup
    final scheduledId = await _scheduleNotification(
      dateTime,
      androidNotificationChannel: notificationChannel,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      id: notificationId,
      title: medicine.name,
      body: (Platform.isIOS && !shouldShowInstruction)
          ? null
          : [
              if (Platform.isIOS) "Прийняти" else reminderText,
              if (shouldShowInstruction)
                medicine.instruction.toLocalizedString().toLowerCase(),
            ].join(' '),
      iOSSubtitle: reminderText,
    );

    if (scheduledId != notificationId) {
      notificationConfig[dateTime] = scheduledId;
      await _updateNotificationConfig(medicine, config: notificationConfig);
    }
  }

  /// Schedules pending notifications for the [medicine] in the [dateRange] range.
  /// [DateTimeRange.end] day is included in scheduled range.
  static Future<void> addMedicineReminders(
    MedicineModel medicine, {
    required DateTimeRange dateRange,
  }) async {
    if (dateRange.end.isBefore(medicine.startDate)) return;

    final endDay = DateUtils.dateOnly(dateRange.end);
    var dayDate = dateRange.start.isAfter(medicine.startDate)
        ? DateUtils.dateOnly(dateRange.start)
        : DateUtils.dateOnly(medicine.startDate);

    while (!dayDate.isAfter(endDay)) {
      for (final timeOffset in medicine.doses.keys) {
        final time = timeOffset.toTimeOfDay();
        await addMedicineReminder(
          medicine,
          dateTime: dayDate.copyWith(hour: time.hour, minute: time.minute),
        );
      }
      dayDate = DateUtils.addDaysToDate(dayDate, 1);
    }
  }

  /// Cancels pending notification for the [medicine] at the [dateTime].
  static Future<void> cancelMedicineReminder(
    MedicineModel medicine, {
    required DateTime dateTime,
  }) async {
    final notificationConfig = _getNotificationConfig(medicine) ?? {};
    final notificationId = notificationConfig.remove(dateTime);
    if (notificationId == null) return;
    await FlutterLocalNotificationsPlugin().cancel(notificationId);
    await _updateNotificationConfig(medicine, config: notificationConfig);
  }

  /// Cancels all pending notification for the [medicine].
  static Future<void> cancelMedicineReminders(MedicineModel medicine) async {
    final notificationConfig = _getNotificationConfig(medicine);
    final notificationIds = notificationConfig?.values ?? [];
    for (final notificationId in notificationIds) {
      await FlutterLocalNotificationsPlugin().cancel(notificationId);
    }
    await _deleteNotificationConfig(medicine);
  }

  /// Cancels all pending notifications.
  static Future<void> cancelAll() async {
    for (final config in notificationsBox.values) {
      for (final notificationId in config.values) {
        await FlutterLocalNotificationsPlugin().cancel(notificationId);
      }
    }
    await notificationsBox.clear();
  }

  static Map<DateTime, int>? _getNotificationConfig<T>(T model) {
    return notificationsBox.get(model.hashCode);
  }

  static Future<void> _updateNotificationConfig<T>(
    T model, {
    required Map<DateTime, int> config,
  }) {
    return notificationsBox.put(model.hashCode, config);
  }

  static Future<void> _deleteNotificationConfig<T>(T model) {
    return notificationsBox.delete(model.hashCode);
  }

  static Future<int> _scheduleNotification(
    DateTime dateTime, {
    required AndroidNotificationChannel androidNotificationChannel,
    AndroidScheduleMode androidScheduleMode = AndroidScheduleMode.exact,
    int? id,
    String? title,
    String? body,
    String? iOSSubtitle,
    String? payload,
  }) async {
    final plugin = FlutterLocalNotificationsPlugin();

    if (Platform.isAndroid) {
      final androidPlugin = plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await androidPlugin
          ?.createNotificationChannel(androidNotificationChannel);
    }

    final pendingNotifications = await plugin.pendingNotificationRequests();
    final notificationIds = pendingNotifications.map((e) => e.id);
    // Check if the notification is already pending
    if (id != null && notificationIds.contains(id)) return id;

    final random = Random();
    final maxValue = pow(2, 31).toInt() - 1;
    int notificationId;

    do {
      notificationId = random.nextInt(maxValue);
    } while (notificationIds.contains(notificationId));

    await plugin.zonedSchedule(
      notificationId, // Must be a unique value
      title,
      body,
      TZDateTime.from(dateTime, local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          importance: Importance.max,
          priority: Priority.max,
          category: AndroidNotificationCategory.reminder,
        ),
        iOS: DarwinNotificationDetails(
          subtitle: iOSSubtitle,
          interruptionLevel: InterruptionLevel.critical,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      androidScheduleMode: androidScheduleMode,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
      payload: payload,
    );

    log('"$title" is scheduled on $dateTime', name: "Reminders");

    return notificationId;
  }
}
