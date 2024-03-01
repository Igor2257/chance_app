
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/address_component.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/geometry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'geocoding_result.freezed.dart';

part 'geocoding_result.g.dart';

@freezed
@HiveType(typeId: 14)
class GeocodingResult with _$GeocodingResult {
  factory GeocodingResult({
    @HiveField(0) required List<String> types,
    @HiveField(1) required String? placeId,
    @HiveField(2) @Default(null) String? formattedAddress,
    @HiveField(3) @Default([]) List<AddressComponent> addressComponents,
    @HiveField(4) @Default([]) List<String> postcodeLocalities,
    @HiveField(5) @Default(null) Geometry? geometry,
    @HiveField(6) @Default(false) bool partialMatch,
  }) = _GeocodingResult;

  factory GeocodingResult.fromJson(Map<String, dynamic> json) => _$GeocodingResultFromJson(json);
}
