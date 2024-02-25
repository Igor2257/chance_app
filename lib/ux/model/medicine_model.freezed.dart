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
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get message => throw _privateConstructorUsedError;
  @HiveField(2)
  String get medicineType => throw _privateConstructorUsedError;
  @HiveField(3)
  String get periodicity => throw _privateConstructorUsedError;
  @HiveField(4)
  String get medicineInstruction => throw _privateConstructorUsedError;
  @HiveField(5)
  List<int> get weekdays => throw _privateConstructorUsedError;
  @HiveField(6)
  Map<MyTimeOfDay, int> get doses => throw _privateConstructorUsedError;
  @HiveField(7)
  DateTime? get startDate =>
      throw _privateConstructorUsedError; //@HiveField(3) @Default("no") String notificationsBefore,
  @HiveField(8)
  bool get isDone => throw _privateConstructorUsedError;
  @HiveField(9)
  String get userId => throw _privateConstructorUsedError;
  @HiveField(10)
  bool get isNotificationSent => throw _privateConstructorUsedError;
  @HiveField(11)
  bool get isSentToDB => throw _privateConstructorUsedError;
  @HiveField(12)
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
      {@HiveField(0) String id,
      @HiveField(1) String message,
      @HiveField(2) String medicineType,
      @HiveField(3) String periodicity,
      @HiveField(4) String medicineInstruction,
      @HiveField(5) List<int> weekdays,
      @HiveField(6) Map<MyTimeOfDay, int> doses,
      @HiveField(7) DateTime? startDate,
      @HiveField(8) bool isDone,
      @HiveField(9) String userId,
      @HiveField(10) bool isNotificationSent,
      @HiveField(11) bool isSentToDB,
      @HiveField(12) bool isRemoved});
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
    Object? message = null,
    Object? medicineType = null,
    Object? periodicity = null,
    Object? medicineInstruction = null,
    Object? weekdays = null,
    Object? doses = null,
    Object? startDate = freezed,
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
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      medicineType: null == medicineType
          ? _value.medicineType
          : medicineType // ignore: cast_nullable_to_non_nullable
              as String,
      periodicity: null == periodicity
          ? _value.periodicity
          : periodicity // ignore: cast_nullable_to_non_nullable
              as String,
      medicineInstruction: null == medicineInstruction
          ? _value.medicineInstruction
          : medicineInstruction // ignore: cast_nullable_to_non_nullable
              as String,
      weekdays: null == weekdays
          ? _value.weekdays
          : weekdays // ignore: cast_nullable_to_non_nullable
              as List<int>,
      doses: null == doses
          ? _value.doses
          : doses // ignore: cast_nullable_to_non_nullable
              as Map<MyTimeOfDay, int>,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      {@HiveField(0) String id,
      @HiveField(1) String message,
      @HiveField(2) String medicineType,
      @HiveField(3) String periodicity,
      @HiveField(4) String medicineInstruction,
      @HiveField(5) List<int> weekdays,
      @HiveField(6) Map<MyTimeOfDay, int> doses,
      @HiveField(7) DateTime? startDate,
      @HiveField(8) bool isDone,
      @HiveField(9) String userId,
      @HiveField(10) bool isNotificationSent,
      @HiveField(11) bool isSentToDB,
      @HiveField(12) bool isRemoved});
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
    Object? message = null,
    Object? medicineType = null,
    Object? periodicity = null,
    Object? medicineInstruction = null,
    Object? weekdays = null,
    Object? doses = null,
    Object? startDate = freezed,
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
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      medicineType: null == medicineType
          ? _value.medicineType
          : medicineType // ignore: cast_nullable_to_non_nullable
              as String,
      periodicity: null == periodicity
          ? _value.periodicity
          : periodicity // ignore: cast_nullable_to_non_nullable
              as String,
      medicineInstruction: null == medicineInstruction
          ? _value.medicineInstruction
          : medicineInstruction // ignore: cast_nullable_to_non_nullable
              as String,
      weekdays: null == weekdays
          ? _value._weekdays
          : weekdays // ignore: cast_nullable_to_non_nullable
              as List<int>,
      doses: null == doses
          ? _value._doses
          : doses // ignore: cast_nullable_to_non_nullable
              as Map<MyTimeOfDay, int>,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      {@HiveField(0) this.id = "",
      @HiveField(1) this.message = "",
      @HiveField(2) this.medicineType = "",
      @HiveField(3) this.periodicity = "",
      @HiveField(4) this.medicineInstruction = "",
      @HiveField(5) final List<int> weekdays = const [],
      @HiveField(6) final Map<MyTimeOfDay, int> doses = const {},
      @HiveField(7) this.startDate = null,
      @HiveField(8) this.isDone = false,
      @HiveField(9) this.userId = "",
      @HiveField(10) this.isNotificationSent = false,
      @HiveField(11) this.isSentToDB = false,
      @HiveField(12) this.isRemoved = false})
      : _weekdays = weekdays,
        _doses = doses;

  factory _$MedicineModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicineModelImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final String id;
  @override
  @JsonKey()
  @HiveField(1)
  final String message;
  @override
  @JsonKey()
  @HiveField(2)
  final String medicineType;
  @override
  @JsonKey()
  @HiveField(3)
  final String periodicity;
  @override
  @JsonKey()
  @HiveField(4)
  final String medicineInstruction;
  final List<int> _weekdays;
  @override
  @JsonKey()
  @HiveField(5)
  List<int> get weekdays {
    if (_weekdays is EqualUnmodifiableListView) return _weekdays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weekdays);
  }

  final Map<MyTimeOfDay, int> _doses;
  @override
  @JsonKey()
  @HiveField(6)
  Map<MyTimeOfDay, int> get doses {
    if (_doses is EqualUnmodifiableMapView) return _doses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_doses);
  }

  @override
  @JsonKey()
  @HiveField(7)
  final DateTime? startDate;
//@HiveField(3) @Default("no") String notificationsBefore,
  @override
  @JsonKey()
  @HiveField(8)
  final bool isDone;
  @override
  @JsonKey()
  @HiveField(9)
  final String userId;
  @override
  @JsonKey()
  @HiveField(10)
  final bool isNotificationSent;
  @override
  @JsonKey()
  @HiveField(11)
  final bool isSentToDB;
  @override
  @JsonKey()
  @HiveField(12)
  final bool isRemoved;

  @override
  String toString() {
    return 'MedicineModel(id: $id, message: $message, medicineType: $medicineType, periodicity: $periodicity, medicineInstruction: $medicineInstruction, weekdays: $weekdays, doses: $doses, startDate: $startDate, isDone: $isDone, userId: $userId, isNotificationSent: $isNotificationSent, isSentToDB: $isSentToDB, isRemoved: $isRemoved)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicineModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.medicineType, medicineType) ||
                other.medicineType == medicineType) &&
            (identical(other.periodicity, periodicity) ||
                other.periodicity == periodicity) &&
            (identical(other.medicineInstruction, medicineInstruction) ||
                other.medicineInstruction == medicineInstruction) &&
            const DeepCollectionEquality().equals(other._weekdays, _weekdays) &&
            const DeepCollectionEquality().equals(other._doses, _doses) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
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
      message,
      medicineType,
      periodicity,
      medicineInstruction,
      const DeepCollectionEquality().hash(_weekdays),
      const DeepCollectionEquality().hash(_doses),
      startDate,
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
      {@HiveField(0) final String id,
      @HiveField(1) final String message,
      @HiveField(2) final String medicineType,
      @HiveField(3) final String periodicity,
      @HiveField(4) final String medicineInstruction,
      @HiveField(5) final List<int> weekdays,
      @HiveField(6) final Map<MyTimeOfDay, int> doses,
      @HiveField(7) final DateTime? startDate,
      @HiveField(8) final bool isDone,
      @HiveField(9) final String userId,
      @HiveField(10) final bool isNotificationSent,
      @HiveField(11) final bool isSentToDB,
      @HiveField(12) final bool isRemoved}) = _$MedicineModelImpl;

  factory _MedicineModel.fromJson(Map<String, dynamic> json) =
      _$MedicineModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get message;
  @override
  @HiveField(2)
  String get medicineType;
  @override
  @HiveField(3)
  String get periodicity;
  @override
  @HiveField(4)
  String get medicineInstruction;
  @override
  @HiveField(5)
  List<int> get weekdays;
  @override
  @HiveField(6)
  Map<MyTimeOfDay, int> get doses;
  @override
  @HiveField(7)
  DateTime? get startDate;
  @override //@HiveField(3) @Default("no") String notificationsBefore,
  @HiveField(8)
  bool get isDone;
  @override
  @HiveField(9)
  String get userId;
  @override
  @HiveField(10)
  bool get isNotificationSent;
  @override
  @HiveField(11)
  bool get isSentToDB;
  @override
  @HiveField(12)
  bool get isRemoved;
  @override
  @JsonKey(ignore: true)
  _$$MedicineModelImplCopyWith<_$MedicineModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
