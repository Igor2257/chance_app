import 'dart:collection';

import 'package:bottom_picker/widgets/date_picker.dart';
import 'package:chance_app/resources/app_icons.dart';
import 'package:chance_app/resources/medicine_icons.dart';
import 'package:chance_app/ui/components/custom_time_picker.dart';
import 'package:chance_app/ui/components/custom_list_tile.dart';
import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/components/separated_list.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/medicines_page/components/dose_count_picker.dart';
import 'package:chance_app/ui/pages/medicines_page/components/dose_text.dart';
import 'package:chance_app/ux/bloc/medicines_bloc/medicines_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class AddMedicineStep {
  static const addName = "addName";
  static const addType = "addType";
  static const addPeriodicity = "addPeriodicity";
  static const addDayPeriodicity = "addDayPeriodicity";
  static const addStartDay = "addStartDay";
  static const addWeekdays = "addWeekdays";
  static const addDose = "addDose";
  static const ifNeedInstructions = "ifNeedInstructions";
  static const addInstructions = "addInstructions";
  static const allDone = "allDone";
}

class MedicinesPage extends StatefulWidget {
  const MedicinesPage({super.key});

  @override
  State<MedicinesPage> createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _medicineInputController = TextEditingController();

  late ThemeData _theme;

  NavigatorState get _navigator => _navigatorKey.currentState!;

  Future<bool?> _onDidPop() {
    return showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _pillsImage(),
              const SizedBox(height: 8),
              const Text(
                'У Вас є незбережені зміни',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              RoundedButton(
                onPress: () => Navigator.of(context).pop(false),
                color: primary1000,
                child: Text(
                  "Продовжити",
                  style: TextStyle(color: primary50, fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Завершити"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PageRoute<void> _pageRoute({
    required RouteSettings settings,
    required Widget childView,
  }) {
    final medicineName = context.read<MedicinesBloc>().state.name;
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return PopScope(
          canPop: true,
          onPopInvoked: (didPop) async {
            if (didPop) return;
            final pop = await _onDidPop();
            if ((pop ?? false) && context.mounted) Navigator.of(context).pop();
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(medicineName),
              backgroundColor: _theme.scaffoldBackgroundColor,
              elevation: 0,
              forceMaterialTransparency: true,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SafeArea(
                  bottom: false,
                  child: SizedBox(
                    height: 220,
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: _pillsImage(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            child: Text(
                              _getMiddleText(settings.name),
                              style: const TextStyle(fontSize: 22),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            child: LinearProgressIndicator(
                              value: 0,
                              color: darkNeutral600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: darkNeutral600,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                        child: childView,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getMiddleText(String? routeName) {
    switch (routeName) {
      case AddMedicineStep.addName:
        return "Який медикамент хочете додати?";
      case AddMedicineStep.addType:
        return "У якій формі випускається медикамент?";
      case AddMedicineStep.addPeriodicity:
      case AddMedicineStep.addDayPeriodicity:
        return "Як часто Ви його приймаєте?";
      case AddMedicineStep.addStartDay:
        return "Коли потрібно почати приймати першу дозу?";
      case AddMedicineStep.addWeekdays:
        return "Дні прийому";
      case AddMedicineStep.addDose:
        return "Час прийому";
      case AddMedicineStep.ifNeedInstructions:
        return "Додати інструкції";
      case AddMedicineStep.addInstructions:
        return "Чи слід приймати це з їжею?";
      default:
        return "";
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MedicinesBloc, MedicinesState>(
      listener: (context, state) {
        if (state.created) Navigator.of(context).pop();
      },
      child: Navigator(
        key: _navigatorKey,
        initialRoute: AddMedicineStep.addName,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AddMedicineStep.addName:
              return _pageRoute(
                settings: settings,
                childView: _addNameView(),
              );

            case AddMedicineStep.addType:
              return _pageRoute(
                settings: settings,
                childView: _addTypeView(),
              );

            case AddMedicineStep.addPeriodicity:
              return _pageRoute(
                settings: settings,
                childView: _addPeriodicityView(),
              );

            case AddMedicineStep.addDayPeriodicity:
              return _pageRoute(
                settings: settings,
                childView: _addDayPeriodicityView(),
              );

            case AddMedicineStep.addStartDay:
              return _pageRoute(
                settings: settings,
                childView: _addStartDayView(),
              );

            case AddMedicineStep.addWeekdays:
              return _pageRoute(
                settings: settings,
                childView: _addWeekdaysView(),
              );

            case AddMedicineStep.addDose:
              return _pageRoute(
                settings: settings,
                childView: _addDoseView(),
              );

            case AddMedicineStep.ifNeedInstructions:
              return _pageRoute(
                settings: settings,
                childView: _ifNeedInstructionsView(),
              );

            case AddMedicineStep.addInstructions:
              return _pageRoute(
                settings: settings,
                childView: _addInstructionsView(),
              );

            case AddMedicineStep.allDone:
              return _pageRoute(
                settings: settings,
                childView: _allDoneView(),
              );
          }
          return null;
        },
      ),
    );

    // return PopScope(
    //   canPop: false,
    //   onPopInvoked: (didPop) async {
    //     if (didPop) return;
    //     final pop = await _onDidPop();
    //     if ((pop ?? false) && context.mounted) Navigator.of(context).pop();
    //   },
    //   child: ,
    // );
  }

  @override
  void dispose() {
    _medicineInputController.dispose();
    super.dispose();
  }

  Widget _pillsImage() {
    return SvgPicture.asset(
      "assets/icons/pills_small.svg",
      height: 64,
      color: beige500,
    );
  }

  Widget _addNameView() {
    final border = UnderlineInputBorder(
      borderSide: BorderSide(color: beige200),
    );
    return Column(
      children: [
        CupertinoTextField(
          controller: _medicineInputController,
          autofocus: true,
          decoration: BoxDecoration(
            color: background,
            border: Border.all(color: beige800),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          placeholder: "Введіть назву препарату",
          placeholderStyle: TextStyle(color: beige800),
          clearButtonMode: OverlayVisibilityMode.always,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder(
          valueListenable: _medicineInputController,
          builder: (context, value, child) => Visibility(
            visible: value.text.isNotEmpty,
            child: child!,
          ),
          child: TextField(
            controller: _medicineInputController,
            readOnly: true,
            onTap: () {
              final name = _medicineInputController.text.trim();
              context.read<MedicinesBloc>().add(SetName(name));
              _navigator.pushNamed(AddMedicineStep.addType);
            },
            style: TextStyle(fontSize: 16, color: primary50),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              suffixIcon: const CupertinoListTileChevron(),
              suffixIconConstraints: const BoxConstraints(),
              iconColor: primary50,
              enabledBorder: border,
              focusedBorder: border,
            ),
          ),
        ),
      ],
    );
  }

  Widget _addTypeView() {
    final items = {
      MedicineType.pill: (icon: MedicineIcons.pill, text: "Таблетка"),
      MedicineType.injection: (icon: MedicineIcons.injection, text: "Ін’єкція"),
      MedicineType.solution: (icon: MedicineIcons.solution, text: "Розчин"),
      MedicineType.drops: (icon: MedicineIcons.drops, text: "Краплі"),
      MedicineType.powder: (icon: MedicineIcons.powder, text: "Порошок"),
      MedicineType.other: (icon: MedicineIcons.other, text: "Інше"),
    };
    return SeparatedList(
      separator: const SizedBox(height: 12),
      children: [
        for (final medicine in items.keys)
          CustomListTile(
            onTap: () {
              context.read<MedicinesBloc>().add(SetType(medicine));
              _navigator.pushNamed(AddMedicineStep.addPeriodicity);
            },
            svgIcon: items[medicine]!.icon,
            content: Text(items[medicine]!.text),
            trailing: const CupertinoListTileChevron(),
          ),
      ],
    );
  }

  Widget _addPeriodicityView() {
    final items = {
      Periodicity.everyDay: (text: "Щодня"),
      Periodicity.inADay: (text: "Кожні 2 дні"),
      Periodicity.certainDays: (text: "Певні дні тижня"),
    };
    return SeparatedList(
      separator: const SizedBox(height: 12),
      children: [
        for (final periodicity in items.keys)
          CustomListTile(
            onTap: () {
              context.read<MedicinesBloc>().add(SetPeriodicity(periodicity));
              // _navigator.pushNamed(AddMedicineStepA.addDayPeriodicity);
              if (periodicity == Periodicity.certainDays) {
                _navigator.pushNamed(AddMedicineStep.addWeekdays);
              } else {
                _navigator.pushNamed(AddMedicineStep.addStartDay);
              }
            },
            content: Text(items[periodicity]!.text),
            trailing: const CupertinoListTileChevron(),
          ),
      ],
    );
  }

  Widget _addDayPeriodicityView() {
    final items = {
      DayPeriodicity.once: (text: "Раз на день"),
      DayPeriodicity.twice: (text: "Двічі на день"),
      DayPeriodicity.other: (text: "Частіше"),
    };
    return SeparatedList(
      separator: const SizedBox(height: 12),
      children: [
        for (final periodicity in items.keys)
          CustomListTile(
            onTap: () {
              context.read<MedicinesBloc>().add(SetDayPeriodicity(periodicity));
            },
            content: Text(items[periodicity]!.text),
            trailing: const CupertinoListTileChevron(),
          ),
      ],
    );
  }

  Widget _addStartDayView() {
    final currentDate = context.read<MedicinesBloc>().state.startDate;
    var selectedDate = currentDate ?? DateTime.now();
    return Column(
      children: [
        const Spacer(),
        SizedBox(
          height: 240,
          child: DatePicker(
            initialDateTime: selectedDate,
            mode: CupertinoDatePickerMode.date,
            dateOrder: DatePickerDateOrder.dmy,
            onDateChanged: (DateTime date) {
              selectedDate = date;
            },
            textStyle: TextStyle(fontSize: 28, color: primary800),
          ),
        ),
        const Spacer(),
        RoundedButton(
          onPress: () {
            context.read<MedicinesBloc>().add(SetStartDate(selectedDate));
            _navigator.pushNamed(AddMedicineStep.addDose);
          },
          color: const Color(0xFF83CEFF),
          child: const Text("Далі"),
        ),
      ],
    );
  }

  Widget _addWeekdaysView() {
    return BlocSelector<MedicinesBloc, MedicinesState, Set<int>>(
      selector: (state) => state.weekdays,
      builder: (context, selectedDays) {
        return Column(
          children: [
            Text(
              'Оберіть дні тижня',
              style: TextStyle(fontSize: 22, color: primary100),
            ),
            const Spacer(),
            SeparatedList(
              axis: Axis.horizontal,
              separator: const SizedBox(width: 8),
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                DateTime.daysPerWeek,
                (index) {
                  final weekday = index + 1;
                  final isSelected = selectedDays.contains(weekday);
                  return SizedBox.square(
                    dimension: 44,
                    child: Material(
                      color: isSelected ? primary100 : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: darkNeutral800),
                      ),
                      textStyle: TextStyle(fontSize: 22, color: primary800),
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {
                          context.read<MedicinesBloc>().add(
                                isSelected
                                    ? RemoveWeekday(weekday)
                                    : AddWeekday(weekday),
                              );
                        },
                        child: Center(
                          child: Text(getWeekdayName(weekday)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            RoundedButton(
              onPress: selectedDays.isNotEmpty
                  ? () {
                      _navigator.pushNamed(AddMedicineStep.addDose);
                    }
                  : null,
              color: const Color(0xFF83CEFF),
              child: const Text("Далі"),
            ),
          ],
        );
      },
    );
  }

  Widget _addDoseView() {
    return BlocBuilder<MedicinesBloc, MedicinesState>(
      builder: (context, state) {
        final doses = SplayTreeMap<TimeOfDay, int>.from(
          state.doses,
          (one, other) {
            final result = one.hour.compareTo(other.hour);
            if (result != 0) return result;
            return one.minute.compareTo(other.minute);
          },
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                final lastDoseTime = doses.keys.lastOrNull;
                final nextDoseTime = (lastDoseTime == null)
                    ? const TimeOfDay(hour: 8, minute: 0)
                    : TimeOfDay(
                        hour: lastDoseTime.hour + 1,
                        minute: lastDoseTime.minute,
                      );
                if (nextDoseTime.hour < Duration.hoursPerDay) {
                  context.read<MedicinesBloc>().add(AddDose(nextDoseTime, 1));
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFD6ECFF),
                textStyle: const TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
              child: const Text("Додати дозу"),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ListView.separated(
                  physics: const RangeMaintainingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final doseTime = doses.keys.elementAt(index);
                    final doseCount = doses.values.elementAt(index);
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "${index + 1} доза",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFEDF7FF),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final now = DateTime.now();
                                final dateTime = await CustomTimePicker.show(
                                  context,
                                  title: const Text("Час прийому"),
                                  initialDateTime: DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    doseTime.hour,
                                    doseTime.minute,
                                  ),
                                );
                                if (dateTime != null && context.mounted) {
                                  context.read<MedicinesBloc>().add(
                                        ChangeDose(
                                          index: index,
                                          time: TimeOfDay(
                                            hour: dateTime.hour,
                                            minute: dateTime.minute,
                                          ),
                                        ),
                                      );
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEDF7FF),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  [
                                    doseTime.hour.toString().padLeft(2, "0"),
                                    doseTime.minute.toString().padLeft(2, "0"),
                                  ].join(':'),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Color(0xFF212833),
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                final count = await DoseCountPicker.show(
                                  context,
                                  title: const Text("Оберіть кількість доз"),
                                  medicineType: state.type,
                                  initialCount: doseCount,
                                );
                                if (count != null && context.mounted) {
                                  context.read<MedicinesBloc>().add(
                                        ChangeDose(
                                          index: index,
                                          count: count,
                                        ),
                                      );
                                }
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFFEDF7FF),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  DoseText(
                                    medicineType: state.type,
                                    count: doseCount,
                                    withCounter: true,
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                  const SizedBox(width: 8),
                                  SvgPicture.asset(
                                    MedicineIcons.other,
                                    height: 24,
                                    color: primary50,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(height: 1),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 12);
                  },
                  itemCount: doses.length,
                ),
              ),
            ),
            RoundedButton(
              onPress: doses.isNotEmpty
                  ? () {
                      _navigator.pushNamed(AddMedicineStep.ifNeedInstructions);
                    }
                  : null,
              color: const Color(0xFF83CEFF),
              child: const Text("Далі"),
            ),
            const SizedBox(height: 4),
          ],
        );
      },
    );
  }

  Widget _ifNeedInstructionsView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomListTile(
          onTap: () {
            _navigator.pushNamed(AddMedicineStep.addInstructions);
          },
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppIcons.addInstruction,
                height: 24,
                color: primary50,
              ),
              const SizedBox(width: 12),
              const Text("Додати інструкції?"),
            ],
          ),
        ),
        RoundedButton(
          onPress: () {
            context.read<MedicinesBloc>().add(const SaveMedicine());
          },
          color: const Color(0xFF83CEFF),
          child: const Text("Зберегти"),
        ),
      ],
    );
  }

  Widget _addInstructionsView() {
    final items = {
      MedicineInstruction.beforeEating: (text: "Перед іжею"),
      MedicineInstruction.whileEating: (text: "Під час їжі"),
      MedicineInstruction.afterEating: (text: "Після їжі"),
      MedicineInstruction.noMatter: (text: "Не має значення"),
    };
    return SeparatedList(
      separator: const SizedBox(height: 12),
      children: [
        for (final instruction in items.keys)
          CustomListTile(
            onTap: () {
              context.read<MedicinesBloc>().add(AddInstruction(instruction));
              _navigator.pushNamed(AddMedicineStep.allDone);
            },
            content: Text(items[instruction]!.text),
            trailing: const CupertinoListTileChevron(),
          ),
      ],
    );
  }

  Widget _allDoneView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomListTile(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppIcons.addInstruction,
                height: 24,
                color: primary50,
              ),
              const SizedBox(width: 12),
              const Text("Інструкції додані"),
              const SizedBox(width: 12),
              Icon(
                Icons.check,
                color: primary50,
              ),
            ],
          ),
        ),
        RoundedButton(
          onPress: () {
            context.read<MedicinesBloc>().add(const SaveMedicine());
          },
          color: const Color(0xFF83CEFF),
          child: const Text("Зберегти"),
        ),
      ],
    );
  }
}
