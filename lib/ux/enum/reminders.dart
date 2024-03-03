import 'package:chance_app/resources/app_icons.dart';

enum Reminders {
  tasks,
  medicine;

  String get svgIcon {
    switch (this) {
      case Reminders.tasks:
        return AppIcons.tasksSmall;
      case Reminders.medicine:
        return AppIcons.pillsSmall;
    }
  }

  String toLocalizedString() {
    switch (this) {
      case Reminders.tasks:
        return "Завдання";
      case Reminders.medicine:
        return "Медикамент";
    }
  }
}
