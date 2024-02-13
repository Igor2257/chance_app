import 'package:chance_app/ui/pages/sign_in_up/registration/input_register_layout.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/continue_log_in.dart';
import 'package:flutter/material.dart';

class SecondSubPage extends StatelessWidget {
  SecondSubPage( {super.key});


  final FocusNode phoneFocusNode = FocusNode(), emailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(
          height: 40,
        ),
        InputRegisterLayout(
          title: "Введіть номер телефону*",
          focusNode: phoneFocusNode,
          useCancelButton: false,
          obscureText: false,
          textInputAction: TextInputAction.next,
          inputLayouts: InputLayouts.phone,
          focusOtherField: () {
            phoneFocusNode.unfocus();
            FocusScope.of(context).requestFocus(emailFocusNode);
          },textInputType: TextInputType.phone,
        ),
        const SizedBox(
          height: 40,
        ),
        InputRegisterLayout(
          title: "Введіть електрону пошту*",
          focusNode: emailFocusNode,
          useCancelButton: false,
          obscureText: false,
          textInputAction: TextInputAction.done,
          inputLayouts: InputLayouts.email,
          focusOtherField: () {
            emailFocusNode.unfocus();
          },textInputType: TextInputType.emailAddress,
        ),
        const Spacer(),
        const ContinueLogIn(name: "Продовжити",),
        const Spacer(),
      ],
    );
  }
}
