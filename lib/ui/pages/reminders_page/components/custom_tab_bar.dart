import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/calendar.dart';
import 'package:chance_app/ui/pages/reminders_page/components/custom_tab.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemindersBloc, RemindersState>(
        builder: (context, state) {
      SideSwipe sideSwipe = state.sideSwipe;
      return Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: beige300),
            color: beige100),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
                height: 44,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    CustomTab(
                      onTap: () {
                        BlocProvider.of<RemindersBloc>(context)
                            .add(ChangeSideSwipe());
                      },
                      isSelected: sideSwipe == SideSwipe.left,
                    ),
                    CustomTab(
                      onTap: () {
                        BlocProvider.of<RemindersBloc>(context)
                            .add(ChangeSideSwipe());
                      },
                    isSelected: sideSwipe == SideSwipe.right,
                  ),
                ],
              )),
          IgnorePointer(
            child: Flex(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                direction: Axis.horizontal,
                children: [
                  Expanded(
                      child: Center(
                    child: Text(
                      'Мої медикаменти',
                      style: TextStyle(
                        fontSize: 16,
                        color: sideSwipe == SideSwipe.left
                            ? primary50
                            : const Color(0xff57524C),
                      ),
                    ),
                  )),
                  Expanded(
                      child: Center(
                    child: Text(
                      'Мої завдання',
                      style: TextStyle(
                        fontSize: 16,
                        color: sideSwipe == SideSwipe.right
                            ? primary50
                            : const Color(0xff57524C),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
