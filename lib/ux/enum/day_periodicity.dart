import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum DayPeriodicity {
  once,
  twice,
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
