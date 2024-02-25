import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'my_time_of_day.freezed.dart';

part 'my_time_of_day.g.dart';

@freezed
@HiveType(typeId: 3)
class MyTimeOfDay with _$MyTimeOfDay {
  factory MyTimeOfDay({
    @HiveField(0) @Default(0) int hour,
    @HiveField(1) @Default(0) int minute,
  
  }) = _MyTimeOfDay;
  /// The number of hours in one day, i.e. 24.
  static const int hoursPerDay = 24;

  /// The number of hours in one day period (see also [DayPeriod]), i.e. 12.
  static const int hoursPerPeriod = 12;

  /// The number of minutes in one hour, i.e. 60.
  static const int minutesPerHour = 60;
  factory MyTimeOfDay.fromJson(Map<String, dynamic> json) =>
      _$MyTimeOfDayFromJson(json);
}
