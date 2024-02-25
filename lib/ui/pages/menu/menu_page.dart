import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Меню",
          style: TextStyle(fontSize: 22, color: primaryText),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/");
          },
        ),
      ),
      backgroundColor: beigeBG,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            RoundedButton(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 4),
                border: Border.all(color: darkNeutral800),
                onPress: () async {
                  Navigator.of(context).pushNamed("/my_information");
                },
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Особиста інформація",
                      style: TextStyle(
                          fontSize: 16,
                          color: primaryText,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: primaryText,
                    )
                  ],
                )),

            const Spacer(),
            RoundedButton(
                margin: const EdgeInsets.symmetric(vertical: 4),
                onPress: () async {
                  await Repository().logout().then((value) {
                    if (value == null) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "/signinup", (route) => false);
                    }
                  });
                },
                color: primary1000,
                child: Text(
                  "Вийти з облікового запису",
                  style: TextStyle(
                      fontSize: 16,
                      color: primary50,
                      fontWeight: FontWeight.w500),
                )),
            SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}
