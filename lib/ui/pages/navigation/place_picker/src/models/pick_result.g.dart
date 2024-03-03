// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pick_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PickResultAdapter extends TypeAdapter<PickResult> {
  @override
  final int typeId = 16;

  @override
  PickResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PickResult(
      placeId: fields[0] as String?,
      geometry: fields[1] as Geometry?,
      formattedAddress: fields[2] as String?,
      types: (fields[3] as List?)?.cast<String>(),
      addressComponents: (fields[4] as List?)?.cast<AddressComponent>(),
      adrAddress: fields[5] as String?,
      formattedPhoneNumber: fields[6] as String?,
      id: fields[7] as String,
      reference: fields[8] as String?,
      icon: fields[9] as String?,
      name: fields[10] as String?,
      internationalPhoneNumber: fields[13] as String?,
      rating: fields[15] as num?,
      scope: fields[16] as String?,
      url: fields[17] as String?,
      vicinity: fields[18] as String?,
      utcOffset: fields[19] as num?,
      website: fields[20] as String?,
      star: fields[22] as bool,
      isRecentlySearched: fields[23] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PickResult obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.placeId)
      ..writeByte(1)
      ..write(obj.geometry)
      ..writeByte(2)
      ..write(obj.formattedAddress)
      ..writeByte(3)
      ..write(obj.types)
      ..writeByte(4)
      ..write(obj.addressComponents)
      ..writeByte(5)
      ..write(obj.adrAddress)
      ..writeByte(6)
      ..write(obj.formattedPhoneNumber)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.reference)
      ..writeByte(9)
      ..write(obj.icon)
      ..writeByte(10)
      ..write(obj.name)
      ..writeByte(13)
      ..write(obj.internationalPhoneNumber)
      ..writeByte(15)
      ..write(obj.rating)
      ..writeByte(16)
      ..write(obj.scope)
      ..writeByte(17)
      ..write(obj.url)
      ..writeByte(18)
      ..write(obj.vicinity)
      ..writeByte(19)
      ..write(obj.utcOffset)
      ..writeByte(20)
      ..write(obj.website)
      ..writeByte(22)
      ..write(obj.star)
      ..writeByte(23)
      ..write(obj.isRecentlySearched);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PickResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PickResultImpl _$$PickResultImplFromJson(Map<String, dynamic> json) =>
    _$PickResultImpl(
      placeId: json['placeId'] as String? ?? null,
      geometry: json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      formattedAddress: json['formattedAddress'] as String? ?? null,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              null,
      addressComponents: (json['addressComponents'] as List<dynamic>?)
              ?.map((e) => AddressComponent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          null,
      adrAddress: json['adrAddress'] as String? ?? null,
      formattedPhoneNumber: json['formattedPhoneNumber'] as String? ?? null,
      id: json['id'] as String,
      reference: json['reference'] as String? ?? null,
      icon: json['icon'] as String? ?? null,
      name: json['name'] as String? ?? null,
      internationalPhoneNumber:
          json['internationalPhoneNumber'] as String? ?? null,
      rating: json['rating'] as num? ?? null,
      scope: json['scope'] as String? ?? null,
      url: json['url'] as String? ?? null,
      vicinity: json['vicinity'] as String? ?? null,
      utcOffset: json['utcOffset'] as num? ?? null,
      website: json['website'] as String? ?? null,
      star: json['star'] as bool? ?? false,
      isRecentlySearched: json['isRecentlySearched'] as bool? ?? true,
    );

Map<String, dynamic> _$$PickResultImplToJson(_$PickResultImpl instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'geometry': instance.geometry,
      'formattedAddress': instance.formattedAddress,
      'types': instance.types,
      'addressComponents': instance.addressComponents,
      'adrAddress': instance.adrAddress,
      'formattedPhoneNumber': instance.formattedPhoneNumber,
      'id': instance.id,
      'reference': instance.reference,
      'icon': instance.icon,
      'name': instance.name,
      'internationalPhoneNumber': instance.internationalPhoneNumber,
      'rating': instance.rating,
      'scope': instance.scope,
      'url': instance.url,
      'vicinity': instance.vicinity,
      'utcOffset': instance.utcOffset,
      'website': instance.website,
      'star': instance.star,
      'isRecentlySearched': instance.isRecentlySearched,
    };
