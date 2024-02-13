import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/bloc/registration_bloc/registration_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContinueLogIn extends StatelessWidget {
  const ContinueLogIn({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedButton(
            onPress: () {
              BlocProvider.of<RegistrationBloc>(context)
                  .add(IncreaseCurrentStep(context));
            },
            color: primary1000,
            child: Text(
              name,
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 16, color: primary50),
            )),
        TextButton(
            onPressed: () {},
            child: Text(
              "Вже маєте аккаунт? Увійти",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: primary700,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: primary700),
            )),
      ],
    );
  }
}
