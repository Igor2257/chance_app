import 'package:chance_app/ui/components/custom_card.dart';
import 'package:chance_app/ui/components/custom_navigation_bar/custom_navigation_bar.dart';
import 'package:chance_app/ui/components/logo_name.dart';
import 'package:chance_app/ui/components/sos_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardWidth=(size.width/2)-32;
    return Scaffold(
        backgroundColor: beigeBG,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const SosButton(),
        bottomNavigationBar: const CustomNavigationBar(),
        body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              const LogoName(),
              const Spacer(),
              Row(
                children: [
                  CustomCard(
                    icon: Image.asset(
                      "assets/menu_icons/reminders.png",
                      height: 44,
                      width: 44,
                    ),
                    text: Text(
                      "Нагадування",
                      style: TextStyle(color: primaryText),
                    ),
                    width: cardWidth,
                    margin: const EdgeInsets.only(bottom: 8, top: 8, right: 8),
                    onPress: ()async {
                      await Repository().getTasks().whenComplete(() {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/reminders", (route) => true);
                      });

                    },
                  ),
                  CustomCard(
                    icon: Image.asset(
                      "assets/menu_icons/navigation.png",
                      height: 45,
                      width: 45,
                    ),
                    text: Text(
                      "Навігація",
                      style: TextStyle(color: primaryText),
                    ),
                    width: cardWidth,
                    margin: const EdgeInsets.only(bottom: 8, top: 8, left: 8),
                    onPress: () {},
                  ),
                ],
              ),
              Row(
                children: [
                  CustomCard(
                    icon: Image.asset(
                      "assets/menu_icons/chat.png",
                      height: 44,
                      width: 44,
                    ),
                    text: Text(
                      "Спілкування",
                      style: TextStyle(color: primaryText),
                    ),
                    width: cardWidth,
                    margin: const EdgeInsets.only(bottom: 8, top: 8, right: 8),
                    onPress: () {},
                  ),
                  CustomCard(
                    icon: Image.asset(
                      "assets/menu_icons/appointment.png",
                      height: 44,
                      width: 44,
                    ),
                    text: Text(
                      "Запис до лікаря",
                      style: TextStyle(color: primaryText),
                    ),
                    width: cardWidth,
                    margin: const EdgeInsets.only(bottom: 8, top: 8, left: 8),
                    onPress: () {},
                  ),
                ],
              ),
              CustomCard(
                icon: Image.asset(
                  "assets/menu_icons/job_search.png",
                  height: 44,
                  width: 44,
                ),
                text: Text(
                  "Пошук роботи",
                  style: TextStyle(color: primaryText),
                ),
                width: cardWidth,
                margin: const EdgeInsets.only(bottom: 8, top: 8),
                onPress: () {},
              ),
              const Spacer(),
              const Spacer(),
            ],
          ),
        ));
  }
}
