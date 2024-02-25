import 'package:chance_app/ui/components/logo_name.dart';
import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: beigeBG,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            const Spacer(),
            const LogoName(),
            const SizedBox(height: 24.0),
            Text("Ласкаво просимо у світ без обмежень!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28.0, color: primaryText)),
            const Spacer(),
            RoundedButton(
              onPress: ()async{

                Navigator.of(context).pushNamedAndRemoveUntil("/onboarding_tutorial", (route) => true);
              await Repository().firstEnter();
                },
                color: primary1000,
                child: Text("Стартуємо",
                    style: TextStyle(fontSize: 22.0, color: primary50))),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 44,
                  child: Text("Вже є профіль?",
                      style: TextStyle(fontSize: 16.0, color: primary700)),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: ()async {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/login", (route) => false);
                    await Repository().firstEnter();
                  },
                  child: SizedBox(
                    height: 44,
                    child: Text("Увійти",
                        style: TextStyle(fontSize: 16.0, color: primary700,decorationColor: primary700,decoration: TextDecoration.underline)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
          ]),
        ));
  }
}
