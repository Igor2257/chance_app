import 'package:chance_app/ux/model/hive_type_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'sos_contact_model.freezed.dart';
part 'sos_contact_model.g.dart';

@freezed
@HiveType(typeId: HiveTypeId.sosContactModel)
class SosContactModel with _$SosContactModel {
  const factory SosContactModel({
    @HiveField(1) required String name,
    @HiveField(2) required String phone,
    @HiveField(3) @Default("") String? groupName,
  }) = _SosContactModel;

  factory SosContactModel.fromJson(Map<String, dynamic> json) =>
      _$SosContactModelFromJson(json);
}
