import 'package:chance_app/ui/pages/sign_in_up/registration/continue_log_in.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/input_register_layout.dart';
import 'package:flutter/material.dart';

class SecondSubPage extends StatefulWidget {
  const SecondSubPage({super.key});

  @override
  State<SecondSubPage> createState() => _SecondSubPageState();
}

class _SecondSubPageState extends State<SecondSubPage> {
  final FocusNode phoneFocusNode = FocusNode(), emailFocusNode = FocusNode();
  final TextEditingController phoneEditingController = TextEditingController(),
      emailEditingController = TextEditingController();
  @override
  void dispose() {
    phoneFocusNode.dispose();
    phoneEditingController.dispose();
    emailFocusNode.dispose();
    emailEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        height: MediaQuery.of(context).size.height,
    child:Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: <Widget>[
        const SizedBox(height: 24),
        InputRegisterLayout(
          textEditingController: phoneEditingController,
          title: "Введіть номер телефону*",
          focusNode: phoneFocusNode,
          useCancelButton: false,
          obscureText: false,
          textInputAction: TextInputAction.next,
          inputLayouts: InputLayouts.phone,
          focusOtherField: () {
            phoneFocusNode.unfocus();
            FocusScope.of(context).requestFocus(emailFocusNode);
          },
          textInputType: TextInputType.phone,
        ),
        const SizedBox(height: 24),
        InputRegisterLayout(
          textEditingController: emailEditingController,
          title: "Введіть електрону пошту*",
          focusNode: emailFocusNode,
          useCancelButton: false,
          obscureText: false,
          textInputAction: TextInputAction.done,
          inputLayouts: InputLayouts.email,
          focusOtherField: () {
            emailFocusNode.unfocus();
          },
          textInputType: TextInputType.emailAddress,
        ),
        const Spacer(),
        ContinueLogIn(
          name: "Продовжити",
          firstText: phoneEditingController.text,
          secondText: emailEditingController.text,
          firstFocusNode: phoneFocusNode,
          lastFocusNode: emailFocusNode,
        ),
        const Spacer(),
      ],
    ));
  }
}
