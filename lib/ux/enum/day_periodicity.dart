import 'package:chance_app/ux/model/hive_type_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'day_periodicity.g.dart';

@JsonEnum()
@HiveType(typeId: HiveTypeId.dayPeriodicity)
enum DayPeriodicity {
  @HiveField(0)
  once,
  @HiveField(1)
  twice,
  @HiveField(2)
  other;

  String toLocalizedString() {
    switch (this) {
      case DayPeriodicity.once:
        return "Раз на день";
      case DayPeriodicity.twice:
        return "Двічі на день";
      case DayPeriodicity.other:
        return "Частіше";
    }
  }
}
