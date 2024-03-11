import 'package:chance_app/ux/model/hive_type_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
@HiveType(typeId: HiveTypeId.taskModel)
class TaskModel with _$TaskModel {
  const factory TaskModel({
    @HiveField(0) required String id,
    @HiveField(1) required String message,
    @HiveField(2) required DateTime date,
    @HiveField(3) int? remindBeforeMinutes,
    @HiveField(4) @Default(false) bool isDone,
    @HiveField(5) @Default(false) bool isSentToDB,
    @HiveField(6) @Default(false) bool isRemoved,
  }) = _TaskModel;

  const TaskModel._();

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  TaskModel reschedule(Duration value) => copyWith(date: date.add(value));
}
