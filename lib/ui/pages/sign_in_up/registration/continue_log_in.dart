import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/bloc/registration_bloc/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContinueLogIn extends StatefulWidget {
  const ContinueLogIn({
    super.key,
    required this.name,
    required this.firstTextEditingController,
    required this.secondTextEditingController,
    required this.firstFocusNode,
    required this.lastFocusNode,
  });

  final String name;
  final TextEditingController firstTextEditingController,
      secondTextEditingController;
  final FocusNode firstFocusNode, lastFocusNode;

  @override
  State<ContinueLogIn> createState() => _ContinueLogInState();
}

class _ContinueLogInState extends State<ContinueLogIn> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
      return Column(
        children: [
          RoundedButton(
              onPress: () {
                widget.firstFocusNode.unfocus();
                widget.lastFocusNode.unfocus();
                if (!state.isLoading) {
                  BlocProvider.of<RegistrationBloc>(context).add(
                      IncreaseCurrentStep(
                          context: context,
                          first: widget.firstTextEditingController.text,
                          second: widget.secondTextEditingController.text));
                }
              },
              color: state.isLoading ? darkNeutral1000 : primary1000,
              child: Text(
                widget.name,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: primary50),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Вже маєте аккаунт?",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: state.isLoading ? primary1000 : primary700),
              ),
              TextButton(
                  onPressed: () {
                    widget.firstFocusNode.unfocus();
                    widget.lastFocusNode.unfocus();
                    if (!state.isLoading) {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/login", (route) => false);
                    }
                  },
                  child: Text(
                    "Увійти",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: primary700,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: state.isLoading ? primary1000 : primary700),
                  )),
            ],
          )
        ],
      );
    });
  }
}
