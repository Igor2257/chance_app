import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'sos_contact_model.dart';

part 'sos_group_model.freezed.dart';
part 'sos_group_model.g.dart';

@freezed
@HiveType(typeId: 5)
class SosGroupModel with _$SosGroupModel {
  factory SosGroupModel({
    @HiveField(0) @Default("") String id,
    @HiveField(1) required String name,
    @HiveField(2) required List<SosContactModel> contacts,
  }) = _SosGroupModel;

  factory SosGroupModel.fromJson(Map<String, dynamic> json) =>
      _$SosGroupModelFromJson(json);
}
