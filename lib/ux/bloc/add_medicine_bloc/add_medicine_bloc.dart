// import 'package:chance_app/ux/enum/day_periodicity.dart';
import 'dart:io';

import 'package:chance_app/ux/enum/medicine_instruction.dart';
import 'package:chance_app/ux/enum/medicine_type.dart';
import 'package:chance_app/ux/enum/periodicity.dart';
import 'package:chance_app/ux/model/medicine_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart';

part 'add_medicine_event.dart';
part 'add_medicine_state.dart';
part 'add_medicine_bloc.freezed.dart';

class AddMedicineBloc extends Bloc<AddMedicineEvent, AddMedicineState> {
  AddMedicineBloc() : super(const AddMedicineState()) {
    on<SetName>(_onSetName);
    on<SetType>(_onSetType);
    on<SetPeriodicity>(_onSetPeriodicity);
    // on<SetDayPeriodicity>(_onSetDayPeriodicity);
    on<SetStartDate>(_onSetStartDate);
    on<AddWeekday>(_onAddWeekday);
    on<RemoveWeekday>(_onRemoveWeekday);
    on<AddDose>(_onAddDose);
    on<ChangeDose>(_onChangeDose);
    on<AddInstruction>(_onAddInstruction);
    on<SaveMedicine>(_onSaveMedicine);
  }

  void _onSetName(SetName event, Emitter<AddMedicineState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onSetType(SetType event, Emitter<AddMedicineState> emit) {
    emit(state.copyWith(type: event.type));
  }

  void _onSetPeriodicity(SetPeriodicity event, Emitter<AddMedicineState> emit) {
    emit(state.copyWith(periodicity: event.periodicity));
  }

  // void _onSetDayPeriodicity(
  //     SetDayPeriodicity event, Emitter<AddMedicineState> emit) {
  //   emit(state.copyWith(dayPeriodicity: event.periodicity));
  // }

  void _onSetStartDate(SetStartDate event, Emitter<AddMedicineState> emit) {
    emit(state.copyWith(startDate: event.startDate));
  }

  void _onAddWeekday(AddWeekday event, Emitter<AddMedicineState> emit) {
    emit(
      state.copyWith(
        weekdays: Set.unmodifiable({
          ...state.weekdays,
          event.weekday,
        }),
      ),
    );
  }

  void _onRemoveWeekday(RemoveWeekday event, Emitter<AddMedicineState> emit) {
    emit(
      state.copyWith(
        weekdays: Set.unmodifiable(
          state.weekdays.where((item) => item != event.weekday),
        ),
      ),
    );
  }

  void _onAddDose(AddDose event, Emitter<AddMedicineState> emit) {
    emit(
      state.copyWith(
        doses: Map.unmodifiable({
          ...state.doses,
          event.time: event.count,
        }),
      ),
    );
  }

  void _onChangeDose(ChangeDose event, Emitter<AddMedicineState> emit) {
    final time = state.doses.keys.toList();
    final count = state.doses.values.toList();
    emit(
      state.copyWith(
        doses: Map.unmodifiable({
          for (var i = 0; i < state.doses.length; i++)
            if (i == event.index)
              event.time ?? time[i]: event.count ?? count[i]
            else
              time[i]: count[i],
        }),
      ),
    );
  }

  void _onAddInstruction(AddInstruction event, Emitter<AddMedicineState> emit) {
    emit(state.copyWith(instruction: event.instruction));
  }

  Future<void> _onSaveMedicine(
      SaveMedicine event, Emitter<AddMedicineState> emit) async {
    emit(state.copyWith(isSaving: true));

    const androidNotificationsChannel = AndroidNotificationChannel(
      "myMedicines",
      "Прийом ліків",
      description: "Нагадування про прийом ліків",
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

    // Android specific settings
    if (Platform.isAndroid) {
      final androidPlugin = FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      await androidPlugin
          ?.createNotificationChannel(androidNotificationsChannel);
    }

    // iOS specific settings
    if (Platform.isIOS) await Permission.criticalAlerts.request();

    final startDate = state.startDate!;
    final List<DateTime> reminderDays;

    // Calculate days for reminder setup
    switch (state.periodicity!) {
      case Periodicity.everyDay:
        reminderDays = List.generate(
          DateTime.daysPerWeek,
          (i) => DateTime(
            startDate.year,
            startDate.month,
            startDate.day + i,
          ),
        );

      case Periodicity.inADay:
        reminderDays = List.generate(
          DateTime.daysPerWeek,
          (i) => DateTime(
            startDate.year,
            startDate.month,
            startDate.day + i * 2,
          ),
        );

      case Periodicity.certainDays:
        reminderDays = [
          for (final weekday in state.weekdays)
            DateTime(
              startDate.year,
              startDate.month,
              startDate.day +
                  (14 - startDate.weekday + weekday) % DateTime.daysPerWeek,
            ),
        ];
    }

    final instruction = state.instruction ?? MedicineInstruction.noMatter;
    final shouldShowInstruction = instruction != MedicineInstruction.noMatter;
    final notificationIds = <int>{};
    var idCounter = 0;

    try {
      for (final time in state.doses.keys) {
        final timeText = [
          time.hour.toString().padLeft(2, "0"),
          time.minute.toString().padLeft(2, "0"),
        ].join(':');

        for (final day in reminderDays) {
          final notificationId = state.hashCode + idCounter;
          final scheduledTime = TZDateTime(
            local,
            day.year,
            day.month,
            day.day,
            time.hour,
            time.minute,
          );
          final count = state.doses[time]!;
          final reminderText = [
            count,
            state.type!.toDoseString(count).toLowerCase(),
            "сьогодні о",
            timeText,
          ].join(' ');

          debugPrint("Scheduled $notificationId at $scheduledTime");

          // Medicine reminder setup
          await FlutterLocalNotificationsPlugin().zonedSchedule(
            notificationId, // Must be a unique value
            state.name,
            (Platform.isIOS && !shouldShowInstruction)
                ? null
                : [
                    if (Platform.isIOS) "Прийняти" else reminderText,
                    if (shouldShowInstruction)
                      instruction.toLocalizedString().toLowerCase(),
                  ].join(' '),
            scheduledTime,
            NotificationDetails(
              android: AndroidNotificationDetails(
                androidNotificationsChannel.id,
                androidNotificationsChannel.name,
                // icon: state.type!.androidIconAsset,
                importance: Importance.max,
                priority: Priority.max,
                colorized: true,
              ),
              iOS: DarwinNotificationDetails(
                subtitle: reminderText,
                interruptionLevel: InterruptionLevel.critical,
              ),
            ),
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.wallClockTime,
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
          );

          notificationIds.add(notificationId); // Save current Id
          idCounter++;
        }
      }

      // Create a model to save in local DB
      final model = MedicineModel(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        reminderIds: notificationIds.toList(),
        name: state.name,
        type: state.type!,
        periodicity: state.periodicity!,
        startDate: state.startDate!,
        weekdays: state.weekdays.toList(),
        doses: {
          for (final time in state.doses.keys)
            Duration.minutesPerHour * time.hour + time.minute:
                state.doses[time]!,
        },
        instruction: state.instruction,
      );

      emit(state.copyWith(isSaving: false, medicine: model));
    } on Exception catch (e) {
      emit(state.copyWith(isSaving: false, errorMessage: e.toString()));
    }
  }
}
