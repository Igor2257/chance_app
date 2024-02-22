import 'package:chance_app/ux/bloc/medicines_bloc/medicines_bloc.dart';
import 'package:flutter/widgets.dart';

class DoseText extends Text {
  DoseText({
    required MedicineType? medicineType,
    required int count,
    bool withCounter = false,
    super.style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    super.textScaleFactor,
    super.textScaler,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
    super.key,
  }) : super(
          [
            if (withCounter) count,
            _getText(medicineType, count: count),
          ].join(' '),
        );

  static String _getText(
    MedicineType? medicineType, {
    required int count,
  }) {
    switch (medicineType) {
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
      case null:
        return (count == 1)
            ? "Доза"
            : (count < 5)
                ? "Дози"
                : "Доз";
    }
  }
}
