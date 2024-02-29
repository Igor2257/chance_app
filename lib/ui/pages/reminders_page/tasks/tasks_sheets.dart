import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/first_task_page.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksSheets extends StatelessWidget {
  const TasksSheets({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemindersBloc, RemindersState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Що потрібно зробити?",
                    style: TextStyle(color: primaryText, fontSize: 22),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const SizedBox(
                      width: 44,
                      height: 44,
                      child: Icon(Icons.close),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              pages(state),
              const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }

  Widget pages(RemindersState state) {
    int page = state.pageForTasks;
    if (page == 0) {
      return const FirstTaskPage();
    }
    return const SizedBox();
  }
}
