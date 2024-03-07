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
      id: fields[0] as String,
      name: fields[1] as String,
      phone: fields[2] as String,
      group: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SosContactModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.group);
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
      id: json['id'] as String? ?? "",
      name: json['name'] as String,
      phone: json['phone'] as String,
      group: json['group'] as String? ?? "",
    );

Map<String, dynamic> _$$SosContactModelImplToJson(
        _$SosContactModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'group': instance.group,
    };
