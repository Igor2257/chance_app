import 'package:chance_app/ui/components/custom_card.dart';
import 'package:chance_app/ui/components/custom_navigation_bar/custom_navigation_bar.dart';
import 'package:chance_app/ui/components/logo_name.dart';
import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/components/sos_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ux/repository/tasks_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  _listenFCM() async {
    showDialog(
          context: context,
          builder: (context) {
            Size size = MediaQuery.of(context).size;
            return Container(
                color: Colors.black38,
                child: Center(
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                        color: beige100,
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/tasks_big.svg",
                                color: beige500,
                              ),
                              Text(
                                AppLocalizations.instance.translate("tasks"),textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 16, color: primaryText),
                              ),
                              Text(
                                'remoteMessage.data["message"]',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 24, color: primaryText),
                            ),
                            ],
                          ),
                        ),
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: darkNeutral800),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: SizedBox(
                                  width: size.width / 4,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 56,
                                        width: 56,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(90),
                                            border:
                                                Border.all(color: primary300)),
                                        child: Center(
                                          child: Icon(
                                            Icons.close,
                                            color: primary50,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        AppLocalizations.instance.translate("miss"),textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: primary50, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    // await TasksRepository()
                                    //     .updateTask(
                                    //         id: remoteMessage.data["id"]
                                    //             .toString(),
                                    //         isDone: true)
                                    //     .then((value) {
                                    //   if (value == null) {
                                    //     Navigator.of(context).pop();
                                    //   }
                                    // });
                                  } catch (e) {
                                    Fluttertoast.showToast(msg: e.toString());
                                  }
                                },
                                child: SizedBox(
                                  width: size.width / 4,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 56,
                                        width: 56,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(90),
                                            color: primary300),
                                        child: Center(
                                          child: Icon(
                                            Icons.done,
                                            color: primaryText,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        AppLocalizations.instance.translate("done"),textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: primary50, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ));
        });
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardWidth = (size.width / 2) - 32;

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
                      AppLocalizations.instance.translate("reminder"),
                      style: TextStyle(color: primaryText),
                    ),
                    width: cardWidth,
                    margin: const EdgeInsets.only(bottom: 8, top: 8, right: 8),
                    onPress: () async {
                      Navigator.of(context).pushNamedAndRemoveUntil("/reminders", (route) => true);
                    },
                  ),
                  CustomCard(
                    icon: Image.asset(
                      "assets/menu_icons/navigation.png",
                      height: 45,
                      width: 45,
                    ),
                    text: Text(
                      AppLocalizations.instance.translate("navigation"),
                      style: TextStyle(color: primaryText),
                    ),
                    width: cardWidth,
                    margin: const EdgeInsets.only(bottom: 8, top: 8, left: 8),
                    onPress: () async {
                      await checkLocationPermission(context).then((value) {
                        if (value) {
                          Navigator.of(context).pushNamed("/navigation_page");
                        }
                      });
                    },
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
                      AppLocalizations.instance.translate("communication"),
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
                      AppLocalizations.instance.translate("appointmentWithDoctor"),
                      style: TextStyle(color: primaryText),
                    ),
                    width: cardWidth,
                    margin: const EdgeInsets.only(bottom: 8, top: 8, left: 8),
                    onPress: () {
                      Navigator.of(context).pushNamed("/doctor_appointment");
                    },
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
                  AppLocalizations.instance.translate("jobSearch"),
                  style: TextStyle(color: primaryText),
                ),
                width: cardWidth,
                margin: const EdgeInsets.only(bottom: 8, top: 8),
                onPress: () {
                  Navigator.of(context).pushNamed("/job_search");
                },
              ),
              const Spacer(),
              const Spacer(),
            ],
          ),
        ));
  }

  Future<bool> checkLocationPermission(BuildContext context) async {
    bool isOkay = false;
    await Permission.location.request().then((status) async {
      if (status != PermissionStatus.denied &&
          status != PermissionStatus.permanentlyDenied) {
        isOkay = true;
      }
      if (!isOkay) {
        if (mounted) {
          await showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    AppLocalizations.instance.translate("allowTheAppToUseTheLocation"),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, color: primaryText),
                  ),
                  content: Text(
                    AppLocalizations.instance.translate("forTheAppToWorkCorrectlyYouNeedToAllowThisPermissionToBeUsed"),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: primaryText),
                  ),
                  actions: [
                    RoundedButton(
                      onPress: () async {
                        await Geolocator.openAppSettings().whenComplete(() {
                          if (mounted) {
                            Navigator.of(context).pop();
                          }
                        });

                        return true;
                      },
                      color: primary1000,
                      child: Text(
                        AppLocalizations.instance.translate("goTo"),
                        style: TextStyle(color: primary50),
                      ),
                    ),
                  ],
                );
              });
        }
      }
    });

    return isOkay;
  }
}
