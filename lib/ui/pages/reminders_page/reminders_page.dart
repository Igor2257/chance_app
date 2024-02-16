import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/calendar.dart';
import 'package:chance_app/ui/pages/reminders_page/components/custom_bottom_sheets/custom_bottom_sheet.dart';
import 'package:chance_app/ui/pages/reminders_page/components/custom_tab_bar.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

enum Reminders { empty, medicine, tasks }

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    BlocProvider.of<RemindersBloc>(context).add(LoadData());
    super.initState();
  }

  bool firstWidgetVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Нагадування",
          style: TextStyle(fontSize: 22, color: primaryText),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/icons/dots_vertical.svg")),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          showModalBottomSheet<void>(
              useSafeArea: true,
              enableDrag: true,
              context: context,
              backgroundColor: beige100,
              builder: (context) {
                return const CustomBottomSheet();
              }).whenComplete(() {
            BlocProvider.of<RemindersBloc>(context).add(
                SelectWhatPersonWouldLikeToAdd(reminders: Reminders.empty));
          });
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          height: 44,
          decoration: BoxDecoration(
              color: primary1000, borderRadius: BorderRadius.circular(16)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: primary50,
              ),
              Text(
                "Додати",
                style: TextStyle(
                    fontSize: 16, letterSpacing: 0.15, color: primary50),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: beigeBG,
      body: Column(
        children: [
          CalendarView(),
          Container(
            padding: const EdgeInsets.all(16),
            child: const Column(
              children: [
                CustomTabBar(),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Додайте завдання",
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
