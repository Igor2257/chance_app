import 'package:chance_app/resources/app_icons.dart';
import 'package:chance_app/ui/pages/reminders_page/components/reminder_actions.dart';
import 'package:chance_app/ui/pages/reminders_page/components/task_header.dart';
import 'package:chance_app/ux/enum/reminder_action_result.dart';
import 'package:chance_app/ux/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';

class EditTaskScheduleBottomSheet extends StatelessWidget {
  /// Returns [ReminderActionResult] value.
  const EditTaskScheduleBottomSheet(
    this.task, {
    super.key,
  });

  final TaskModel task;

  String _reminderText(int minutes) {
    if (minutes == 0) return "Вчасно";
    if (minutes == Duration.minutesPerDay) return "За 1 день";
    if (minutes == Duration.minutesPerHour) return "За 1 год";
    return "За $minutes хв";
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hasActiveReminder = task.reminderTime?.isAfter(now) ?? false;
    final parsedDate = Jiffy.parseFromDateTime(task.date);
    return SafeArea(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TaskHeader(task),
                const SizedBox(height: 8),
                Text(
                  [
                    DateUtils.isSameDay(task.date, DateTime.now())
                        ? "Сьогодні"
                        : parsedDate.MMMMd,
                    parsedDate.Hm,
                  ].join(" "),
                  style: const TextStyle(fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                if (hasActiveReminder) ...[
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.alarm, size: 24),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          _reminderText(task.remindBefore!).toLowerCase(),
                          style: const TextStyle(
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 24),
                ReminderActions(
                  onMissedPressed: Navigator.of(context).pop,
                  onDonePressed: () =>
                      Navigator.of(context).pop(ReminderState.done),
                  onReschedulePressed: () =>
                      Navigator.of(context).pop(ReminderState.rescheduled),
                ),
              ],
            ),
          ),
          Positioned(
            top: -12,
            right: 12,
            child: _deleteButton(context),
          ),
        ],
      ),
    );
  }

  Widget _deleteButton(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(ReminderState.deleted),
      tooltip: "Видалити",
      icon: SvgPicture.asset(
        AppIcons.trash,
        color: Colors.black,
        height: 24,
      ),
    );
  }
}