// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sos_contact_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SosContactModelAdapter extends TypeAdapter<SosContactModel> {
  @override
  final int typeId = 2;

  @override
  SosContactModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SosContactModel(
      name: fields[1] as String,
      phone: fields[2] as String,
      groupName: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SosContactModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.groupName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SosContactModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SosContactModelImpl _$$SosContactModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SosContactModelImpl(
      name: json['name'] as String,
      phone: json['phone'] as String,
      groupName: json['groupName'] as String? ?? "",
    );

Map<String, dynamic> _$$SosContactModelImplToJson(
        _$SosContactModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'groupName': instance.groupName,
    };
