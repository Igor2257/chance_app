import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/calendar.dart';
import 'package:chance_app/ui/pages/reminders_page/components/custom_bottom_sheets/custom_bottom_sheet.dart';
import 'package:chance_app/ui/pages/reminders_page/medicine/medicine_list.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/task_list.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/tasks_sheets.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:chance_app/ux/model/medicine_model.dart';
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
  var _selectedTab = SideSwipe.left;

  Future<void> _onAddButtonPressed() async {
    final selected = await showModalBottomSheet<Reminders>(
      context: context,
      backgroundColor: beige100,
      enableDrag: true,
      builder: (_) => const CustomBottomSheet(),
    );

    if (selected != null && mounted) {
      switch (selected) {
        case Reminders.medicine:
          final result = await Navigator.of(context).pushNamed("/add_medicine");
          if (result is MedicineModel) print("${result.name} додано");

        case Reminders.tasks:
          _scaffoldKey.currentState?.showBottomSheet(
            backgroundColor: beige100,
            enableDrag: true,
            (_) => const TasksSheets(),
          );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RemindersBloc>(context).add(LoadData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RemindersBloc, RemindersState, bool>(
      selector: (state) => state.isLoading,
      builder: (context, isLoading) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: beigeBG,
          appBar: AppBar(
            centerTitle: true,
            titleTextStyle: TextStyle(fontSize: 22, color: primaryText),
            title: const Text("Нагадування"),
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
          body: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Visibility(
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
                      child: DefaultTextStyle(
                        style: const TextStyle(fontSize: 16),
                        child: CupertinoSlidingSegmentedControl(
                          backgroundColor: beige100,
                          thumbColor: darkNeutral600,
                          groupValue: _selectedTab,
                          onValueChanged: (value) => setState(() {
                            _selectedTab = value!;
                          }),
                          children: {
                            SideSwipe.left: _selectorItem(
                              "Мої медикаменти",
                              isSelected: _selectedTab == SideSwipe.left,
                            ),
                            SideSwipe.right: _selectorItem(
                              "Мої завдання",
                              isSelected: _selectedTab == SideSwipe.right,
                            ),
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: IndexedStack(
                        alignment: Alignment.topCenter,
                        index: SideSwipe.values.indexOf(_selectedTab),
                        children: const [
                          TaskList(),
                          MedicineList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 10,
                bottom: 40,
                child: IgnorePointer(
                  ignoring: isLoading,
                  child: ElevatedButton.icon(
                    onPressed: _onAddButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary1000,
                      foregroundColor: primary50,
                      padding: const EdgeInsets.all(12),
                      minimumSize: const Size.square(44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.15,
                      ),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text("Додати"),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _selectorItem(
    String label, {
    required bool isSelected,
  }) {
    const selectedColor = Colors.white;
    const unselectedColor = Color(0xff57524C);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Text(
        label,
        style: TextStyle(color: isSelected ? selectedColor : unselectedColor),
      ),
    );
  }
}
