import 'package:chance_app/ui/pages/reminders_page/tasks/custom_bottom_sheet_notificatenion_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'tasks_model.freezed.dart';

part 'tasks_model.g.dart';

@freezed
@HiveType(typeId: 0)
class TaskModel with _$TaskModel {
  factory TaskModel({
    @HiveField(0) required int id,
    @HiveField(1) @Default("") String name,
    @HiveField(2) required DateTime createdAt,
    @HiveField(3) @Default(null) DateTime? taskTo,
    @HiveField(4) @Default(NotificationsBefore.no) NotificationsBefore notificationsBefore,
    @HiveField(5) @Default(false) bool isDone
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);
}
