// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sos_group_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SosGroupModelAdapter extends TypeAdapter<SosGroupModel> {
  @override
  final int typeId = 5;

  @override
  SosGroupModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SosGroupModel(
      id: fields[0] as String,
      name: fields[1] as String,
      contacts: (fields[2] as List).cast<SosContactModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, SosGroupModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.contacts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SosGroupModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SosGroupModelImpl _$$SosGroupModelImplFromJson(Map<String, dynamic> json) =>
    _$SosGroupModelImpl(
      id: json['id'] as String? ?? "",
      name: json['name'] as String,
      contacts: (json['contacts'] as List<dynamic>)
          .map((e) => SosContactModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SosGroupModelImplToJson(_$SosGroupModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'contacts': instance.contacts,
    };
