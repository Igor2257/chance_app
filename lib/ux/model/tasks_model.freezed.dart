// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) {
  return _TaskModel.fromJson(json);
}

/// @nodoc
mixin _$TaskModel {
  @HiveField(0)
  int get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime? get taskTo => throw _privateConstructorUsedError;
  @HiveField(4)
  NotificationsBefore get notificationsBefore =>
      throw _privateConstructorUsedError;
  @HiveField(5)
  bool get isDone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskModelCopyWith<TaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskModelCopyWith<$Res> {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) then) =
      _$TaskModelCopyWithImpl<$Res, TaskModel>;
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) String name,
      @HiveField(2) DateTime createdAt,
      @HiveField(3) DateTime? taskTo,
      @HiveField(4) NotificationsBefore notificationsBefore,
      @HiveField(5) bool isDone});
}

/// @nodoc
class _$TaskModelCopyWithImpl<$Res, $Val extends TaskModel>
    implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? taskTo = freezed,
    Object? notificationsBefore = null,
    Object? isDone = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      taskTo: freezed == taskTo
          ? _value.taskTo
          : taskTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notificationsBefore: null == notificationsBefore
          ? _value.notificationsBefore
          : notificationsBefore // ignore: cast_nullable_to_non_nullable
              as NotificationsBefore,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskModelImplCopyWith<$Res>
    implements $TaskModelCopyWith<$Res> {
  factory _$$TaskModelImplCopyWith(
          _$TaskModelImpl value, $Res Function(_$TaskModelImpl) then) =
      __$$TaskModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) String name,
      @HiveField(2) DateTime createdAt,
      @HiveField(3) DateTime? taskTo,
      @HiveField(4) NotificationsBefore notificationsBefore,
      @HiveField(5) bool isDone});
}

/// @nodoc
class __$$TaskModelImplCopyWithImpl<$Res>
    extends _$TaskModelCopyWithImpl<$Res, _$TaskModelImpl>
    implements _$$TaskModelImplCopyWith<$Res> {
  __$$TaskModelImplCopyWithImpl(
      _$TaskModelImpl _value, $Res Function(_$TaskModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? taskTo = freezed,
    Object? notificationsBefore = null,
    Object? isDone = null,
  }) {
    return _then(_$TaskModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      taskTo: freezed == taskTo
          ? _value.taskTo
          : taskTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notificationsBefore: null == notificationsBefore
          ? _value.notificationsBefore
          : notificationsBefore // ignore: cast_nullable_to_non_nullable
              as NotificationsBefore,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskModelImpl implements _TaskModel {
  _$TaskModelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) this.name = "",
      @HiveField(2) required this.createdAt,
      @HiveField(3) this.taskTo = null,
      @HiveField(4) this.notificationsBefore = NotificationsBefore.no,
      @HiveField(5) this.isDone = false});

  factory _$TaskModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskModelImplFromJson(json);

  @override
  @HiveField(0)
  final int id;
  @override
  @JsonKey()
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final DateTime createdAt;
  @override
  @JsonKey()
  @HiveField(3)
  final DateTime? taskTo;
  @override
  @JsonKey()
  @HiveField(4)
  final NotificationsBefore notificationsBefore;
  @override
  @JsonKey()
  @HiveField(5)
  final bool isDone;

  @override
  String toString() {
    return 'TaskModel(id: $id, name: $name, createdAt: $createdAt, taskTo: $taskTo, notificationsBefore: $notificationsBefore, isDone: $isDone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.taskTo, taskTo) || other.taskTo == taskTo) &&
            (identical(other.notificationsBefore, notificationsBefore) ||
                other.notificationsBefore == notificationsBefore) &&
            (identical(other.isDone, isDone) || other.isDone == isDone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, createdAt, taskTo, notificationsBefore, isDone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      __$$TaskModelImplCopyWithImpl<_$TaskModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskModelImplToJson(
      this,
    );
  }
}

abstract class _TaskModel implements TaskModel {
  factory _TaskModel(
      {@HiveField(0) required final int id,
      @HiveField(1) final String name,
      @HiveField(2) required final DateTime createdAt,
      @HiveField(3) final DateTime? taskTo,
      @HiveField(4) final NotificationsBefore notificationsBefore,
      @HiveField(5) final bool isDone}) = _$TaskModelImpl;

  factory _TaskModel.fromJson(Map<String, dynamic> json) =
      _$TaskModelImpl.fromJson;

  @override
  @HiveField(0)
  int get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  DateTime get createdAt;
  @override
  @HiveField(3)
  DateTime? get taskTo;
  @override
  @HiveField(4)
  NotificationsBefore get notificationsBefore;
  @override
  @HiveField(5)
  bool get isDone;
  @override
  @JsonKey(ignore: true)
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
