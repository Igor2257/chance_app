// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invitation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InvitationModel _$InvitationModelFromJson(Map<String, dynamic> json) {
  return _InvitationModel.fromJson(json);
}

/// @nodoc
mixin _$InvitationModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get toUserEmail => throw _privateConstructorUsedError;
  @HiveField(2)
  String get toUserName => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime? get sentDate => throw _privateConstructorUsedError;
  @HiveField(4)
  String get fromUserId => throw _privateConstructorUsedError;
  @HiveField(5)
  InvitationStatus get invitationStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvitationModelCopyWith<InvitationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitationModelCopyWith<$Res> {
  factory $InvitationModelCopyWith(
          InvitationModel value, $Res Function(InvitationModel) then) =
      _$InvitationModelCopyWithImpl<$Res, InvitationModel>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String toUserEmail,
      @HiveField(2) String toUserName,
      @HiveField(3) DateTime? sentDate,
      @HiveField(4) String fromUserId,
      @HiveField(5) InvitationStatus invitationStatus});
}

/// @nodoc
class _$InvitationModelCopyWithImpl<$Res, $Val extends InvitationModel>
    implements $InvitationModelCopyWith<$Res> {
  _$InvitationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? toUserEmail = null,
    Object? toUserName = null,
    Object? sentDate = freezed,
    Object? fromUserId = null,
    Object? invitationStatus = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      toUserEmail: null == toUserEmail
          ? _value.toUserEmail
          : toUserEmail // ignore: cast_nullable_to_non_nullable
              as String,
      toUserName: null == toUserName
          ? _value.toUserName
          : toUserName // ignore: cast_nullable_to_non_nullable
              as String,
      sentDate: freezed == sentDate
          ? _value.sentDate
          : sentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fromUserId: null == fromUserId
          ? _value.fromUserId
          : fromUserId // ignore: cast_nullable_to_non_nullable
              as String,
      invitationStatus: null == invitationStatus
          ? _value.invitationStatus
          : invitationStatus // ignore: cast_nullable_to_non_nullable
              as InvitationStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvitationModelImplCopyWith<$Res>
    implements $InvitationModelCopyWith<$Res> {
  factory _$$InvitationModelImplCopyWith(_$InvitationModelImpl value,
          $Res Function(_$InvitationModelImpl) then) =
      __$$InvitationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String toUserEmail,
      @HiveField(2) String toUserName,
      @HiveField(3) DateTime? sentDate,
      @HiveField(4) String fromUserId,
      @HiveField(5) InvitationStatus invitationStatus});
}

/// @nodoc
class __$$InvitationModelImplCopyWithImpl<$Res>
    extends _$InvitationModelCopyWithImpl<$Res, _$InvitationModelImpl>
    implements _$$InvitationModelImplCopyWith<$Res> {
  __$$InvitationModelImplCopyWithImpl(
      _$InvitationModelImpl _value, $Res Function(_$InvitationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? toUserEmail = null,
    Object? toUserName = null,
    Object? sentDate = freezed,
    Object? fromUserId = null,
    Object? invitationStatus = null,
  }) {
    return _then(_$InvitationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      toUserEmail: null == toUserEmail
          ? _value.toUserEmail
          : toUserEmail // ignore: cast_nullable_to_non_nullable
              as String,
      toUserName: null == toUserName
          ? _value.toUserName
          : toUserName // ignore: cast_nullable_to_non_nullable
              as String,
      sentDate: freezed == sentDate
          ? _value.sentDate
          : sentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fromUserId: null == fromUserId
          ? _value.fromUserId
          : fromUserId // ignore: cast_nullable_to_non_nullable
              as String,
      invitationStatus: null == invitationStatus
          ? _value.invitationStatus
          : invitationStatus // ignore: cast_nullable_to_non_nullable
              as InvitationStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvitationModelImpl implements _InvitationModel {
  const _$InvitationModelImpl(
      {@HiveField(0) this.id = "",
      @HiveField(1) this.toUserEmail = "",
      @HiveField(2) this.toUserName = "",
      @HiveField(3) this.sentDate = null,
      @HiveField(4) this.fromUserId = "",
      @HiveField(5) this.invitationStatus = InvitationStatus.pending});

  factory _$InvitationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvitationModelImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final String id;
  @override
  @JsonKey()
  @HiveField(1)
  final String toUserEmail;
  @override
  @JsonKey()
  @HiveField(2)
  final String toUserName;
  @override
  @JsonKey()
  @HiveField(3)
  final DateTime? sentDate;
  @override
  @JsonKey()
  @HiveField(4)
  final String fromUserId;
  @override
  @JsonKey()
  @HiveField(5)
  final InvitationStatus invitationStatus;

  @override
  String toString() {
    return 'InvitationModel(id: $id, toUserEmail: $toUserEmail, toUserName: $toUserName, sentDate: $sentDate, fromUserId: $fromUserId, invitationStatus: $invitationStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.toUserEmail, toUserEmail) ||
                other.toUserEmail == toUserEmail) &&
            (identical(other.toUserName, toUserName) ||
                other.toUserName == toUserName) &&
            (identical(other.sentDate, sentDate) ||
                other.sentDate == sentDate) &&
            (identical(other.fromUserId, fromUserId) ||
                other.fromUserId == fromUserId) &&
            (identical(other.invitationStatus, invitationStatus) ||
                other.invitationStatus == invitationStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, toUserEmail, toUserName,
      sentDate, fromUserId, invitationStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvitationModelImplCopyWith<_$InvitationModelImpl> get copyWith =>
      __$$InvitationModelImplCopyWithImpl<_$InvitationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvitationModelImplToJson(
      this,
    );
  }
}

abstract class _InvitationModel implements InvitationModel {
  const factory _InvitationModel(
          {@HiveField(0) final String id,
          @HiveField(1) final String toUserEmail,
          @HiveField(2) final String toUserName,
          @HiveField(3) final DateTime? sentDate,
          @HiveField(4) final String fromUserId,
          @HiveField(5) final InvitationStatus invitationStatus}) =
      _$InvitationModelImpl;

  factory _InvitationModel.fromJson(Map<String, dynamic> json) =
      _$InvitationModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get toUserEmail;
  @override
  @HiveField(2)
  String get toUserName;
  @override
  @HiveField(3)
  DateTime? get sentDate;
  @override
  @HiveField(4)
  String get fromUserId;
  @override
  @HiveField(5)
  InvitationStatus get invitationStatus;
  @override
  @JsonKey(ignore: true)
  _$$InvitationModelImplCopyWith<_$InvitationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
