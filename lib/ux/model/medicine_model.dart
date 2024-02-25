import 'package:chance_app/ux/model/my_time_of_day.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'medicine_model.freezed.dart';

part 'medicine_model.g.dart';

@freezed
@HiveType(typeId: 4)
class MedicineModel with _$MedicineModel {
  factory MedicineModel({
    @HiveField(0) @Default("") String id,
    @HiveField(1) @Default("") String message,
    @HiveField(2) @Default("") String medicineType,
    @HiveField(3) @Default("") String periodicity,
    @HiveField(4) @Default("") String medicineInstruction,
    @HiveField(5) @Default([]) List<int> weekdays,
    @HiveField(6) @Default({}) Map<MyTimeOfDay, int> doses,
    @HiveField(7) @Default(null) DateTime? startDate,
    //@HiveField(3) @Default("no") String notificationsBefore,
    @HiveField(8) @Default(false) bool isDone,
    @HiveField(9) @Default("") String userId,
    @HiveField(10) @Default(false) bool isNotificationSent,
    @HiveField(11) @Default(false) bool isSentToDB,
    @HiveField(12) @Default(false) bool isRemoved,
  }) = _MedicineModel;

  factory MedicineModel.fromJson(Map<String, dynamic> json) =>
      _$MedicineModelFromJson(json);
}
