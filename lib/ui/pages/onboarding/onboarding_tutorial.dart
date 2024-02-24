import 'package:flutter/material.dart';
enum OnboardingTutorialPages {first, second, third, fourth, fifth, sixth}


class OnboardingTutorial extends StatefulWidget {
  const OnboardingTutorial({super.key});

  @override
  State<OnboardingTutorial> createState() => _OnboardingTutorialState();
}

class _OnboardingTutorialState extends State<OnboardingTutorial> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: beigeBG,
    );
  }
}
