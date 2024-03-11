import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ui/pages/reminders_page/add_medicine_page/components/medicine_added_bottom_sheet.dart';
import 'package:chance_app/ui/pages/reminders_page/components/calendar.dart';
import 'package:chance_app/ui/pages/reminders_page/components/custom_bottom_sheets/custom_bottom_sheet.dart';
import 'package:chance_app/ui/pages/reminders_page/medicine/medicine_list.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/task_list.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/tasks_sheets.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:chance_app/ux/enum/reminders.dart';
import 'package:chance_app/ux/model/medicine_model.dart';
import 'package:chance_app/ux/model/task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _selectedTab = Reminders.medicine;

  late EdgeInsets _padding;

  Future<void> _onAddButtonPressed() async {
    final selectedReminders = await showModalBottomSheet<Reminders>(
      context: context,
      backgroundColor: beige100,
      enableDrag: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (_) => const CustomBottomSheet(),
    );

    if (selectedReminders != null) {
      switch (selectedReminders) {
        case Reminders.tasks:
          _scaffoldKey.currentState?.showBottomSheet(
            backgroundColor: beige100,
            (_) => const TasksSheets(),
          );
          break;
        case Reminders.medicine:
          var addMedicine = true;
          do {
            if (!mounted) break;
            final result =
                await Navigator.of(context).pushNamed("/add_medicine");
            if (result is MedicineModel && mounted) {
              BlocProvider.of<RemindersBloc>(context)
                  .add(SaveMedicine(medicineModel: result));
              final addMore = await showModalBottomSheet<bool>(
                context: context,
                backgroundColor: beige100,
                enableDrag: true,
                showDragHandle: true,
                builder: (_) => MedicineAddedBottomSheet(result),
              );
              if (addMore ?? false) continue;
            }
            addMedicine = false;
          } while (addMedicine);
          break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RemindersBloc>(context).add(LoadData());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _padding = MediaQuery.paddingOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: beigeBG,
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(fontSize: 22, color: primaryText),
        title: Text(AppLocalizations.instance.translate("reminder")),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/");
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            BlocSelector<RemindersBloc, RemindersState, bool>(
              selector: (state) => state.isLoading,
              builder: (context, isLoading) {
                return Visibility(
                  visible: !isLoading,
                  replacement: CupertinoActivityIndicator(
                    color: primary500,
                    radius: 50,
                  ),
                  child: Column(
                    children: [
                      CalendarView(),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: _tabSwitcher(),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 125),
                            child: _itemsList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              right: _padding.right + 10,
              bottom: _padding.bottom + 10,
              child: ElevatedButton.icon(
                onPressed: _onAddButtonPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary1000,
                  foregroundColor: primary50,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 12,
                  ),
                  minimumSize: const Size.square(36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.15,
                  ),
                ),
                icon: const Icon(Icons.add),
                label: Text(AppLocalizations.instance.translate("add")),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabSwitcher() {
    final tabs = {
      Reminders.medicine: AppLocalizations.instance.translate("myMedicines"),
      Reminders.tasks: AppLocalizations.instance.translate("myTasks"),
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: beige300),
      ),
      position: DecorationPosition.foreground,
      child: CupertinoSlidingSegmentedControl(
        backgroundColor: beige100,
        thumbColor: darkNeutral600,
        groupValue: _selectedTab,
        onValueChanged: (value) => setState(() {
          _selectedTab = value!;
        }),
        children: {
          for (final tab in tabs.keys)
            tab: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Text(
                  tabs[tab]!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: (_selectedTab == tab)
                        ? Colors.white
                        : const Color(0xff57524C),
                  ),
                ),
              ),
            ),
        },
      ),
    );
  }

  Widget _itemsList() {
    switch (_selectedTab) {
      case Reminders.medicine:
        return BlocSelector<RemindersBloc, RemindersState, List<MedicineModel>>(
          selector: (state) => state.myMedicines,
          builder: (context, items) => MedicineList(items),
        );
      case Reminders.tasks:
        return BlocSelector<RemindersBloc, RemindersState, List<TaskModel>>(
          selector: (state) => state.myTasks,
          builder: (context, items) => TaskList(items),
        );
    }
  }
}
