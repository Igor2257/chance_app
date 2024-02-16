// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 0;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      id: fields[0] as int,
      name: fields[1] as String,
      createdAt: fields[2] as DateTime,
      taskTo: fields[3] as DateTime?,
      notificationsBefore: fields[4] as NotificationsBefore,
      isDone: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.taskTo)
      ..writeByte(4)
      ..write(obj.notificationsBefore)
      ..writeByte(5)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskModelImpl _$$TaskModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskModelImpl(
      id: json['id'] as int,
      name: json['name'] as String? ?? "",
      createdAt: DateTime.parse(json['createdAt'] as String),
      taskTo: json['taskTo'] == null
          ? null
          : DateTime.parse(json['taskTo'] as String),
      notificationsBefore: $enumDecodeNullable(
              _$NotificationsBeforeEnumMap, json['notificationsBefore']) ??
          NotificationsBefore.no,
      isDone: json['isDone'] as bool? ?? false,
    );

Map<String, dynamic> _$$TaskModelImplToJson(_$TaskModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'taskTo': instance.taskTo?.toIso8601String(),
      'notificationsBefore':
          _$NotificationsBeforeEnumMap[instance.notificationsBefore]!,
      'isDone': instance.isDone,
    };

const _$NotificationsBeforeEnumMap = {
  NotificationsBefore.no: 'no',
  NotificationsBefore.atTime: 'atTime',
  NotificationsBefore.fiveMinute: 'fiveMinute',
  NotificationsBefore.thirtyMinute: 'thirtyMinute',
  NotificationsBefore.oneHour: 'oneHour',
  NotificationsBefore.oneDay: 'oneDay',
};
