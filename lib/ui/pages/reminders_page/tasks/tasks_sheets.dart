import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/first_task_page.dart';
import 'package:chance_app/ux/bloc/add_task_bloc/add_task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksSheets extends StatelessWidget {
  const TasksSheets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: beige100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${AppLocalizations.instance.translate("whatNeedsToBeDone")}?",
                    style: const TextStyle(color: primaryText, fontSize: 22),
                  ),
                  const CloseButton(),
                ],
              ),
              const SizedBox(height: 20),
              pages(),
            ],
          ),
        ),
      ),
    );
  }

  Widget pages() {
    return BlocSelector<AddTaskBloc, AddTaskState, int>(
        selector: (state) => state.pageForTasks,
        builder: (context, selectedType) {
          if (selectedType == 0) {
            return const FirstTaskPage();
          }
          return const SizedBox();
        });
  }
}
