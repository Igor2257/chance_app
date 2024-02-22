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
      body: Column(
        children: [
          RoundedButton(
              onPress: () async {
                await Repository().logout();
                Navigator.of(context).pushNamedAndRemoveUntil("/signinup", (route) => false);
              },
              color: primary1000,
              child: Text(
                "Вийти з облікового запису",
                style: TextStyle(fontSize: 16, color: primary50),
              )),
        ],
      ),
    );
  }
}
