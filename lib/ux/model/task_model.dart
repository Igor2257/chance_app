import 'package:chance_app/ux/model/hive_type_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
@HiveType(typeId: HiveTypeId.taskModel)
class TaskModel with _$TaskModel {
  const factory TaskModel({
    @HiveField(0) @Default("") String id,
    @HiveField(1) @Default("") String message,
    @HiveField(2) @Default(null) DateTime? date,
    @HiveField(3) @Default(false) bool isDone,
    @HiveField(6) @Default(false) bool isSentToDB,
    @HiveField(7) @Default(false) bool isRemoved,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
