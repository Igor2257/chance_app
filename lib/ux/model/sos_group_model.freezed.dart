// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sos_group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SosGroupModel _$SosGroupModelFromJson(Map<String, dynamic> json) {
  return _SosGroupModel.fromJson(json);
}

/// @nodoc
mixin _$SosGroupModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  List<SosContactModel> get contacts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SosGroupModelCopyWith<SosGroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosGroupModelCopyWith<$Res> {
  factory $SosGroupModelCopyWith(
          SosGroupModel value, $Res Function(SosGroupModel) then) =
      _$SosGroupModelCopyWithImpl<$Res, SosGroupModel>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) List<SosContactModel> contacts});
}

/// @nodoc
class _$SosGroupModelCopyWithImpl<$Res, $Val extends SosGroupModel>
    implements $SosGroupModelCopyWith<$Res> {
  _$SosGroupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? contacts = null,
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
      contacts: null == contacts
          ? _value.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<SosContactModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SosGroupModelImplCopyWith<$Res>
    implements $SosGroupModelCopyWith<$Res> {
  factory _$$SosGroupModelImplCopyWith(
          _$SosGroupModelImpl value, $Res Function(_$SosGroupModelImpl) then) =
      __$$SosGroupModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) List<SosContactModel> contacts});
}

/// @nodoc
class __$$SosGroupModelImplCopyWithImpl<$Res>
    extends _$SosGroupModelCopyWithImpl<$Res, _$SosGroupModelImpl>
    implements _$$SosGroupModelImplCopyWith<$Res> {
  __$$SosGroupModelImplCopyWithImpl(
      _$SosGroupModelImpl _value, $Res Function(_$SosGroupModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? contacts = null,
  }) {
    return _then(_$SosGroupModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      contacts: null == contacts
          ? _value._contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<SosContactModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SosGroupModelImpl implements _SosGroupModel {
  _$SosGroupModelImpl(
      {@HiveField(0) this.id = "",
      @HiveField(1) required this.name,
      @HiveField(2) required final List<SosContactModel> contacts})
      : _contacts = contacts;

  factory _$SosGroupModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SosGroupModelImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  final List<SosContactModel> _contacts;
  @override
  @HiveField(2)
  List<SosContactModel> get contacts {
    if (_contacts is EqualUnmodifiableListView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contacts);
  }

  @override
  String toString() {
    return 'SosGroupModel(id: $id, name: $name, contacts: $contacts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosGroupModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._contacts, _contacts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, const DeepCollectionEquality().hash(_contacts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SosGroupModelImplCopyWith<_$SosGroupModelImpl> get copyWith =>
      __$$SosGroupModelImplCopyWithImpl<_$SosGroupModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SosGroupModelImplToJson(
      this,
    );
  }
}

abstract class _SosGroupModel implements SosGroupModel {
  factory _SosGroupModel(
          {@HiveField(0) final String id,
          @HiveField(1) required final String name,
          @HiveField(2) required final List<SosContactModel> contacts}) =
      _$SosGroupModelImpl;

  factory _SosGroupModel.fromJson(Map<String, dynamic> json) =
      _$SosGroupModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  List<SosContactModel> get contacts;
  @override
  @JsonKey(ignore: true)
  _$$SosGroupModelImplCopyWith<_$SosGroupModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
