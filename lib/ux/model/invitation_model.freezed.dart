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
  String get email => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime? get sentDate => throw _privateConstructorUsedError;
  @HiveField(3)
  String get fromUserId => throw _privateConstructorUsedError;
  @HiveField(4)
  String get toUserId => throw _privateConstructorUsedError;
  @HiveField(5)
  InvitationStatus get invitationStatus => throw _privateConstructorUsedError;
  @HiveField(6)
  String get fromUserName => throw _privateConstructorUsedError;

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
      @HiveField(1) String email,
      @HiveField(2) DateTime? sentDate,
      @HiveField(3) String fromUserId,
      @HiveField(4) String toUserId,
      @HiveField(5) InvitationStatus invitationStatus,
      @HiveField(6) String fromUserName});
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
    Object? email = null,
    Object? sentDate = freezed,
    Object? fromUserId = null,
    Object? toUserId = null,
    Object? invitationStatus = null,
    Object? fromUserName = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      sentDate: freezed == sentDate
          ? _value.sentDate
          : sentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fromUserId: null == fromUserId
          ? _value.fromUserId
          : fromUserId // ignore: cast_nullable_to_non_nullable
              as String,
      toUserId: null == toUserId
          ? _value.toUserId
          : toUserId // ignore: cast_nullable_to_non_nullable
              as String,
      invitationStatus: null == invitationStatus
          ? _value.invitationStatus
          : invitationStatus // ignore: cast_nullable_to_non_nullable
              as InvitationStatus,
      fromUserName: null == fromUserName
          ? _value.fromUserName
          : fromUserName // ignore: cast_nullable_to_non_nullable
              as String,
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
      @HiveField(1) String email,
      @HiveField(2) DateTime? sentDate,
      @HiveField(3) String fromUserId,
      @HiveField(4) String toUserId,
      @HiveField(5) InvitationStatus invitationStatus,
      @HiveField(6) String fromUserName});
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
    Object? email = null,
    Object? sentDate = freezed,
    Object? fromUserId = null,
    Object? toUserId = null,
    Object? invitationStatus = null,
    Object? fromUserName = null,
  }) {
    return _then(_$InvitationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      sentDate: freezed == sentDate
          ? _value.sentDate
          : sentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fromUserId: null == fromUserId
          ? _value.fromUserId
          : fromUserId // ignore: cast_nullable_to_non_nullable
              as String,
      toUserId: null == toUserId
          ? _value.toUserId
          : toUserId // ignore: cast_nullable_to_non_nullable
              as String,
      invitationStatus: null == invitationStatus
          ? _value.invitationStatus
          : invitationStatus // ignore: cast_nullable_to_non_nullable
              as InvitationStatus,
      fromUserName: null == fromUserName
          ? _value.fromUserName
          : fromUserName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvitationModelImpl implements _InvitationModel {
  const _$InvitationModelImpl(
      {@HiveField(0) this.id = "",
      @HiveField(1) this.email = "",
      @HiveField(2) this.sentDate = null,
      @HiveField(3) this.fromUserId = "",
      @HiveField(4) this.toUserId = "",
      @HiveField(5) this.invitationStatus = InvitationStatus.pending,
      @HiveField(6) this.fromUserName = ""});

  factory _$InvitationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvitationModelImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final String id;
  @override
  @JsonKey()
  @HiveField(1)
  final String email;
  @override
  @JsonKey()
  @HiveField(2)
  final DateTime? sentDate;
  @override
  @JsonKey()
  @HiveField(3)
  final String fromUserId;
  @override
  @JsonKey()
  @HiveField(4)
  final String toUserId;
  @override
  @JsonKey()
  @HiveField(5)
  final InvitationStatus invitationStatus;
  @override
  @JsonKey()
  @HiveField(6)
  final String fromUserName;

  @override
  String toString() {
    return 'InvitationModel(id: $id, email: $email, sentDate: $sentDate, fromUserId: $fromUserId, toUserId: $toUserId, invitationStatus: $invitationStatus, fromUserName: $fromUserName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.sentDate, sentDate) ||
                other.sentDate == sentDate) &&
            (identical(other.fromUserId, fromUserId) ||
                other.fromUserId == fromUserId) &&
            (identical(other.toUserId, toUserId) ||
                other.toUserId == toUserId) &&
            (identical(other.invitationStatus, invitationStatus) ||
                other.invitationStatus == invitationStatus) &&
            (identical(other.fromUserName, fromUserName) ||
                other.fromUserName == fromUserName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, email, sentDate, fromUserId,
      toUserId, invitationStatus, fromUserName);

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
      @HiveField(1) final String email,
      @HiveField(2) final DateTime? sentDate,
      @HiveField(3) final String fromUserId,
      @HiveField(4) final String toUserId,
      @HiveField(5) final InvitationStatus invitationStatus,
      @HiveField(6) final String fromUserName}) = _$InvitationModelImpl;

  factory _InvitationModel.fromJson(Map<String, dynamic> json) =
      _$InvitationModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get email;
  @override
  @HiveField(2)
  DateTime? get sentDate;
  @override
  @HiveField(3)
  String get fromUserId;
  @override
  @HiveField(4)
  String get toUserId;
  @override
  @HiveField(5)
  InvitationStatus get invitationStatus;
  @override
  @HiveField(6)
  String get fromUserName;
  @override
  @JsonKey(ignore: true)
  _$$InvitationModelImplCopyWith<_$InvitationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
