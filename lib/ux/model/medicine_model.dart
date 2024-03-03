import 'package:chance_app/ux/enum/instruction.dart';
import 'package:chance_app/ux/enum/medicine_type.dart';
import 'package:chance_app/ux/enum/periodicity.dart';
import 'package:chance_app/ux/model/hive_type_id.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'medicine_model.freezed.dart';
part 'medicine_model.g.dart';

@freezed
@HiveType(typeId: HiveTypeId.medicineModel)
class MedicineModel with _$MedicineModel {
  factory MedicineModel({
    @HiveField(0) @Default("") String id,
    @HiveField(1) required List<int> reminderIds,
    @HiveField(2) required String name,
    @HiveField(3) required MedicineType type,
    @HiveField(4) required Periodicity periodicity,
    @HiveField(5) required DateTime startDate,
    @HiveField(6) @Default([]) List<int> weekdays, // if Periodicity.certainDays
    @HiveField(7) required Map<int, int> doses, // minutes offset: count
    @HiveField(8) @Default(Instruction.noMatter) Instruction instruction,
    @HiveField(9) @Default([]) List<DateTime> doneAt, // as it's a regular event
    @HiveField(11) @Default("") String userId,
    @HiveField(12) @Default(false) bool isSentToDB,
    @HiveField(13) @Default(false) bool isRemoved,
  }) = _MedicineModel;

  factory MedicineModel.fromJson(Map<String, dynamic> json) =>
      _$MedicineModelFromJson(json);
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
