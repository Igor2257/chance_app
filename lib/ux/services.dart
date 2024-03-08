import 'package:chance_app/main.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ux/hive_crum.dart';
import 'package:chance_app/ux/model/settings.dart';
import 'package:flutter/material.dart';

class Services {
  Future changeLanguage(String languageCode, BuildContext context) async {
    await AppLocalizations(Locale(languageCode))
        .changeLocale(languageCode)
        .whenComplete(() async {
      HiveCRUM hiveCRUM = HiveCRUM();
      Settings settings = hiveCRUM.setting.copyWith(languageCode: languageCode);
      hiveCRUM.updateSettings(settings);
    }).whenComplete(() =>
        MyApp.restartApp(context));
  }
}
