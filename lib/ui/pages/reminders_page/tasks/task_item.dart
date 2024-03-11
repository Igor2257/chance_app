import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/model/task_model.dart';
import 'package:flutter/cupertino.dart' show CupertinoListTile;
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(
    this.task, {
    this.onTap,
    super.key,
  });

  final TaskModel task;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      onTap: onTap,
      backgroundColor: primary50,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
      leadingToTitle: 4,
      leading: Icon(
        task.isDone ? Icons.check_box_outlined : Icons.check_box_outline_blank,
        size: 28,
        color: task.isDone ? darkNeutral400 : primaryText,
      ),
      title: Text(
        task.message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          color: task.isDone ? darkNeutral400 : primaryText,
          decoration:
              task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      additionalInfo: Text(
        [
          task.date.hour.toString().padLeft(2, "0"),
          task.date.minute.toString().padLeft(2, "0"),
        ].join(":"),
        style: TextStyle(
          fontSize: 16,
          color: task.isDone ? darkNeutral400 : primaryText,
        ),
      ),
      trailing: Icon(
        Icons.alarm,
        color: task.isDone ? darkNeutral400 : primaryText,
      ),
    );
  }
}
