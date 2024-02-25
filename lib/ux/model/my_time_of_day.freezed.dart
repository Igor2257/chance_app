// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_time_of_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MyTimeOfDay _$MyTimeOfDayFromJson(Map<String, dynamic> json) {
  return _MyTimeOfDay.fromJson(json);
}

/// @nodoc
mixin _$MyTimeOfDay {
  @HiveField(0)
  int get hour => throw _privateConstructorUsedError;
  @HiveField(1)
  int get minute => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyTimeOfDayCopyWith<MyTimeOfDay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyTimeOfDayCopyWith<$Res> {
  factory $MyTimeOfDayCopyWith(
          MyTimeOfDay value, $Res Function(MyTimeOfDay) then) =
      _$MyTimeOfDayCopyWithImpl<$Res, MyTimeOfDay>;
  @useResult
  $Res call({@HiveField(0) int hour, @HiveField(1) int minute});
}

/// @nodoc
class _$MyTimeOfDayCopyWithImpl<$Res, $Val extends MyTimeOfDay>
    implements $MyTimeOfDayCopyWith<$Res> {
  _$MyTimeOfDayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? minute = null,
  }) {
    return _then(_value.copyWith(
      hour: null == hour
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      minute: null == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyTimeOfDayImplCopyWith<$Res>
    implements $MyTimeOfDayCopyWith<$Res> {
  factory _$$MyTimeOfDayImplCopyWith(
          _$MyTimeOfDayImpl value, $Res Function(_$MyTimeOfDayImpl) then) =
      __$$MyTimeOfDayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) int hour, @HiveField(1) int minute});
}

/// @nodoc
class __$$MyTimeOfDayImplCopyWithImpl<$Res>
    extends _$MyTimeOfDayCopyWithImpl<$Res, _$MyTimeOfDayImpl>
    implements _$$MyTimeOfDayImplCopyWith<$Res> {
  __$$MyTimeOfDayImplCopyWithImpl(
      _$MyTimeOfDayImpl _value, $Res Function(_$MyTimeOfDayImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? minute = null,
  }) {
    return _then(_$MyTimeOfDayImpl(
      hour: null == hour
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      minute: null == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MyTimeOfDayImpl implements _MyTimeOfDay {
  _$MyTimeOfDayImpl(
      {@HiveField(0) this.hour = 0, @HiveField(1) this.minute = 0});

  factory _$MyTimeOfDayImpl.fromJson(Map<String, dynamic> json) =>
      _$$MyTimeOfDayImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final int hour;
  @override
  @JsonKey()
  @HiveField(1)
  final int minute;

  @override
  String toString() {
    return 'MyTimeOfDay(hour: $hour, minute: $minute)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyTimeOfDayImpl &&
            (identical(other.hour, hour) || other.hour == hour) &&
            (identical(other.minute, minute) || other.minute == minute));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, hour, minute);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyTimeOfDayImplCopyWith<_$MyTimeOfDayImpl> get copyWith =>
      __$$MyTimeOfDayImplCopyWithImpl<_$MyTimeOfDayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MyTimeOfDayImplToJson(
      this,
    );
  }
}

abstract class _MyTimeOfDay implements MyTimeOfDay {
  factory _MyTimeOfDay(
      {@HiveField(0) final int hour,
      @HiveField(1) final int minute}) = _$MyTimeOfDayImpl;

  factory _MyTimeOfDay.fromJson(Map<String, dynamic> json) =
      _$MyTimeOfDayImpl.fromJson;

  @override
  @HiveField(0)
  int get hour;
  @override
  @HiveField(1)
  int get minute;
  @override
  @JsonKey(ignore: true)
  _$$MyTimeOfDayImplCopyWith<_$MyTimeOfDayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
