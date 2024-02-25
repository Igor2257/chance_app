import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/sign_in_up/log_in/input_login_layout.dart';
import 'package:chance_app/ux/bloc/login_bloc/login_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final FocusNode emailFocusNode = FocusNode(), passwordFocusNode = FocusNode();
  final TextEditingController emailTextEditingController =
          TextEditingController(),
      passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            centerTitle: true,
            title: const Text("Вхід"),
            leading: BackButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/signinup", (route) => false);
              },
            )),
        backgroundColor: beigeBG,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 24),
              InputLoginLayout(
                title: "Введіть електронну пошту*",
                focusNode: emailFocusNode,
                obscureText: false,
                textInputAction: TextInputAction.next,
                inputLoginLayouts: InputLoginLayouts.email,
                focusOtherField: () {
                  print("object3");
                  emailFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
                textInputType: TextInputType.emailAddress,
                textEditingController: emailTextEditingController,
              ),
              const SizedBox(height: 24),
              InputLoginLayout(
                title: "Введіть пароль*",
                focusNode: passwordFocusNode,
                obscureText: true,
                textInputAction: TextInputAction.done,
                inputLoginLayouts: InputLoginLayouts.password,
                focusOtherField: () {
                  passwordFocusNode.unfocus();
                },
                textInputType: TextInputType.text,
                textEditingController: passwordTextEditingController,
              ),
              const Spacer(),
              RoundedButton(
                  onPress: () {
                    if (!state.isLoading) {
                      BlocProvider.of<LoginBloc>(context).add(ValidateForm(
                          context: context,
                          email: emailTextEditingController.text,
                          password: passwordTextEditingController.text));
                    }
                  },
                  color: primary1000,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state.isLoading)
                        CupertinoActivityIndicator(
                          color: primary50,
                          radius: 8,
                        ),
                      if (state.isLoading)
                        const SizedBox(
                          width: 5,
                        ),
                      Text(
                        "Увійти",
                        style: TextStyle(
                            color: primary50,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      if (state.isLoading)
                        const SizedBox(
                          width: 21,
                        ),
                    ],
                  )),
              const SizedBox(height: 24),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/registration", (route) => false);
                  },
                  child: SizedBox(
                    height: 44,
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Не маєте облікового запису?",
                          style: TextStyle(
                              letterSpacing: 0.5,
                              color: primary700,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Створити",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: primary700,
                                letterSpacing: 0.5,
                                color: primary700,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    )),
                  )),
              const SizedBox(height: 24),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/reset_password", (route) => true);
                  },
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
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )),
              const Spacer(),
            ],
          ),
        ),
      );
    });
  }
}
