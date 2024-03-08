import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

const apiUrl = 'http://139.28.37.11:56565/stage/api';
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
      return AppLocalizations.instance.translate("mon").toUpperCase();
    case DateTime.tuesday:
      return AppLocalizations.instance.translate("tue").toUpperCase();
    case DateTime.wednesday:
      return AppLocalizations.instance.translate("wed").toUpperCase();
    case DateTime.thursday:
      return AppLocalizations.instance.translate("thu").toUpperCase();
    case DateTime.friday:
      return AppLocalizations.instance.translate("fri").toUpperCase();
    case DateTime.saturday:
      return AppLocalizations.instance.translate("sat").toUpperCase();
    case DateTime.sunday:
      return AppLocalizations.instance.translate("sun").toUpperCase();
    default:
      return '';
  }
}

String getMonthName(int month) {
  switch (month) {
    case DateTime.january:
      return AppLocalizations.instance.translate("january");
    case DateTime.february:
      return AppLocalizations.instance.translate("february");
    case DateTime.march:
      return AppLocalizations.instance.translate("march");
    case DateTime.april:
      return AppLocalizations.instance.translate("april");
    case DateTime.may:
      return AppLocalizations.instance.translate("may");
    case DateTime.june:
      return AppLocalizations.instance.translate("june");
    case DateTime.july:
      return AppLocalizations.instance.translate("july");
    case DateTime.august:
      return AppLocalizations.instance.translate("august");
    case DateTime.september:
      return AppLocalizations.instance.translate("september");
    case DateTime.october:
      return AppLocalizations.instance.translate("october");
    case DateTime.november:
      return AppLocalizations.instance.translate("november");
    case DateTime.december:
      return AppLocalizations.instance.translate("december");
    default:
      return '';
  }
}

final errors400 = {
  "400": AppLocalizations.instance.translate("error400"),
  "401": AppLocalizations.instance.translate("error401"),
  "403": AppLocalizations.instance.translate("error403"),
  "404": AppLocalizations.instance.translate("error404"),
  "405": AppLocalizations.instance.translate("error405"),
  "408": AppLocalizations.instance.translate("error408"),
  "429": AppLocalizations.instance.translate("error429"),
};
const Map<String, String> languages = {
  "ar": "عرب",
  "bg": "Български",
  "cs": "Čeština",
  "da": "Dansk",
  "de": "Deutsch",
  "el": "Ελληνικά",
  "en": "English",
  "es": "Español",
  "et": "Eesti keel",
  "eu": "Euskara",
  "fa": "فارسی",
  "fi": "Suomalainen",
  "fil": "Pilipinas",
  "fr": "Français",
  "hr": "Hrvatski",
  "id": "Bahasa Indonesia",
  "is": "Íslenskur",
  "it": "Italiano",
  "iw": "עִברִית",
  "ja": "日本",
  "ko": "한국인",
  "lt": "Latviski",
  "lv": "Lietuvių",
  "mk": "Македонски",
  "nl": "Nederlands",
  "no": "Norsk",
  "pl": "Polski",
  "pt": "Português",
  "ro": "Română",
  "ru": "Русский",
  "sk": "Slovenský",
  "sl": "Slovenščina",
  "sq": "Shqiptare",
  "sr": "Српски",
  "sv": "Svenska",
  "tr": "Türkçe",
  "uk": "Українська",
  "zh": "简体中文"
};