// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medicine_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MedicineModel _$MedicineModelFromJson(Map<String, dynamic> json) {
  return _MedicineModel.fromJson(json);
}

/// @nodoc
mixin _$MedicineModel {
  @HiveField(0)
  int get id => throw _privateConstructorUsedError;
  @HiveField(1)
  List<int> get reminderIds => throw _privateConstructorUsedError;
  @HiveField(2)
  String get name => throw _privateConstructorUsedError;
  @HiveField(3)
  MedicineType get type => throw _privateConstructorUsedError;
  @HiveField(4)
  Periodicity get periodicity => throw _privateConstructorUsedError;
  @HiveField(5)
  DateTime get startDate => throw _privateConstructorUsedError;
  @HiveField(6)
  List<int> get weekdays => throw _privateConstructorUsedError;
  @HiveField(7)
  Map<int, int> get doses => throw _privateConstructorUsedError;
  @HiveField(8)
  MedicineInstruction? get instruction =>
      throw _privateConstructorUsedError; //@HiveField(3) @Default("no") String notificationsBefore,
  @HiveField(9)
  bool get isDone => throw _privateConstructorUsedError;
  @HiveField(10)
  String get userId => throw _privateConstructorUsedError;
  @HiveField(11)
  bool get isNotificationSent => throw _privateConstructorUsedError;
  @HiveField(12)
  bool get isSentToDB => throw _privateConstructorUsedError;
  @HiveField(13)
  bool get isRemoved => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MedicineModelCopyWith<MedicineModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicineModelCopyWith<$Res> {
  factory $MedicineModelCopyWith(
          MedicineModel value, $Res Function(MedicineModel) then) =
      _$MedicineModelCopyWithImpl<$Res, MedicineModel>;
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) List<int> reminderIds,
      @HiveField(2) String name,
      @HiveField(3) MedicineType type,
      @HiveField(4) Periodicity periodicity,
      @HiveField(5) DateTime startDate,
      @HiveField(6) List<int> weekdays,
      @HiveField(7) Map<int, int> doses,
      @HiveField(8) MedicineInstruction? instruction,
      @HiveField(9) bool isDone,
      @HiveField(10) String userId,
      @HiveField(11) bool isNotificationSent,
      @HiveField(12) bool isSentToDB,
      @HiveField(13) bool isRemoved});
}

/// @nodoc
class _$MedicineModelCopyWithImpl<$Res, $Val extends MedicineModel>
    implements $MedicineModelCopyWith<$Res> {
  _$MedicineModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reminderIds = null,
    Object? name = null,
    Object? type = null,
    Object? periodicity = null,
    Object? startDate = null,
    Object? weekdays = null,
    Object? doses = null,
    Object? instruction = freezed,
    Object? isDone = null,
    Object? userId = null,
    Object? isNotificationSent = null,
    Object? isSentToDB = null,
    Object? isRemoved = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      reminderIds: null == reminderIds
          ? _value.reminderIds
          : reminderIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MedicineType,
      periodicity: null == periodicity
          ? _value.periodicity
          : periodicity // ignore: cast_nullable_to_non_nullable
              as Periodicity,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weekdays: null == weekdays
          ? _value.weekdays
          : weekdays // ignore: cast_nullable_to_non_nullable
              as List<int>,
      doses: null == doses
          ? _value.doses
          : doses // ignore: cast_nullable_to_non_nullable
              as Map<int, int>,
      instruction: freezed == instruction
          ? _value.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as MedicineInstruction?,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      isNotificationSent: null == isNotificationSent
          ? _value.isNotificationSent
          : isNotificationSent // ignore: cast_nullable_to_non_nullable
              as bool,
      isSentToDB: null == isSentToDB
          ? _value.isSentToDB
          : isSentToDB // ignore: cast_nullable_to_non_nullable
              as bool,
      isRemoved: null == isRemoved
          ? _value.isRemoved
          : isRemoved // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MedicineModelImplCopyWith<$Res>
    implements $MedicineModelCopyWith<$Res> {
  factory _$$MedicineModelImplCopyWith(
          _$MedicineModelImpl value, $Res Function(_$MedicineModelImpl) then) =
      __$$MedicineModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) List<int> reminderIds,
      @HiveField(2) String name,
      @HiveField(3) MedicineType type,
      @HiveField(4) Periodicity periodicity,
      @HiveField(5) DateTime startDate,
      @HiveField(6) List<int> weekdays,
      @HiveField(7) Map<int, int> doses,
      @HiveField(8) MedicineInstruction? instruction,
      @HiveField(9) bool isDone,
      @HiveField(10) String userId,
      @HiveField(11) bool isNotificationSent,
      @HiveField(12) bool isSentToDB,
      @HiveField(13) bool isRemoved});
}

/// @nodoc
class __$$MedicineModelImplCopyWithImpl<$Res>
    extends _$MedicineModelCopyWithImpl<$Res, _$MedicineModelImpl>
    implements _$$MedicineModelImplCopyWith<$Res> {
  __$$MedicineModelImplCopyWithImpl(
      _$MedicineModelImpl _value, $Res Function(_$MedicineModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reminderIds = null,
    Object? name = null,
    Object? type = null,
    Object? periodicity = null,
    Object? startDate = null,
    Object? weekdays = null,
    Object? doses = null,
    Object? instruction = freezed,
    Object? isDone = null,
    Object? userId = null,
    Object? isNotificationSent = null,
    Object? isSentToDB = null,
    Object? isRemoved = null,
  }) {
    return _then(_$MedicineModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      reminderIds: null == reminderIds
          ? _value._reminderIds
          : reminderIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MedicineType,
      periodicity: null == periodicity
          ? _value.periodicity
          : periodicity // ignore: cast_nullable_to_non_nullable
              as Periodicity,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weekdays: null == weekdays
          ? _value._weekdays
          : weekdays // ignore: cast_nullable_to_non_nullable
              as List<int>,
      doses: null == doses
          ? _value._doses
          : doses // ignore: cast_nullable_to_non_nullable
              as Map<int, int>,
      instruction: freezed == instruction
          ? _value.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as MedicineInstruction?,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      isNotificationSent: null == isNotificationSent
          ? _value.isNotificationSent
          : isNotificationSent // ignore: cast_nullable_to_non_nullable
              as bool,
      isSentToDB: null == isSentToDB
          ? _value.isSentToDB
          : isSentToDB // ignore: cast_nullable_to_non_nullable
              as bool,
      isRemoved: null == isRemoved
          ? _value.isRemoved
          : isRemoved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MedicineModelImpl implements _MedicineModel {
  _$MedicineModelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required final List<int> reminderIds,
      @HiveField(2) required this.name,
      @HiveField(3) required this.type,
      @HiveField(4) required this.periodicity,
      @HiveField(5) required this.startDate,
      @HiveField(6) final List<int> weekdays = const [],
      @HiveField(7) final Map<int, int> doses = const {},
      @HiveField(8) this.instruction,
      @HiveField(9) this.isDone = false,
      @HiveField(10) this.userId = "",
      @HiveField(11) this.isNotificationSent = false,
      @HiveField(12) this.isSentToDB = false,
      @HiveField(13) this.isRemoved = false})
      : _reminderIds = reminderIds,
        _weekdays = weekdays,
        _doses = doses;

  factory _$MedicineModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicineModelImplFromJson(json);

  @override
  @HiveField(0)
  final int id;
  final List<int> _reminderIds;
  @override
  @HiveField(1)
  List<int> get reminderIds {
    if (_reminderIds is EqualUnmodifiableListView) return _reminderIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reminderIds);
  }

  @override
  @HiveField(2)
  final String name;
  @override
  @HiveField(3)
  final MedicineType type;
  @override
  @HiveField(4)
  final Periodicity periodicity;
  @override
  @HiveField(5)
  final DateTime startDate;
  final List<int> _weekdays;
  @override
  @JsonKey()
  @HiveField(6)
  List<int> get weekdays {
    if (_weekdays is EqualUnmodifiableListView) return _weekdays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weekdays);
  }

  final Map<int, int> _doses;
  @override
  @JsonKey()
  @HiveField(7)
  Map<int, int> get doses {
    if (_doses is EqualUnmodifiableMapView) return _doses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_doses);
  }

  @override
  @HiveField(8)
  final MedicineInstruction? instruction;
//@HiveField(3) @Default("no") String notificationsBefore,
  @override
  @JsonKey()
  @HiveField(9)
  final bool isDone;
  @override
  @JsonKey()
  @HiveField(10)
  final String userId;
  @override
  @JsonKey()
  @HiveField(11)
  final bool isNotificationSent;
  @override
  @JsonKey()
  @HiveField(12)
  final bool isSentToDB;
  @override
  @JsonKey()
  @HiveField(13)
  final bool isRemoved;

  @override
  String toString() {
    return 'MedicineModel(id: $id, reminderIds: $reminderIds, name: $name, type: $type, periodicity: $periodicity, startDate: $startDate, weekdays: $weekdays, doses: $doses, instruction: $instruction, isDone: $isDone, userId: $userId, isNotificationSent: $isNotificationSent, isSentToDB: $isSentToDB, isRemoved: $isRemoved)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicineModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._reminderIds, _reminderIds) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.periodicity, periodicity) ||
                other.periodicity == periodicity) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            const DeepCollectionEquality().equals(other._weekdays, _weekdays) &&
            const DeepCollectionEquality().equals(other._doses, _doses) &&
            (identical(other.instruction, instruction) ||
                other.instruction == instruction) &&
            (identical(other.isDone, isDone) || other.isDone == isDone) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.isNotificationSent, isNotificationSent) ||
                other.isNotificationSent == isNotificationSent) &&
            (identical(other.isSentToDB, isSentToDB) ||
                other.isSentToDB == isSentToDB) &&
            (identical(other.isRemoved, isRemoved) ||
                other.isRemoved == isRemoved));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_reminderIds),
      name,
      type,
      periodicity,
      startDate,
      const DeepCollectionEquality().hash(_weekdays),
      const DeepCollectionEquality().hash(_doses),
      instruction,
      isDone,
      userId,
      isNotificationSent,
      isSentToDB,
      isRemoved);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicineModelImplCopyWith<_$MedicineModelImpl> get copyWith =>
      __$$MedicineModelImplCopyWithImpl<_$MedicineModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicineModelImplToJson(
      this,
    );
  }
}

abstract class _MedicineModel implements MedicineModel {
  factory _MedicineModel(
      {@HiveField(0) required final int id,
      @HiveField(1) required final List<int> reminderIds,
      @HiveField(2) required final String name,
      @HiveField(3) required final MedicineType type,
      @HiveField(4) required final Periodicity periodicity,
      @HiveField(5) required final DateTime startDate,
      @HiveField(6) final List<int> weekdays,
      @HiveField(7) final Map<int, int> doses,
      @HiveField(8) final MedicineInstruction? instruction,
      @HiveField(9) final bool isDone,
      @HiveField(10) final String userId,
      @HiveField(11) final bool isNotificationSent,
      @HiveField(12) final bool isSentToDB,
      @HiveField(13) final bool isRemoved}) = _$MedicineModelImpl;

  factory _MedicineModel.fromJson(Map<String, dynamic> json) =
      _$MedicineModelImpl.fromJson;

  @override
  @HiveField(0)
  int get id;
  @override
  @HiveField(1)
  List<int> get reminderIds;
  @override
  @HiveField(2)
  String get name;
  @override
  @HiveField(3)
  MedicineType get type;
  @override
  @HiveField(4)
  Periodicity get periodicity;
  @override
  @HiveField(5)
  DateTime get startDate;
  @override
  @HiveField(6)
  List<int> get weekdays;
  @override
  @HiveField(7)
  Map<int, int> get doses;
  @override
  @HiveField(8)
  MedicineInstruction? get instruction;
  @override //@HiveField(3) @Default("no") String notificationsBefore,
  @HiveField(9)
  bool get isDone;
  @override
  @HiveField(10)
  String get userId;
  @override
  @HiveField(11)
  bool get isNotificationSent;
  @override
  @HiveField(12)
  bool get isSentToDB;
  @override
  @HiveField(13)
  bool get isRemoved;
  @override
  @JsonKey(ignore: true)
  _$$MedicineModelImplCopyWith<_$MedicineModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
