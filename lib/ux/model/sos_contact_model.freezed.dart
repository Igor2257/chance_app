// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sos_contact_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SosContactModel _$SosContactModelFromJson(Map<String, dynamic> json) {
  return _SosContactModel.fromJson(json);
}

/// @nodoc
mixin _$SosContactModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String get phone => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get group => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SosContactModelCopyWith<SosContactModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosContactModelCopyWith<$Res> {
  factory $SosContactModelCopyWith(
          SosContactModel value, $Res Function(SosContactModel) then) =
      _$SosContactModelCopyWithImpl<$Res, SosContactModel>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String phone,
      @HiveField(3) String? group});
}

/// @nodoc
class _$SosContactModelCopyWithImpl<$Res, $Val extends SosContactModel>
    implements $SosContactModelCopyWith<$Res> {
  _$SosContactModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? group = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SosContactModelImplCopyWith<$Res>
    implements $SosContactModelCopyWith<$Res> {
  factory _$$SosContactModelImplCopyWith(_$SosContactModelImpl value,
          $Res Function(_$SosContactModelImpl) then) =
      __$$SosContactModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String phone,
      @HiveField(3) String? group});
}

/// @nodoc
class __$$SosContactModelImplCopyWithImpl<$Res>
    extends _$SosContactModelCopyWithImpl<$Res, _$SosContactModelImpl>
    implements _$$SosContactModelImplCopyWith<$Res> {
  __$$SosContactModelImplCopyWithImpl(
      _$SosContactModelImpl _value, $Res Function(_$SosContactModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? group = freezed,
  }) {
    return _then(_$SosContactModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SosContactModelImpl implements _SosContactModel {
  _$SosContactModelImpl(
      {@HiveField(0) this.id = "",
      @HiveField(1) required this.name,
      @HiveField(2) required this.phone,
      @HiveField(3) this.group = ""});

  factory _$SosContactModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SosContactModelImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String phone;
  @override
  @JsonKey()
  @HiveField(3)
  final String? group;

  @override
  String toString() {
    return 'SosContactModel(id: $id, name: $name, phone: $phone, group: $group)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosContactModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.group, group) || other.group == group));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone, group);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SosContactModelImplCopyWith<_$SosContactModelImpl> get copyWith =>
      __$$SosContactModelImplCopyWithImpl<_$SosContactModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SosContactModelImplToJson(
      this,
    );
  }
}

abstract class _SosContactModel implements SosContactModel {
  factory _SosContactModel(
      {@HiveField(0) final String id,
      @HiveField(1) required final String name,
      @HiveField(2) required final String phone,
      @HiveField(3) final String? group}) = _$SosContactModelImpl;

  factory _SosContactModel.fromJson(Map<String, dynamic> json) =
      _$SosContactModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  String get phone;
  @override
  @HiveField(3)
  String? get group;
  @override
  @JsonKey(ignore: true)
  _$$SosContactModelImplCopyWith<_$SosContactModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
