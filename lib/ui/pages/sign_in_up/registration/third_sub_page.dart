import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/continue_log_in.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/give_permission.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/input_register_layout.dart';
import 'package:flutter/material.dart';

class ThirdSubPage extends StatefulWidget {
  const ThirdSubPage({super.key});

  @override
  State<ThirdSubPage> createState() => _ThirdSubPageState();
}

class _ThirdSubPageState extends State<ThirdSubPage> {
  final FocusNode firstPasswordFocusNode = FocusNode(),
      secondPasswordFocusNode = FocusNode();
  final TextEditingController firstPasswordEditingController =
  TextEditingController(),
      lastPasswordEditingController = TextEditingController();

  //@override
  //void dispose() {
  //  lastPasswordEditingController.dispose();
  //  firstPasswordEditingController.dispose();
  //  firstPasswordFocusNode.dispose();
  //  secondPasswordFocusNode.dispose();
  //  super.dispose();
  //}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 24),
            InputRegisterLayout(
              textEditingController: firstPasswordEditingController,
              title:
                  "${AppLocalizations.instance.translate("enterYourPassword")}*",
              focusNode: firstPasswordFocusNode,
              useCancelButton: false,
              obscureText: true,
              textInputAction: TextInputAction.next,
              inputLayouts: InputLayouts.firstPassword,
              focusOtherField: () {
                firstPasswordFocusNode.unfocus();
                FocusScope.of(context).requestFocus(secondPasswordFocusNode);
              },
              textInputType: TextInputType.text,
              key: const ValueKey("first"),
            ),
            const SizedBox(height: 24),
            InputRegisterLayout(
              textEditingController: lastPasswordEditingController,
              title:
                  "${AppLocalizations.instance.translate("enterPasswordAgain")}*",
              focusNode: secondPasswordFocusNode,
              useCancelButton: false,
              obscureText: true,
              textInputAction: TextInputAction.done,
              inputLayouts: InputLayouts.lastPassword,
              focusOtherField: () {
                secondPasswordFocusNode.unfocus();
              },
              textInputType: TextInputType.text,
              key: const ValueKey("second"),
            ),
            const Spacer(),
            const GivePermission(),
            const SizedBox(
              height: 20,
            ),
            ContinueLogIn(
              name: AppLocalizations.instance.translate("continue"),
              firstText: firstPasswordEditingController,
              secondText: lastPasswordEditingController,
              firstFocusNode: firstPasswordFocusNode,
              lastFocusNode: secondPasswordFocusNode,
            ),
            const Spacer(),
          ],
        ));
  }
}
