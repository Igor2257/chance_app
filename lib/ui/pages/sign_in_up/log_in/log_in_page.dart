import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/sign_in_up/log_in/input_login_layout.dart';
import 'package:chance_app/ux/bloc/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final FocusNode phoneFocusNode = FocusNode(), passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text("Вхід"),
      ),
      backgroundColor: beigeBG,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 24),
            InputLoginLayout(
                title: "Введіть номер телефону*",
                focusNode: phoneFocusNode,
                obscureText: false,
                textInputAction: TextInputAction.next,
                inputLoginLayouts: InputLoginLayouts.phone,
                textInputType: TextInputType.phone),
            const SizedBox(height: 24),
            InputLoginLayout(
                title: "Введіть номер телефону*",
                focusNode: passwordFocusNode,
                obscureText: true,
                textInputAction: TextInputAction.done,
                inputLoginLayouts: InputLoginLayouts.password,
                textInputType: TextInputType.text),
            const Spacer(),
            RoundedButton(
                onPress: () {
                  BlocProvider.of<LoginBloc>(context)
                      .add(ValidateForm(context: context));
                },
                color: primary1000,
                child: Text(
                  "Увійти",
                  style: TextStyle(
                      color: primary50,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                )),
            const SizedBox(height: 24),
            GestureDetector(
                onTap: () {},
                child: SizedBox(
                  height: 44,
                  child: Center(
                    child: Text(
                      "Не маєте облікового запису? Створити",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: primary700,
                          letterSpacing: 0.5,
                          color: primary700,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )),
            const SizedBox(height: 24),
            GestureDetector(
                onTap: () {},
                child: SizedBox(
                  height: 44,
                  child: Center(
                    child: Text(
                      "Забули пароль?",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: primary700,
                          color: primary700,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
