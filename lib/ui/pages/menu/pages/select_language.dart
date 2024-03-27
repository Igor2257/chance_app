import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ui/pages/menu/components/language_card.dart';
import 'package:chance_app/ux/services.dart';
import 'package:flutter/material.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({super.key});

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: beigeBG,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          AppLocalizations.instance.translate("changeLanguage"),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(8),
        children: languages.keys.map<Widget>((key) {
          return LanguageCard(
              title: languages[key]!,
              onTap: () {
                Services().changeLanguage(key, context);
              });
        }).toList(),
      ),
    );
  }
}
