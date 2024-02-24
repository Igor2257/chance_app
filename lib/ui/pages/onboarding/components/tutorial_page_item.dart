import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/onboarding/onboarding_tutorial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TutorialPageItem extends StatelessWidget {
  const TutorialPageItem(
      {super.key,
      required this.image,
      required this.onboardingTutorialPages,
      required this.title,
      required this.subtitle});

  final String image, title, subtitle;
  final OnboardingTutorialPages onboardingTutorialPages;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(image),
        Column(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                GestureDetector(
                  child: Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        color: beigeTransparent),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: primaryText,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: beigeTransparent),
                    child: Center(
                      child: Text(
                        'Пропустити',
                        style: TextStyle(fontSize: 16, color: primaryText),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
              decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            color: beigeBG,
          ),
          child: Column(children: [Text(title, style: TextStyle(fontSize: 32, color: primaryText), ), Text(subtitle, style: TextStyle(fontSize: 16, color: primaryText),), RoundedButton(color: primary1000, child:Text(onboardingTutorialPages == Далі) )],))
        ]),
      ],
    );
  }
}
