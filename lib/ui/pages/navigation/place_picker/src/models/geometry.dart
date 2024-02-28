import 'package:chance_app/ui/pages/navigation/place_picker/src/models/bounds.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/location.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'geometry.freezed.dart';
part 'geometry.g.dart';
@freezed
@HiveType(typeId: 12)
class Geometry with _$Geometry {
  factory Geometry({
    @HiveField(0) required Location location,
    @HiveField(1) @Default(null) String? locationType,
    @HiveField(2) @Default(null) Bounds? viewport,
    @HiveField(3) @Default(null) Bounds? bounds,
  }) = _Geometry;

  factory Geometry.fromJson(Map<String, dynamic> json) => _$GeometryFromJson(json);
}