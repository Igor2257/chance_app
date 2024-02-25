import 'dart:collection';

import 'package:bottom_picker/widgets/date_picker.dart';
import 'package:chance_app/resources/app_icons.dart';
import 'package:chance_app/resources/medicine_icons.dart';
import 'package:chance_app/ui/components/custom_list_tile.dart';
import 'package:chance_app/ui/components/custom_time_picker.dart';
import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/components/separated_list.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/add_medicine_page/components/add_medicine_page_scaffold.dart';
import 'package:chance_app/ui/pages/add_medicine_page/components/dose_count_picker.dart';
import 'package:chance_app/ui/pages/add_medicine_page/components/dose_text.dart';
import 'package:chance_app/ux/bloc/add_medicine_bloc/add_medicine_bloc.dart';
// import 'package:chance_app/ux/enum/day_periodicity.dart';
import 'package:chance_app/ux/enum/medicine_instruction.dart';
import 'package:chance_app/ux/enum/medicine_type.dart';
import 'package:chance_app/ux/enum/periodicity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class AddMedicineStep {
  static const addName = "addName";
  static const addType = "addType";
  static const addPeriodicity = "addPeriodicity";
  // static const addDayPeriodicity = "addDayPeriodicity";
  static const addStartDay = "addStartDay";
  static const addWeekdays = "addWeekdays";
  static const addDose = "addDose";
  static const shouldAddInstructions = "shouldAddInstructions";
  static const addInstructions = "addInstructions";
}

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({super.key});

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _medicineInputController = TextEditingController();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  Map<String, WidgetBuilder> get _routes => {
        AddMedicineStep.addName: (_) => _addNamePage(),
        AddMedicineStep.addType: (_) => _addTypePage(),
        AddMedicineStep.addPeriodicity: (_) => _addPeriodicityPage(),
        // AddMedicineStep.addDayPeriodicity: (_) => _addDayPeriodicityPage(),
        AddMedicineStep.addStartDay: (_) => _addStartDayPage(),
        AddMedicineStep.addWeekdays: (_) => _addWeekdaysPage(),
        AddMedicineStep.addDose: (_) => _addDosePage(),
        AddMedicineStep.shouldAddInstructions: (_) =>
            _shouldAddInstructionsPage(),
        AddMedicineStep.addInstructions: (_) => _addInstructionsPage(),
      };

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddMedicineBloc, AddMedicineState>(
      listener: (context, state) {
        if (state.isCreated) {
          Navigator.of(context).pop();
        } else if (state.errorMessage != null) {
          Fluttertoast.showToast(msg: "Щось пішло не так");
        }
      },
      child: Scaffold(
        body: Navigator(
          key: _navigatorKey,
          initialRoute: AddMedicineStep.addName,
          onGenerateRoute: (settings) {
            final builder = _routes[settings.name];
            if (builder == null) return null;
            return MaterialPageRoute(
              settings: settings,
              builder: builder,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _medicineInputController.dispose();
    super.dispose();
  }

  Widget _addNamePage() {
    final border = UnderlineInputBorder(
      borderSide: BorderSide(color: beige200),
    );
    return AddMedicinePageScaffold(
      middleText: const Text("Який медикамент хочете додати?"),
      child: Column(
        children: [
          CupertinoTextField(
            controller: _medicineInputController,
            autofocus: true,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
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
              visible: value.text.trim().isNotEmpty,
              child: child!,
            ),
            child: TextField(
              controller: _medicineInputController,
              readOnly: true,
              onTap: () {
                final name = _medicineInputController.text.trim();
                context.read<AddMedicineBloc>().add(SetName(name));
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
      ),
    );
  }

  Widget _addTypePage() {
    final items = MedicineType.values.where(
      (type) => type != MedicineType.other, // Is excluded for now
    );
    return AddMedicinePageScaffold(
      middleText: const Text("У якій формі випускається медикамент?"),
      child: BlocSelector<AddMedicineBloc, AddMedicineState, MedicineType?>(
        selector: (state) => state.type,
        builder: (context, selectedType) {
          return SeparatedList(
            separator: const SizedBox(height: 12),
            children: [
              for (final medicine in items)
                CustomListTile(
                  onTap: () {
                    context.read<AddMedicineBloc>().add(SetType(medicine));
                    _navigator.pushNamed(AddMedicineStep.addPeriodicity);
                  },
                  svgIcon: medicine.svgIcon,
                  content: Text(medicine.toLocalizedString()),
                  trailing: const CupertinoListTileChevron(),
                  isSelected: medicine == selectedType,
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _addPeriodicityPage() {
    return AddMedicinePageScaffold(
      middleText: const Text("Як часто Ви його приймаєте?"),
      child: BlocSelector<AddMedicineBloc, AddMedicineState, Periodicity?>(
        selector: (state) => state.periodicity,
        builder: (context, selectedPeriodicity) {
          return SeparatedList(
            separator: const SizedBox(height: 12),
            children: [
              for (final periodicity in Periodicity.values)
                CustomListTile(
                  onTap: () {
                    context
                        .read<AddMedicineBloc>()
                        .add(SetPeriodicity(periodicity));
                    // _navigator.pushNamed(AddMedicineStepA.addDayPeriodicity);
                    if (periodicity == Periodicity.certainDays) {
                      _navigator.pushNamed(AddMedicineStep.addWeekdays);
                    } else {
                      _navigator.pushNamed(AddMedicineStep.addStartDay);
                    }
                  },
                  content: Text(periodicity.toLocalizedString()),
                  trailing: const CupertinoListTileChevron(),
                  isSelected: periodicity == selectedPeriodicity,
                ),
            ],
          );
        },
      ),
    );
  }

  // Widget _addDayPeriodicityPage() {
  //   return AddMedicinePageScaffold(
  //     middleText: const Text("Як часто Ви його приймаєте?"),
  //     child: BlocSelector<AddMedicineBloc, AddMedicineState, DayPeriodicity?>(
  //       selector: (state) => state.dayPeriodicity,
  //       builder: (context, selectedPeriodicity) {
  //         return SeparatedList(
  //           separator: const SizedBox(height: 12),
  //           children: [
  //             for (final periodicity in DayPeriodicity.values)
  //               CustomListTile(
  //                 onTap: () {
  //                   context
  //                       .read<AddMedicineBloc>()
  //                       .add(SetDayPeriodicity(periodicity));
  //                 },
  //                 content: Text(periodicity.toLocalizedString()),
  //                 trailing: const CupertinoListTileChevron(),
  //                 isSelected: periodicity == selectedPeriodicity,
  //               ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _addWeekdaysPage() {
    return AddMedicinePageScaffold(
      middleText: const Text("Дні прийому"),
      child: BlocSelector<AddMedicineBloc, AddMedicineState, Set<int>>(
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
                            context.read<AddMedicineBloc>().add(
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
                        _navigator.pushNamed(AddMedicineStep.addStartDay);
                      }
                    : null,
                color: const Color(0xFF83CEFF),
                child: const Text("Далі"),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _addStartDayPage() {
    final currentDate = context.read<AddMedicineBloc>().state.startDate;
    var selectedDate = currentDate ?? DateTime.now();
    return AddMedicinePageScaffold(
      middleText: const Text("Коли потрібно почати приймати першу дозу?"),
      child: Column(
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
              context.read<AddMedicineBloc>().add(SetStartDate(selectedDate));
              _navigator.pushNamed(AddMedicineStep.addDose);
            },
            color: const Color(0xFF83CEFF),
            child: const Text("Далі"),
          ),
        ],
      ),
    );
  }

  Widget _addDosePage() {
    return AddMedicinePageScaffold(
      middleText: const Text("Час прийому"),
      child: BlocBuilder<AddMedicineBloc, AddMedicineState>(
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
                  final lastDoseTime = state.doses.keys.lastOrNull;
                  final nextDoseTime = (lastDoseTime == null)
                      ? const TimeOfDay(hour: 8, minute: 0)
                      : TimeOfDay(
                          hour: (lastDoseTime.hour + 1) % Duration.hoursPerDay,
                          minute: lastDoseTime.minute,
                        );
                  context.read<AddMedicineBloc>().add(AddDose(nextDoseTime, 1));
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
                                    context.read<AddMedicineBloc>().add(
                                          ChangeDose(
                                            index: state.doses.keys
                                                .toList()
                                                .indexOf(doseTime),
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
                                      doseTime.minute
                                          .toString()
                                          .padLeft(2, "0"),
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
                                    context.read<AddMedicineBloc>().add(
                                          ChangeDose(
                                            index: state.doses.values
                                                .toList()
                                                .indexOf(doseCount),
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
                        _navigator
                            .pushNamed(AddMedicineStep.shouldAddInstructions);
                      }
                    : null,
                color: const Color(0xFF83CEFF),
                child: const Text("Далі"),
              ),
              const SizedBox(height: 4),
            ],
          );
        },
      ),
    );
  }

  Widget _shouldAddInstructionsPage() {
    return AddMedicinePageScaffold(
      middleText: const Text("Додати інструкції"),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomListTile(
            onTap: () {
              _navigator.pushNamed(AddMedicineStep.addInstructions);
            },
            content: BlocSelector<AddMedicineBloc, AddMedicineState, bool>(
              selector: (state) => state.instruction != null,
              builder: (context, instructionAdded) {
                return SeparatedList(
                  axis: Axis.horizontal,
                  separator: const SizedBox(width: 12),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppIcons.addInstruction,
                      height: 24,
                      color: primary50,
                    ),
                    if (!instructionAdded)
                      const Text("Додати інструкції?")
                    else ...[
                      const Text("Інструкції додані"),
                      Icon(
                        Icons.check,
                        color: primary50,
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
          RoundedButton(
            onPress: () {
              context.read<AddMedicineBloc>().add(const SaveMedicine());
            },
            color: const Color(0xFF83CEFF),
            child: const Text("Зберегти"),
          ),
        ],
      ),
    );
  }

  Widget _addInstructionsPage() {
    return AddMedicinePageScaffold(
      middleText: const Text("Чи слід приймати це з їжею?"),
      child:
          BlocSelector<AddMedicineBloc, AddMedicineState, MedicineInstruction?>(
        selector: (state) => state.instruction,
        builder: (context, selectedInstruction) {
          return SeparatedList(
            separator: const SizedBox(height: 12),
            children: [
              for (final instruction in MedicineInstruction.values)
                CustomListTile(
                  onTap: () {
                    context
                        .read<AddMedicineBloc>()
                        .add(AddInstruction(instruction));
                    _navigator.pop();
                  },
                  content: Text(instruction.toLocalizedString()),
                  trailing: const CupertinoListTileChevron(),
                  isSelected: instruction == selectedInstruction,
                ),
            ],
          );
        },
      ),
    );
  }
}
