import 'package:chance_app/ui/pages/reminders_page/components/custom_bottom_sheets/select_what_user_want_to_add.dart';
import 'package:chance_app/ui/pages/reminders_page/components/custom_bottom_sheets/tasks/tasks_sheets.dart';
import 'package:chance_app/ui/pages/reminders_page/reminders_page.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemindersBloc, RemindersState>(
        builder: (context, state) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: state.reminders == Reminders.empty ? 50 : 20,
          ),
          state.reminders == Reminders.empty
              ? const SelectWhatUserWantToAdd()
              : state.reminders == Reminders.medicine
                  ? const SizedBox()
                  : const TasksSheets(),
          SizedBox(
            height: state.reminders == Reminders.empty ? 50 : 20,
          ),
        ],
      );
    });
  }
}
