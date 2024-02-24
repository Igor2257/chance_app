import 'package:chance_app/ui/pages/reminders_page/components/custom_bottom_sheets/select_what_user_want_to_add.dart';
import 'package:chance_app/ui/pages/reminders_page/reminders_page.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/tasks_sheets.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RemindersBloc, RemindersState>(
      listener: (context, state) {
        if (state.reminders == Reminders.medicine) {
          Navigator.of(context).popAndPushNamed("/add_medicine");
        }
      },
      listenWhen: (previous, next) => previous.reminders != next.reminders,
      child: BlocSelector<RemindersBloc, RemindersState, Reminders>(
        selector: (state) => state.reminders,
        builder: (context, reminders) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: reminders == Reminders.empty ? 50 : 20,
              ),
              if (reminders == Reminders.empty)
                const SelectWhatUserWantToAdd()
              else if (reminders == Reminders.medicine)
                const SizedBox.shrink()
              else if (reminders == Reminders.tasks)
                const TasksSheets(),
              SizedBox(
                height: reminders == Reminders.empty ? 50 : 20,
              ),
            ],
          );
        },
      ),
    );
  }
}
