import 'package:chance_app/ux/enum/instruction.dart';
import 'package:chance_app/ux/enum/medicine_status.dart';
import 'package:chance_app/ux/enum/medicine_type.dart';
import 'package:chance_app/ux/enum/periodicity.dart';
import 'package:chance_app/ux/model/hive_type_id.dart';
import 'package:flutter/material.dart' show DateUtils, TimeOfDay;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'medicine_model.freezed.dart';
part 'medicine_model.g.dart';

@freezed
@HiveType(typeId: HiveTypeId.medicineModel)
class MedicineModel with _$MedicineModel {
  const factory MedicineModel({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required MedicineType type,
    @HiveField(3) required Periodicity periodicity,
    @HiveField(4) required DateTime startDate,
    @HiveField(5) @Default([]) List<int> weekdays, // if Periodicity.certainDays
    @HiveField(6) required Map<int, int> doses, // minutes offset: count
    @HiveField(7) @Default(Instruction.noMatter) Instruction instruction,
    @HiveField(8) @Default([]) List<DateTime> doneAt, // as it's a regular event
    @HiveField(9) @Default({}) Map<DateTime, DateTime> rescheduledOn,
    @HiveField(10) @Default("") String userId,
    @HiveField(11) @Default(false) bool isSentToDB,
    @HiveField(12) @Default(false) bool isRemoved,
  }) = _MedicineModel;

  const MedicineModel._();

  factory MedicineModel.fromJson(Map<String, dynamic> json) =>
      _$MedicineModelFromJson(json);

  MedicineModel setDoneAt(DateTime dateTime) {
    if (!hasReminderAt(dateTime)) return this;
    return copyWith(
      doneAt: List.unmodifiable([...doneAt, dateTime]),
    );
  }

  MedicineModel reschedule(DateTime doseTime, Duration value) {
    if (!hasReminderAt(doseTime)) return this;
    return copyWith(
      rescheduledOn: Map.unmodifiable({
        ...rescheduledOn,
        doseTime: doseTime.add(value),
      }),
    );
  }

  bool hasRemindersAt(DateTime dayDate) {
    final currentDay = DateUtils.dateOnly(dayDate);
    final startDay = DateUtils.dateOnly(startDate);
    final hoursDiff = currentDay.difference(startDay).inHours;
    final isStarted = !hoursDiff.isNegative;
    switch (periodicity) {
      case Periodicity.everyDay:
        return isStarted;
      case Periodicity.inADay:
        return isStarted && (hoursDiff / Duration.hoursPerDay).round().isEven;
      case Periodicity.certainDays:
        return isStarted && weekdays.contains(currentDay.weekday);
    }
  }

  bool hasReminderAt(DateTime dateTime) {
    if (!hasRemindersAt(dateTime)) return false;
    final time = TimeOfDay.fromDateTime(dateTime);
    if (doses.containsKey(time.toTimeOffset())) return true;
    return rescheduledOn.values.any((element) => element == dateTime);
  }

  int? getDoseCountFor(DateTime dateTime) {
    if (!hasRemindersAt(dateTime)) return null;
    final time = TimeOfDay.fromDateTime(dateTime);
    return doses[time.toTimeOffset()];
  }

  DateTime? getActualDoneTime(DateTime doseTime) {
    if (doneAt.contains(doseTime)) return doseTime; // was taken in time
    return rescheduledOn[doseTime]; // or it was rescheduled (or missed)
  }

  MedicineStatus getStatus(DateTime doseTime) {
    if (!doseTime.isAfter(DateTime.now()) && hasRemindersAt(doseTime)) {
      final actualDoseTime = getActualDoneTime(doseTime);
      if (actualDoseTime == null) return MedicineStatus.missed;
      if (doneAt.contains(actualDoseTime)) return MedicineStatus.taken;
      return MedicineStatus.postponed;
    }
    return MedicineStatus.pending;
  }
}

extension ToTimeOffset on TimeOfDay {
  int toTimeOffset() => Duration.minutesPerHour * hour + minute;
}

extension ToTimeOfDay on int {
  TimeOfDay toTimeOfDay() => TimeOfDay(
        hour: this ~/ Duration.minutesPerHour,
        minute: this % Duration.minutesPerHour,
      );
}
