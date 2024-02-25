import 'package:chance_app/ux/enum/medicine_instruction.dart';
import 'package:chance_app/ux/enum/medicine_type.dart';
import 'package:chance_app/ux/enum/periodicity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'medicine_model.freezed.dart';
part 'medicine_model.g.dart';

@freezed
@HiveType(typeId: 4)
class MedicineModel with _$MedicineModel {
  factory MedicineModel({
    @HiveField(0) required int id,
    @HiveField(1) required List<int> reminderIds,
    @HiveField(2) required String name,
    @HiveField(3) required MedicineType type,
    @HiveField(4) required Periodicity periodicity,
    @HiveField(5) required DateTime startDate,
    @HiveField(6) @Default([]) List<int> weekdays,
    @HiveField(7) @Default({}) Map<int, int> doses,
    @HiveField(8) MedicineInstruction? instruction,
    //@HiveField(3) @Default("no") String notificationsBefore,
    @HiveField(10) @Default("") String userId,
    @HiveField(12) @Default(false) bool isSentToDB,
    @HiveField(13) @Default(false) bool isRemoved,
  }) = _MedicineModel;

  factory MedicineModel.fromJson(Map<String, dynamic> json) =>
      _$MedicineModelFromJson(json);
}
