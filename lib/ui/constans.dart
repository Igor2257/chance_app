import 'package:chance_app/ui/pages/reminders_page/tasks/custom_bottom_sheet_notification_picker.dart';
import 'package:flutter/material.dart';

Color beigeTransparent = const Color(0xfffbf6f0),
    beigeBG = const Color(0xfffffdfc),
    beige0 = const Color(0xffffffff),
    beige50 = const Color(0xfffbf6f0),
    beige100 = const Color(0xfff4eee7),
    beige200 = const Color(0xffefe6db),
    beige300 = const Color(0xffE5D9CB),
    beige400 = const Color(0xffC6B098),
    beige500 = const Color(0xffBD967A),
    beige600 = const Color(0xff876C4F),
    beige800 = const Color(0xff4E3B26); //Beige

Color primaryText = const Color(0xff212833),
    primary1000 = const Color(0xff0E265D),
    primary900 = const Color(0xff12327B),
    primary800 = const Color(0xff0F3A9C),
    primary700 = const Color(0xff0057FF),
    primary600 = const Color(0xff066CFF),
    primary500 = const Color(0xff1E8DFF),
    primary400 = const Color(0xff48B1FF),
    primary300 = const Color(0xff83CEFF),
    primary200 = const Color(0xffB5E0FF),
    primary100 = const Color(0xffD6ECFF),
    primary50 = const Color(0xffEDF7FF); //primary

Color darkNeutral1000 = const Color(0xff212833),
    darkNeutral800 = const Color(0xff354457),
    darkNeutral600 = const Color(0xff4A627F),
    darkNeutral400 = const Color(0xff7E97B2),
    darkNeutral300 = const Color(0xffD8DEE6),
    grey = const Color(0xffD9D9D9);

Color red1000 = const Color(0xff960000),
    red900 = const Color(0xffb00000),
    red800 = const Color(0xffFF4F4F),
    green = const Color(0xff2E7A00);

Color background = const Color(0xffFFFDFC);

const kDefaultAndroidIcon = "ic_stat_onesignal_default";

String getWeekdayName(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return 'ПН';
    case DateTime.tuesday:
      return 'ВТ';
    case DateTime.wednesday:
      return 'СР';
    case DateTime.thursday:
      return 'ЧТ';
    case DateTime.friday:
      return 'ПТ';
    case DateTime.saturday:
      return 'СБ';
    case DateTime.sunday:
      return 'НД';
    default:
      return '';
  }
}

String getMonthName(int month) {
  switch (month) {
    case DateTime.january:
      return 'Січень';
    case DateTime.february:
      return 'Лютий';
    case DateTime.march:
      return 'Березень';
    case DateTime.april:
      return 'Квітень';
    case DateTime.may:
      return 'Травень';
    case DateTime.june:
      return 'Червень';
    case DateTime.july:
      return 'Липень';
    case DateTime.august:
      return 'Серпень';
    case DateTime.september:
      return 'Вересень';
    case DateTime.october:
      return 'Жовтень';
    case DateTime.november:
      return 'Листопад';
    case DateTime.december:
      return 'Грудень';
    default:
      return '';
  }
}

const NotificationsBeforeEnumMap = {
  NotificationsBefore.no: 'no',
  NotificationsBefore.atTime: 'atTime',
  NotificationsBefore.fiveMinute: 'fiveMinute',
  NotificationsBefore.thirtyMinute: 'thirtyMinute',
  NotificationsBefore.oneHour: 'oneHour',
  NotificationsBefore.oneDay: 'oneDay',
};
const errors400 = {
  "400": "Некоректний запит",
  "401": "Не авторизовано",
  "403": "Заборонено",
  "404": "Не знайдено",
  "405": "Метод не дозволений",
  "408": "Таймаут запиту",
  "429": "Забагато запитів"
};
