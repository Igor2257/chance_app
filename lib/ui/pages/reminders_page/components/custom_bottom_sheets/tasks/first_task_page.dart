import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/custom_bottom_sheets/input_reminders_layout.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstTaskPage extends StatelessWidget {
  FirstTaskPage({super.key});

  final TextEditingController nameTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemindersBloc, RemindersState>(
        builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputRemindersLayout(
            textEditingController: nameTextEditingController,
            title: '',
            subTitle: '',
            saveData: (String value) {
              BlocProvider.of<RemindersBloc>(context)
                  .add(SaveTaskName(name: value));
            },
            clearData: () {
              BlocProvider.of<RemindersBloc>(context)
                  .add(SaveTaskName(name: ""));
            },
          ),
          if (state.taskTitle.trim().isNotEmpty)
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: darkNeutral600))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.taskTitle,
                    style: TextStyle(fontSize: 16, color: primaryText),
                  ),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          const SizedBox(
            height: 100,
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).pushNamedAndRemoveUntil("/date_picker_for_tasks", (route) => true);
            },
            child: Container(
              height: 40,
              width: 120,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                  color: primary100, borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset("assets/icons/calendar.svg"),
                  Text(
                    "Сьогодні",
                    style: TextStyle(fontSize: 14, color: primaryText),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
