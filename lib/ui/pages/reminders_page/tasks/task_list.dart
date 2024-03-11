import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/task_item.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:chance_app/ux/model/task_model.dart';
import 'package:collection/collection.dart';
import 'package:cupertino_listview/cupertino_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

class TaskList extends StatelessWidget {
  const TaskList(
    this.tasks, {
    required this.dayDate,
    super.key,
  });

  final List<TaskModel> tasks;
  final DateTime dayDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = tasks
        .where((element) => !element.isRemoved)
        .where((element) => DateUtils.isSameDay(element.date, dayDate))
        .sortedBy((element) => element.date);

    if (items.isEmpty) return _emptyListPlaceholder();

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
                  DateUtils.isSameDay(dayDate, DateTime.now())
                      ? "Сьогодні"
                      : Jiffy.parseFromDateTime(dayDate).MMMMd,
                  style: const TextStyle(fontSize: 28, color: primaryText),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/tasks_for_today");
                },
                child: const Text(
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
            context.read<RemindersBloc>().add(TaskIsDone(task));
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
