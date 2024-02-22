

import 'package:chance_app/main.dart';
import 'package:chance_app/ui/components/custom_card.dart';
import 'package:chance_app/ui/components/custom_navigation_bar/custom_navigation_bar.dart';
import 'package:chance_app/ui/components/logo_name.dart';
import 'package:chance_app/ui/components/sos_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  late AndroidNotificationChannel _androidNotificationChannel;

  _requests(BuildContext context) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    ).then((settings) {
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      } else {
        _requests(context);
      }
      _loadFCM(context);
    });


  }

  _loadFCM(BuildContext context) async {
    if (!kIsWeb) {
      _androidNotificationChannel = const AndroidNotificationChannel(
          "myTasks", 'Завдання',
          importance: Importance.high, enableVibration: true, playSound: true);
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_androidNotificationChannel);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      _listenFCM(context);
    }
  }

  _listenFCM(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("message.data");
      print(message.data.toString());
      print(message.notification.toString());
      print(message.category.toString());
      print(message.sentTime.toString());
      MyApp.addMessage(context, message);
      flutterLocalNotificationsPlugin.show(
          DateTime.now().millisecondsSinceEpoch~/1000,
          message.data["type"]=="task"?"Завдання":"",
          message.data["message"].toString(),
          NotificationDetails(
            android: AndroidNotificationDetails(_androidNotificationChannel.id,
                _androidNotificationChannel.name,
                icon: '@drawable/logo', autoCancel: false,fullScreenIntent: true),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardWidth=(size.width/2)-32;
    _requests(context);
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
                      Navigator.of(context).pushNamed(
                          "/reminders");

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
