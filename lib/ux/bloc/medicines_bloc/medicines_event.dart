part of 'medicines_bloc.dart';

@freezed
class MedicinesEvent with _$MedicinesEvent {
  const factory MedicinesEvent.setName(
    String name,
  ) = SetName;

  const factory MedicinesEvent.setType(
    MedicineType type,
  ) = SetType;

  const factory MedicinesEvent.setPeriodicity(
    Periodicity periodicity,
  ) = SetPeriodicity;

  const factory MedicinesEvent.setDayPeriodicity(
    DayPeriodicity periodicity,
  ) = SetDayPeriodicity;

  const factory MedicinesEvent.setStartDate(
    DateTime startDate,
  ) = SetStartDate;

  const factory MedicinesEvent.addWeekday(
    int weekday,
  ) = AddWeekday;

  const factory MedicinesEvent.removeWeekday(
    int weekday,
  ) = RemoveWeekday;

  const factory MedicinesEvent.addDose(
    TimeOfDay time,
    int count,
  ) = AddDose;

  const factory MedicinesEvent.changeDose({
    required int index,
    TimeOfDay? time,
    int? count,
  }) = ChangeDose;

  const factory MedicinesEvent.addInstruction(
    MedicineInstruction instruction,
  ) = AddInstruction;

  const factory MedicinesEvent.save() = SaveMedicine;
}
