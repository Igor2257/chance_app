// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geometry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GeometryAdapter extends TypeAdapter<Geometry> {
  @override
  final int typeId = 11;

  @override
  Geometry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Geometry(
      location: fields[0] as Location,
      locationType: fields[1] as String?,
      viewport: fields[2] as Bounds?,
      bounds: fields[3] as Bounds?,
    );
  }

  @override
  void write(BinaryWriter writer, Geometry obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.location)
      ..writeByte(1)
      ..write(obj.locationType)
      ..writeByte(2)
      ..write(obj.viewport)
      ..writeByte(3)
      ..write(obj.bounds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeometryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GeometryImpl _$$GeometryImplFromJson(Map<String, dynamic> json) =>
    _$GeometryImpl(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      locationType: json['location_type'] as String?,
      viewport: json['viewport'] == null
          ? null
          : Bounds.fromJson(json['viewport'] as Map<String, dynamic>),
      bounds: json['bounds'] == null
          ? null
          : Bounds.fromJson(json['bounds'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GeometryImplToJson(_$GeometryImpl instance) =>
    <String, dynamic>{
      'location': instance.location,
      'location_type': instance.locationType,
      'viewport': instance.viewport,
      'bounds': instance.bounds,
    };
