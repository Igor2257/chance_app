import 'package:chance_app/ui/components/logo_name.dart';
import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/bloc/registration_bloc/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const LogoName(),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Спробуйте всі функції додатку безкоштовно протягом 30 днів",
              style: TextStyle(
                color: primaryText,
                fontSize: 16,letterSpacing: 0.5
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
                "Після завершення пробного періоду вартість користування додатком становитиме 10\$ / місяць",
                style: TextStyle(
                  color: primaryText,
                  fontSize: 16,letterSpacing: 0.5
                ),
                textAlign: TextAlign.center),
            const SizedBox(
              height: 55,
            ),
            Column(
              children: [
                RoundedButton(
                    onPress: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/", (route) => false);
                      BlocProvider.of<RegistrationBloc>(context)
                          .add(ClearData());
                    },
                    color: primary1000,
                    child: Text(
                      "Почати пробний період",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: primary50),
                    )),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Придбати підписку",
                      style: TextStyle(
                          decorationColor: primary700,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: primary700),
                    )),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
