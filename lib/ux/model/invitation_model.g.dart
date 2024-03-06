// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InvitationModelAdapter extends TypeAdapter<InvitationModel> {
  @override
  final int typeId = 6;

  @override
  InvitationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InvitationModel(
      id: fields[0] as String,
      email: fields[1] as String,
      sentDate: fields[2] as DateTime?,
      fromUserId: fields[3] as String,
      toUserId: fields[4] as String,
      invitationStatus: fields[5] as InvitationStatus,
      fromUserName: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, InvitationModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.sentDate)
      ..writeByte(3)
      ..write(obj.fromUserId)
      ..writeByte(4)
      ..write(obj.toUserId)
      ..writeByte(5)
      ..write(obj.invitationStatus)
      ..writeByte(6)
      ..write(obj.fromUserName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvitationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvitationModelImpl _$$InvitationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$InvitationModelImpl(
      id: json['id'] as String? ?? "",
      email: json['email'] as String? ?? "",
      sentDate: json['sentDate'] == null
          ? null
          : DateTime.parse(json['sentDate'] as String),
      fromUserId: json['fromUserId'] as String? ?? "",
      toUserId: json['toUserId'] as String? ?? "",
      invitationStatus: $enumDecodeNullable(
              _$InvitationStatusEnumMap, json['invitationStatus']) ??
          InvitationStatus.pending,
      fromUserName: json['fromUserName'] as String? ?? "",
    );

Map<String, dynamic> _$$InvitationModelImplToJson(
        _$InvitationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'sentDate': instance.sentDate?.toIso8601String(),
      'fromUserId': instance.fromUserId,
      'toUserId': instance.toUserId,
      'invitationStatus': _$InvitationStatusEnumMap[instance.invitationStatus]!,
      'fromUserName': instance.fromUserName,
    };

const _$InvitationStatusEnumMap = {
  InvitationStatus.pending: 'pending',
  InvitationStatus.accepted: 'accepted',
  InvitationStatus.error: 'error',
  InvitationStatus.canceled: 'canceled',
};
