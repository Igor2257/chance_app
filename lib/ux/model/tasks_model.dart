import 'package:chance_app/ui/pages/reminders_page/tasks/custom_bottom_sheet_notification_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'tasks_model.freezed.dart';
part 'tasks_model.g.dart';

@freezed
@HiveType(typeId: 0)
class TaskModel with _$TaskModel {
  factory TaskModel({
    @HiveField(0) @Default("") String id,
    @HiveField(1) @Default("") String message,
    @HiveField(2) @Default(null) DateTime? date,
    //@HiveField(3) @Default("no") String notificationsBefore,
    @HiveField(3) @Default(false) bool isDone,
    @HiveField(4) @Default("") String userId,
    @HiveField(5) @Default(false) bool isSended,
    @HiveField(6) @Default(false) bool isRemoved,

  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);
}
