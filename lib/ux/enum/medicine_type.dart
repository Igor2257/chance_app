import 'package:chance_app/resources/medicine_icons.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum MedicineType {
  pill,
  injection,
  solution,
  drops,
  powder,
  other;

  String get svgIcon {
    switch (this) {
      case MedicineType.pill:
        return MedicineIcons.pill;
      case MedicineType.injection:
        return MedicineIcons.injection;
      case MedicineType.solution:
        return MedicineIcons.solution;
      case MedicineType.drops:
        return MedicineIcons.drops;
      case MedicineType.powder:
        return MedicineIcons.powder;
      case MedicineType.other:
        return MedicineIcons.other;
    }
  }

  String get androidIconAsset {
    switch (this) {
      case MedicineType.pill:
        return "@mipmap/pill";
      case MedicineType.injection:
        return "@mipmap/injection";
      case MedicineType.solution:
        return "@mipmap/solution";
      case MedicineType.drops:
        return "@mipmap/drops";
      case MedicineType.powder:
        return "@mipmap/powder";
      case MedicineType.other:
        return "@mipmap/other";
    }
  }

  String toLocalizedString() {
    switch (this) {
      case MedicineType.pill:
        return "Таблетка";
      case MedicineType.injection:
        return "Ін’єкція";
      case MedicineType.solution:
        return "Розчин";
      case MedicineType.drops:
        return "Краплі";
      case MedicineType.powder:
        return "Порошок";
      case MedicineType.other:
        return "Інше";
    }
  }

  String toDoseString(int count) {
    switch (this) {
      case MedicineType.pill:
        return (count == 1)
            ? "Таблетка"
            : (count < 5)
                ? "Таблетки"
                : "Таблеток";

      case MedicineType.injection:
        return (count == 1)
            ? "Ін’єкція"
            : (count < 5)
                ? "Ін’єкції"
                : "Ін’єкцій";

      case MedicineType.powder:
        return "Саше";

      case MedicineType.solution:
      case MedicineType.drops:
      case MedicineType.other:
        return (count == 1)
            ? "Доза"
            : (count < 5)
                ? "Дози"
                : "Доз";
    }
  }
}
