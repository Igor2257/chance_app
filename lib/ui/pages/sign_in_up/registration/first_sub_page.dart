import 'package:chance_app/ui/pages/sign_in_up/registration/input_register_layout.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/continue_log_in.dart';
import 'package:flutter/material.dart';


class FirstSubPage extends StatefulWidget {
  const FirstSubPage({super.key});



  @override
  State<FirstSubPage> createState() => _FirstSubPageState();
}

class _FirstSubPageState extends State<FirstSubPage> {

  final FocusNode firstNameFocusNode = FocusNode(),
      lastNameFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 24),
            InputRegisterLayout(
              title: "Введіть ім`я*",
              focusNode: lastNameFocusNode,
              useCancelButton: false,
              obscureText: false,
              textInputAction: TextInputAction.next,
              inputLayouts: InputLayouts.lastName,
              focusOtherField: () {
                lastNameFocusNode.unfocus();
                FocusScope.of(context).requestFocus(firstNameFocusNode);
              }, textInputType: TextInputType.name,
            ),
            const SizedBox(height: 24),
            InputRegisterLayout(
              title: "Введіть прізвище*",

              focusNode: firstNameFocusNode,
              useCancelButton: false,
              obscureText: false,
              textInputAction: TextInputAction.done,
              inputLayouts: InputLayouts.firstName,
              focusOtherField: () {
                firstNameFocusNode.unfocus();
              },textInputType: TextInputType.name,
            ),
            const Spacer(),
            const ContinueLogIn(name: "Продовжити",),
            const Spacer(),
          ],
        );
  }
}
