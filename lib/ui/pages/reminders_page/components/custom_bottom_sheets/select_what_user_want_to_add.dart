import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/reminders_page.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectWhatUserWantToAdd extends StatelessWidget {
  const SelectWhatUserWantToAdd({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              BlocProvider.of<RemindersBloc>(context).add(
                  SelectWhatPersonWouldLikeToAdd(reminders: Reminders.tasks));
            },
            child: Container(
              width: size.width / 2.5,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: darkNeutral600,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/icons/tasks_small.svg",
                      color: primary50),
                  Text(
                    "Завдання",
                    style: TextStyle(fontSize: 16, color: primary50),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            child: Container(
                width: size.width / 2.5,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: darkNeutral600,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset("assets/icons/pills_small.svg",
                        color: primary50),
                    Text(
                      "Медикамент",
                      style: TextStyle(fontSize: 16, color: primary50),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
