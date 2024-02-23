import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:timezone/timezone.dart';

part 'medicines_event.dart';
part 'medicines_state.dart';
part 'medicines_bloc.freezed.dart';

enum MedicineType {
  pill,
  injection,
  solution,
  drops,
  powder,
  other,
}

enum Periodicity {
  everyDay,
  inADay,
  certainDays,
}

enum DayPeriodicity {
  once,
  twice,
  other,
}

enum MedicineInstruction {
  beforeEating,
  whileEating,
  afterEating,
  noMatter,
}

class MedicinesBloc extends Bloc<MedicinesEvent, MedicinesState> {
  MedicinesBloc() : super(const MedicinesState()) {
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

  void _onSetName(SetName event, Emitter<MedicinesState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onSetType(SetType event, Emitter<MedicinesState> emit) {
    emit(state.copyWith(type: event.type));
  }

  void _onSetPeriodicity(SetPeriodicity event, Emitter<MedicinesState> emit) {
    emit(state.copyWith(periodicity: event.periodicity));
  }

  // void _onSetDayPeriodicity(SetDayPeriodicity event, Emitter<MedicinesState> emit) {}

  void _onSetStartDate(SetStartDate event, Emitter<MedicinesState> emit) {
    emit(state.copyWith(startDate: event.startDate));
  }

  void _onAddWeekday(AddWeekday event, Emitter<MedicinesState> emit) {
    emit(
      state.copyWith(
        weekdays: Set.unmodifiable({
          ...state.weekdays,
          event.weekday,
        }),
      ),
    );
  }

  void _onRemoveWeekday(RemoveWeekday event, Emitter<MedicinesState> emit) {
    emit(
      state.copyWith(
        weekdays: Set.unmodifiable(
          state.weekdays.where((item) => item != event.weekday),
        ),
      ),
    );
  }

  void _onAddDose(AddDose event, Emitter<MedicinesState> emit) {
    emit(
      state.copyWith(
        doses: Map.unmodifiable({
          ...state.doses,
          event.time: event.count,
        }),
      ),
    );
  }

  void _onChangeDose(ChangeDose event, Emitter<MedicinesState> emit) {
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

  void _onAddInstruction(AddInstruction event, Emitter<MedicinesState> emit) {
    emit(state.copyWith(instruction: event.instruction));
  }

  Future<void> _onSaveMedicine(
      SaveMedicine event, Emitter<MedicinesState> emit) async {
    emit(state.copyWith(isSaving: true));

    switch (state.periodicity!) {
      case Periodicity.everyDay:
      case Periodicity.inADay:
      case Periodicity.certainDays:
    }

    // FlutterLocalNotificationsPlugin().periodicallyShow(
    //   id,
    //   title,
    //   body,
    //   RepeatInterval,
    //   notificationDetails,
    // );

    // await FlutterLocalNotificationsPlugin().zonedSchedule(
    //   event.hashCode,
    //   state.name,
    //   S.current.notification_dailyReminderBody,
    //   TZDateTime(
    //     local,
    //     nearestMonday.year,
    //     nearestMonday.month,
    //     nearestMonday.day + weekday - 1,
    //     state.reminderTime.hour,
    //     state.reminderTime.minute,
    //   ),
    //   NotificationDetails(
    //     android: AndroidNotificationDetails(
    //       Environment.androidNotificationsChannel.id,
    //       Environment.androidNotificationsChannel.name,
    //     ),
    //     iOS: const DarwinNotificationDetails(),
    //   ),
    //   uiLocalNotificationDateInterpretation:
    //       UILocalNotificationDateInterpretation.wallClockTime,
    //   androidScheduleMode: AndroidScheduleMode.exact,
    //   matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    // );

    emit(state.copyWith(isSaving: false, created: true));
  }
}
