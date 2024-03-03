import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/task_item.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:chance_app/ux/model/task_model.dart';
import 'package:cupertino_listview/cupertino_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskList extends StatelessWidget {
  const TaskList(
    this.items, {
    super.key,
  });

  final List<TaskModel> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return _emptyListPlaceholder();

    final theme = Theme.of(context);

    return CupertinoListView.builder(
      physics: const BouncingScrollPhysics(),
      sectionCount: 1,
      itemInSectionCount: (_) => items.length,
      sectionBuilder: (context, sectionPath, _) {
        return Container(
          color: theme.scaffoldBackgroundColor,
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Сьогодні", // TODO: show correct day
                  style: TextStyle(fontSize: 28, color: primaryText),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/tasks_for_today");
                },
                child: Text(
                  "Всі завдання",
                  style: TextStyle(
                    fontSize: 16,
                    color: primary700,
                    decorationColor: primary700,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      childBuilder: (context, indexPath) {
        final task = items[indexPath.child];
        return TaskItem(
          task,
          onTap: () {
            context.read<RemindersBloc>().add(SelectTask(task: task));
          },
        );
      },
    );
  }

  Widget _emptyListPlaceholder() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        "Додайте завдання",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
