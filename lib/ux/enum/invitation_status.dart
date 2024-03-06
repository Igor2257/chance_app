import 'package:chance_app/ux/model/hive_type_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'invitation_status.g.dart';

@JsonEnum()
@HiveType(typeId: HiveTypeId.invitationStatusId)
enum InvitationStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  accepted,
  @HiveField(2)
  error,
  @HiveField(3)
  canceled;

  String toLocalizedString() {
    switch (this) {
      case InvitationStatus.pending:
        return "В очікуванні";
      case InvitationStatus.accepted:
        return "Прийнято";
      case InvitationStatus.error:
        return "Помилка";
      case InvitationStatus.canceled:
        return "Відмінено";
    }
  }
}
