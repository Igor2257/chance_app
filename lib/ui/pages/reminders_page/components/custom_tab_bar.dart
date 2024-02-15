import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/calendar.dart';
import 'package:chance_app/ui/pages/reminders_page/components/custom_tab.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  SideSwipe sideSwipe = SideSwipe.left;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: beige300),
          color: beige100),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
              width: size.width,
              height: 44,
              child: Row(
                children: [
                  CustomTab(
                    onTap: () {
                      setState(() {
                        if (sideSwipe == SideSwipe.left) {
                          sideSwipe = SideSwipe.right;
                        } else {
                          sideSwipe = SideSwipe.left;
                        }
                      });
                    },
                    isSelected: sideSwipe == SideSwipe.left,
                  ),
                  CustomTab(
                    onTap: () {
                      setState(() {
                        if (sideSwipe == SideSwipe.left) {
                          sideSwipe = SideSwipe.right;
                        } else {
                          sideSwipe = SideSwipe.left;
                        }
                      });
                    },
                    isSelected: sideSwipe == SideSwipe.right,
                  ),
                ],
              )),
          IgnorePointer(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Мої медикаменти',
                  style: TextStyle(
                    fontSize: 16,
                    color: sideSwipe == SideSwipe.left
                        ? primary50
                        : Color(0xff57524C),
                  ),
                ),
                Text(
                  'Мої завдання',
                  style: TextStyle(
                    fontSize: 16,
                    color: sideSwipe == SideSwipe.right
                        ? primary50
                        : Color(0xff57524C),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
