import 'package:chance_app/ux/model/hive_type_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'periodicity.g.dart';

@JsonEnum()
@HiveType(typeId: HiveTypeId.periodicity)
enum Periodicity {
  @HiveField(0)
  everyDay,
  // @HiveField(1)
  // inADay,
  @HiveField(2)
  certainDays;

  String toLocalizedString() {
    switch (this) {
      case Periodicity.everyDay:
        return "Щодня";
      // case Periodicity.inADay:
      //   return "Кожні 2 дні";
      case Periodicity.certainDays:
        return "Певні дні тижня";
    }
  }
}
