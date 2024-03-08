// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ward_location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WardLocationModelAdapter extends TypeAdapter<WardLocationModel> {
  @override
  final int typeId = 6;

  @override
  WardLocationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WardLocationModel(
      id: fields[0] as String,
      wardId: fields[1] as String,
      wardName: fields[2] as String,
      latitude: fields[3] as double,
      longitude: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, WardLocationModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.wardId)
      ..writeByte(2)
      ..write(obj.wardName)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WardLocationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WardLocationModelImpl _$$WardLocationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$WardLocationModelImpl(
      id: json['id'] as String,
      wardId: json['wardId'] as String,
      wardName: json['wardName'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$$WardLocationModelImplToJson(
        _$WardLocationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'wardId': instance.wardId,
      'wardName': instance.wardName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
