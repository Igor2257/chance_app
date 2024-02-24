import 'dart:io';

import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/calendar.dart';
import 'package:chance_app/ui/pages/reminders_page/components/custom_bottom_sheets/custom_bottom_sheet.dart';
import 'package:chance_app/ui/pages/reminders_page/components/custom_tab_bar.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/task_list.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:flutter/cupertino.dart';
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
    return BlocBuilder<RemindersBloc, RemindersState>(
        builder: (context, state) {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              "Нагадування",
              style: TextStyle(fontSize: 22, color: primaryText),
            ),
            leading: BackButton(onPressed: (){
              Navigator.of(context)
                  .pushNamed("/");
            },),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset("assets/icons/dots_vertical.svg")),
            ],
          ),
          backgroundColor: beigeBG,
          body: Stack(
            children: [
              state.isLoading
                  ? Center(
                      child: CupertinoActivityIndicator(
                        color: primary500,
                        radius: 50,
                      ),
                    )
                  : Column(
                      children: [
                        CalendarView(),
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: CustomTabBar(),
                        ),
                        const Expanded(child: TaskList()),
                      ],
                    ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40, right: 10),
                  child: Builder(builder: (context) {
                    return InkWell(
                      onTap: () {
                        if (!state.isLoading) {
                          showBottomSheet(
                              backgroundColor: beige100,
                              enableDrag: true,
                              context: context,
                              transitionAnimationController:
                                  AnimationController(
                                      vsync: this,
                                      duration:
                                          const Duration(milliseconds: 200)),
                              builder: (context) {
                                return const CustomBottomSheet();
                              });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        constraints: const BoxConstraints(minHeight: 44),
                        decoration: BoxDecoration(
                            color: primary1000,
                            borderRadius: BorderRadius.circular(16)),
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
                                  fontSize: 16,
                                  letterSpacing: 0.15,
                                  color: primary50),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ));
    });
  }
}
