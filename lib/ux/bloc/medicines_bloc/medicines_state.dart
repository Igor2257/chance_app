part of 'medicines_bloc.dart';

@freezed
class MedicinesState with _$MedicinesState {
  const factory MedicinesState({
    @Default('') String name,
    MedicineType? type,
    Periodicity? periodicity,
    // DayPeriodicity? dayPeriodicity,
    DateTime? startDate,
    @Default({}) Set<int> weekdays,
    @Default({}) Map<TimeOfDay, int> doses,
    MedicineInstruction? instruction,
    @Default(false) bool isSaving,
    @Default(false) bool created,
  }) = _State;
}
