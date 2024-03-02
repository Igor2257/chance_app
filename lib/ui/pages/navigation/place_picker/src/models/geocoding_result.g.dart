// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoding_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GeocodingResultAdapter extends TypeAdapter<GeocodingResult> {
  @override
  final int typeId = 14;

  @override
  GeocodingResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeocodingResult(
      types: (fields[0] as List).cast<String>(),
      placeId: fields[1] as String?,
      formattedAddress: fields[2] as String?,
      addressComponents: (fields[3] as List).cast<AddressComponent>(),
      postcodeLocalities: (fields[4] as List).cast<String>(),
      geometry: fields[5] as Geometry?,
      partialMatch: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GeocodingResult obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.types)
      ..writeByte(1)
      ..write(obj.placeId)
      ..writeByte(2)
      ..write(obj.formattedAddress)
      ..writeByte(3)
      ..write(obj.addressComponents)
      ..writeByte(4)
      ..write(obj.postcodeLocalities)
      ..writeByte(5)
      ..write(obj.geometry)
      ..writeByte(6)
      ..write(obj.partialMatch);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeocodingResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GeocodingResultImpl _$$GeocodingResultImplFromJson(
        Map<String, dynamic> json) =>
    _$GeocodingResultImpl(
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
      placeId: json['placeId'] as String?,
      formattedAddress: json['formattedAddress'] as String? ?? null,
      addressComponents: (json['addressComponents'] as List<dynamic>?)
              ?.map((e) => AddressComponent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      postcodeLocalities: (json['postcodeLocalities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      geometry: json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      partialMatch: json['partialMatch'] as bool? ?? false,
    );

Map<String, dynamic> _$$GeocodingResultImplToJson(
        _$GeocodingResultImpl instance) =>
    <String, dynamic>{
      'types': instance.types,
      'placeId': instance.placeId,
      'formattedAddress': instance.formattedAddress,
      'addressComponents': instance.addressComponents,
      'postcodeLocalities': instance.postcodeLocalities,
      'geometry': instance.geometry,
      'partialMatch': instance.partialMatch,
    };
