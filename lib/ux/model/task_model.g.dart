// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

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
      id: fields[0] as String,
      message: fields[1] as String,
      date: fields[2] as DateTime,
      remindBeforeMinutes: fields[3] as int?,
      isDone: fields[4] as bool,
      isSentToDB: fields[5] as bool,
      isRemoved: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.remindBeforeMinutes)
      ..writeByte(4)
      ..write(obj.isDone)
      ..writeByte(5)
      ..write(obj.isSentToDB)
      ..writeByte(6)
      ..write(obj.isRemoved);
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
      id: json['id'] as String,
      message: json['message'] as String,
      date: DateTime.parse(json['date'] as String),
      remindBeforeMinutes: json['remindBeforeMinutes'] as int?,
      isDone: json['isDone'] as bool? ?? false,
      isSentToDB: json['isSentToDB'] as bool? ?? false,
      isRemoved: json['isRemoved'] as bool? ?? false,
    );

Map<String, dynamic> _$$TaskModelImplToJson(_$TaskModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'date': instance.date.toIso8601String(),
      'remindBeforeMinutes': instance.remindBeforeMinutes,
      'isDone': instance.isDone,
      'isSentToDB': instance.isSentToDB,
      'isRemoved': instance.isRemoved,
    };
