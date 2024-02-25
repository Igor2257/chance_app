import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/onboarding/onboarding_tutorial.dart';
import 'package:flutter/material.dart';

class OnboardingTutorialPageItem extends StatelessWidget {
  const OnboardingTutorialPageItem(
      {super.key,
      required this.image,
      required this.onboardingTutorialPages,
      required this.title,
      required this.subtitle});

  final String title, subtitle;
  final OnboardingTutorialPages onboardingTutorialPages;
  final Image image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children:[
        SizedBox(width: size.width,child: image,),
        Column(children: [

          const Spacer(),
          Container(
              padding: const EdgeInsets.only(
                  top: 40, right: 16, left: 16, bottom: 0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                color: beigeBG,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 32, color: primaryText),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryText,
                    ),
                  ),
                ],
              ))
        ]),
      ]
    );
  }
}