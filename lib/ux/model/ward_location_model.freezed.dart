// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ward_location_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WardLocationModel _$WardLocationModelFromJson(Map<String, dynamic> json) {
  return _WardLocationModel.fromJson(json);
}

/// @nodoc
mixin _$WardLocationModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get wardId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get wardName => throw _privateConstructorUsedError;
  @HiveField(3)
  double get latitude => throw _privateConstructorUsedError;
  @HiveField(4)
  double get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WardLocationModelCopyWith<WardLocationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WardLocationModelCopyWith<$Res> {
  factory $WardLocationModelCopyWith(
          WardLocationModel value, $Res Function(WardLocationModel) then) =
      _$WardLocationModelCopyWithImpl<$Res, WardLocationModel>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String wardId,
      @HiveField(2) String wardName,
      @HiveField(3) double latitude,
      @HiveField(4) double longitude});
}

/// @nodoc
class _$WardLocationModelCopyWithImpl<$Res, $Val extends WardLocationModel>
    implements $WardLocationModelCopyWith<$Res> {
  _$WardLocationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wardId = null,
    Object? wardName = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      wardId: null == wardId
          ? _value.wardId
          : wardId // ignore: cast_nullable_to_non_nullable
              as String,
      wardName: null == wardName
          ? _value.wardName
          : wardName // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WardLocationModelImplCopyWith<$Res>
    implements $WardLocationModelCopyWith<$Res> {
  factory _$$WardLocationModelImplCopyWith(_$WardLocationModelImpl value,
          $Res Function(_$WardLocationModelImpl) then) =
      __$$WardLocationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String wardId,
      @HiveField(2) String wardName,
      @HiveField(3) double latitude,
      @HiveField(4) double longitude});
}

/// @nodoc
class __$$WardLocationModelImplCopyWithImpl<$Res>
    extends _$WardLocationModelCopyWithImpl<$Res, _$WardLocationModelImpl>
    implements _$$WardLocationModelImplCopyWith<$Res> {
  __$$WardLocationModelImplCopyWithImpl(_$WardLocationModelImpl _value,
      $Res Function(_$WardLocationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wardId = null,
    Object? wardName = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$WardLocationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      wardId: null == wardId
          ? _value.wardId
          : wardId // ignore: cast_nullable_to_non_nullable
              as String,
      wardName: null == wardName
          ? _value.wardName
          : wardName // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WardLocationModelImpl implements _WardLocationModel {
  const _$WardLocationModelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.wardId,
      @HiveField(2) required this.wardName,
      @HiveField(3) required this.latitude,
      @HiveField(4) required this.longitude});

  factory _$WardLocationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WardLocationModelImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String wardId;
  @override
  @HiveField(2)
  final String wardName;
  @override
  @HiveField(3)
  final double latitude;
  @override
  @HiveField(4)
  final double longitude;

  @override
  String toString() {
    return 'WardLocationModel(id: $id, wardId: $wardId, wardName: $wardName, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WardLocationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.wardId, wardId) || other.wardId == wardId) &&
            (identical(other.wardName, wardName) ||
                other.wardName == wardName) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, wardId, wardName, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WardLocationModelImplCopyWith<_$WardLocationModelImpl> get copyWith =>
      __$$WardLocationModelImplCopyWithImpl<_$WardLocationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WardLocationModelImplToJson(
      this,
    );
  }
}

abstract class _WardLocationModel implements WardLocationModel {
  const factory _WardLocationModel(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String wardId,
      @HiveField(2) required final String wardName,
      @HiveField(3) required final double latitude,
      @HiveField(4) required final double longitude}) = _$WardLocationModelImpl;

  factory _WardLocationModel.fromJson(Map<String, dynamic> json) =
      _$WardLocationModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get wardId;
  @override
  @HiveField(2)
  String get wardName;
  @override
  @HiveField(3)
  double get latitude;
  @override
  @HiveField(4)
  double get longitude;
  @override
  @JsonKey(ignore: true)
  _$$WardLocationModelImplCopyWith<_$WardLocationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
