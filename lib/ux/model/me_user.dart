import 'package:chance_app/ux/model/hive_type_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'me_user.freezed.dart';
part 'me_user.g.dart';

@freezed
@HiveType(typeId: HiveTypeId.meUser)
class MeUser with _$MeUser {
  factory MeUser({
    @HiveField(0) required String id,
    @HiveField(1) @Default("") String name,
    @HiveField(2) @Default("") String lastName,
    @HiveField(3) @Default("") String phone,
    @HiveField(4) @Default("") String email,
    @HiveField(5) @Default(false) bool isGoogle,
    @HiveField(6) @Default(false) bool isConfirmed,
    @HiveField(7) @Default("") String deviceId,
    @HiveField(8) @Default(0) int mapType,
  }) = _MeUser;

  factory MeUser.fromJson(Map<String, dynamic> json) => _$MeUserFromJson(json);
}
