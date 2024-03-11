import 'dart:async';
import 'dart:io';

import 'package:chance_app/main.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ux/enum/instruction.dart';
import 'package:chance_app/ux/model/medicine_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart';
import 'package:timezone/timezone.dart';
import 'package:workmanager/workmanager.dart';

abstract class _TaskKeys {
  static const testScheduler = "test_scheduler";
  static const reminderScheduler = "reminder_scheduler";
}

abstract class WorkmanagerHelper {
  static Future<void> initialize() => Workmanager().initialize(
        _callbackDispatcher,
        isInDebugMode: true,
      );

  static Future<void> setupTestScheduler([DateTime? dateTime]) async {
    final time = dateTime ?? DateTime.now();
    final nextHour = DateTime(time.year, time.month, time.day, time.hour + 1);
    await Workmanager().registerOneOffTask(
      _TaskKeys.testScheduler,
      _TaskKeys.testScheduler, // Ignored on iOS
      initialDelay: nextHour.difference(time),
      existingWorkPolicy: ExistingWorkPolicy.replace,
      backoffPolicy: BackoffPolicy.linear,
      inputData: {"time": nextHour.toString()},
    );
  }

  static Future<void> setupReminderScheduler([DateTime? dateTime]) async {
    final time = dateTime ?? DateTime.now();
    final today = DateUtils.dateOnly(time);
    final tomorrow = DateUtils.addDaysToDate(today, 1);
    await Workmanager().registerOneOffTask(
      _TaskKeys.reminderScheduler,
      _TaskKeys.reminderScheduler, // Ignored on iOS
      initialDelay: tomorrow.difference(time),
      existingWorkPolicy: ExistingWorkPolicy.replace,
      backoffPolicy: BackoffPolicy.linear,
      inputData: {"dayDate": today.toString()},
    );
  }
}

@pragma('vm:entry-point')
Future<void> _callbackDispatcher() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Local notifications plugin setup
  await FlutterLocalNotificationsPlugin().initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings(kDefaultAndroidIcon),
      iOS: DarwinInitializationSettings(),
    ),
  );

  // Timezone setup, is required by scheduler
  final currentTimeZone = await FlutterTimezone.getLocalTimezone();
  initializeTimeZones();
  setLocalLocation(getLocation(currentTimeZone));

  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case _TaskKeys.testScheduler:
        final time = DateTime.parse(inputData!["time"]!);
        const androidNotificationsChannel = AndroidNotificationChannel(
          "test",
          "Тестовий канал",
          description: "Тестування планувальника",
          importance: Importance.max,
          playSound: true,
          enableVibration: true,
        );

        await FlutterLocalNotificationsPlugin().zonedSchedule(
          0,
          "Test reminder",
          "Should be fired at $time",
          TZDateTime.from(time, local),
          NotificationDetails(
            android: AndroidNotificationDetails(
              androidNotificationsChannel.id,
              androidNotificationsChannel.name,
              importance: Importance.max,
              priority: Priority.max,
            ),
            iOS: const DarwinNotificationDetails(
              interruptionLevel: InterruptionLevel.critical,
            ),
          ),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.wallClockTime,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.dateAndTime,
        );

        // Register the next scheduler
        final next = DateTime(time.year, time.month, time.day, time.hour + 1);
        unawaited(WorkmanagerHelper.setupTestScheduler(next));

        return true;

      case _TaskKeys.reminderScheduler:
        final today = DateTime.parse(inputData!["dayDate"]!);
        final hiveIsInitialized = await initHiveBoxes();
        if (hiveIsInitialized) {
          var notificationIdCounter = 4567; // must be a unique int value
          for (final medicine in medicineBox!.values) {
            if (!medicine.hasRemindersAt(today)) continue;

            final androidNotificationsChannel = AndroidNotificationChannel(
              "myMedicines",
              AppLocalizations.instance.translate("takingMedication"),
              description:
                  AppLocalizations.instance.translate("medicationReminder"),
              importance: Importance.max,
              playSound: true,
              enableVibration: true,
            );

            for (final timeOffset in medicine.doses.keys) {
              final count = medicine.doses[timeOffset]!;
              final time = timeOffset.toTimeOfDay();
              final timeText = [
                time.hour.toString().padLeft(2, "0"),
                time.minute.toString().padLeft(2, "0"),
              ].join(':');
              final instruction = medicine.instruction;
              final shouldShowInstruction = instruction != Instruction.noMatter;
              final reminderText = [
                count,
                medicine.type.toDoseString(count).toLowerCase(),
                AppLocalizations.instance.translate("todayAt").toLowerCase(),
                timeText,
              ].join(' ');

              // Android specific settings
              if (Platform.isAndroid) {
                await FlutterLocalNotificationsPlugin()
                    .resolvePlatformSpecificImplementation<
                        AndroidFlutterLocalNotificationsPlugin>()
                    ?.createNotificationChannel(androidNotificationsChannel);
              }

              // Medicine reminder setup
              await FlutterLocalNotificationsPlugin().zonedSchedule(
                notificationIdCounter++,
                medicine.name,
                (Platform.isIOS && !shouldShowInstruction)
                    ? null
                    : [
                        if (Platform.isIOS)
                          AppLocalizations.instance.translate("accept")
                        else
                          reminderText,
                        if (shouldShowInstruction)
                          instruction.toLocalizedString().toLowerCase(),
                      ].join(' '),
                TZDateTime.local(
                  today.year,
                  today.month,
                  today.day,
                  time.hour,
                  time.minute,
                ),
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    androidNotificationsChannel.id,
                    androidNotificationsChannel.name,
                    // icon: medicine.type.androidIconAsset,
                    importance: Importance.max,
                    priority: Priority.max,
                  ),
                  iOS: DarwinNotificationDetails(
                    subtitle: reminderText,
                    interruptionLevel: InterruptionLevel.critical,
                  ),
                ),
                uiLocalNotificationDateInterpretation:
                    UILocalNotificationDateInterpretation.wallClockTime,
                androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
                matchDateTimeComponents: DateTimeComponents.dateAndTime,
              );
            }
          }

          // Register the next day scheduler
          final tomorrow = DateUtils.addDaysToDate(today, 1);
          unawaited(WorkmanagerHelper.setupReminderScheduler(tomorrow));

          return true;
        }
    }

    return false;
  });
}
