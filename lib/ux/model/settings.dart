import 'package:chance_app/ux/model/hive_type_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
@HiveType(typeId: HiveTypeId.settingsModel)
class Settings with _$Settings {
  const factory Settings({
    @HiveField(0) @Default(false) bool blockAd,
    @HiveField(1) @Default(true) bool soundsOn,
    @HiveField(2) @Default(null) DateTime? firstEnter,
    @HiveField(3) @Default(false) bool? isNotificationEnable,
    @HiveField(4) @Default(null) String? language,
    @HiveField(5) @Default(null) String? languageCode,
  }) = _Settings;

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);
}
