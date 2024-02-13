import 'package:chance_app/ui/pages/sign_in_up/registration/give_permission.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/input_register_layout.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/continue_log_in.dart';
import 'package:flutter/material.dart';

class ThirdSubPage extends StatelessWidget {
  ThirdSubPage({super.key});

  final TextEditingController firstPasswordTextEditingController =
          TextEditingController(),
      secondPasswordTextEditingController = TextEditingController();

  final FocusNode firstPasswordFocusNode = FocusNode(),
      secondPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 24),
        InputRegisterLayout(
          title: "Введіть пароль*",
          focusNode: firstPasswordFocusNode,
          useCancelButton: false,
          obscureText: true,
          textInputAction: TextInputAction.next,
          inputLayouts: InputLayouts.firstPassword,
          focusOtherField: () {
            firstPasswordFocusNode.unfocus();
            FocusScope.of(context).requestFocus(secondPasswordFocusNode);
          },textInputType: TextInputType.text,
        ),
        SizedBox(height: 24),
        InputRegisterLayout(
          title: "Повторіть пароль*",
          focusNode: secondPasswordFocusNode,
          useCancelButton: false,
          obscureText: true,
          textInputAction: TextInputAction.done,
          inputLayouts: InputLayouts.lastPassword,
          focusOtherField: () {
            secondPasswordFocusNode.unfocus();
          },
          textInputType: TextInputType.text,
        ),
        const Spacer(),
        const GivePermission(),
        SizedBox(height: 20,),
        const ContinueLogIn(name: "Завершити",),
        const Spacer(),
      ],
    );
  }
}
