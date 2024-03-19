import 'dart:async';

import 'package:chance_app/firebase_options.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ui/pages/add_medicine_page/add_medicine_page.dart';
import 'package:chance_app/ui/pages/main_page/main_page.dart';
import 'package:chance_app/ui/pages/menu/menu_page.dart';
import 'package:chance_app/ui/pages/menu/pages/my_information.dart';
import 'package:chance_app/ui/pages/menu/pages/select_language.dart';
import 'package:chance_app/ui/pages/navigation/add_ward/add_ward.dart';
import 'package:chance_app/ui/pages/navigation/invitations/check_my_invitation/check_my_invitation.dart';
import 'package:chance_app/ui/pages/navigation/invitations/enter_accept_code/enter_accept_code.dart';
import 'package:chance_app/ui/pages/navigation/navigation_page/navigation_page.dart';
import 'package:chance_app/ui/pages/onboarding/onboarding_page.dart';
import 'package:chance_app/ui/pages/onboarding/onboarding_tutorial.dart';
import 'package:chance_app/ui/pages/reminders_page/reminders_page.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/calendar_task_page.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/tasks_for_today.dart';
import 'package:chance_app/ui/pages/sign_in_up/log_in/log_in_page.dart';
import 'package:chance_app/ui/pages/sign_in_up/log_in/reset_password.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/enter_code_for_register.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/registration_page.dart';
import 'package:chance_app/ui/pages/sign_in_up/sign_in_up_page.dart';
import 'package:chance_app/ui/pages/sos_page/add_contact_screen.dart';
import 'package:chance_app/ui/pages/sos_page/add_group_screen.dart';
import 'package:chance_app/ui/pages/sos_page/delete_contact_screen.dart';
import 'package:chance_app/ui/pages/sos_page/main_page_sos.dart';
import 'package:chance_app/ui/pages/sos_page/replace_contact_sos.dart';
import 'package:chance_app/ux/bloc/add_medicine_bloc/add_medicine_bloc.dart';
import 'package:chance_app/ux/bloc/add_task_bloc/add_task_bloc.dart';
import 'package:chance_app/ux/bloc/login_bloc/login_bloc.dart';
import 'package:chance_app/ux/bloc/navigation_bloc/add_ward/add_ward_bloc.dart';
import 'package:chance_app/ux/bloc/navigation_bloc/invitation_bloc/invitation_bloc.dart';
import 'package:chance_app/ux/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:chance_app/ux/bloc/registration_bloc/registration_bloc.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:chance_app/ux/bloc/sos_contacts_bloc/sos_contacts_bloc.dart';
import 'package:chance_app/ux/helpers/ad_helper.dart';
import 'package:chance_app/ux/helpers/background_service_helper.dart';
import 'package:chance_app/ux/helpers/reminders_helper.dart';
import 'package:chance_app/ux/hive_crum.dart';
import 'package:chance_app/ux/internet_connection_stream.dart';
import 'package:chance_app/ux/model/product_model.dart';
import 'package:chance_app/ux/model/settings.dart';
import 'package:chance_app/ux/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jiffy/jiffy.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    if (!kDebugMode) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    }
    return false;
  };

  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
  FirebaseAuth.instance.idTokenChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });

  await HiveCRUM().initialize().then((value) async {
    await Permission.notification.request();
    await RemindersHelper.initialize();
    await BackgroundServiceHelper.initialize();

    if ((!HiveCRUM().setting.blockAd)) {
      unawaited(MobileAds.instance.initialize());
    }
    UserRepository repository = UserRepository();
    if (await repository.isUserEnteredEarlier()) {
      await repository.getUser().then((user) async {
        String route = "/signinup";
        if (user != null) {
          route = "/";
          runApp(MyApp(route));
        } else {
          await repository.getCookie().then((value) {
            if (value != null) {
              route = "/";
            }
            runApp(MyApp(route));
          });
        }
      });
    } else {
      runApp(const MyApp("/onboarding_page"));
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp(this.route, {super.key});

  final String route;
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<MyAppState>()!.restartApp();
  }

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Key key = UniqueKey();
  bool isBannerLoad = false;
  BannerAd? bannerAd;
  late InternetConnectionStream internetConnectionStream;
  final Settings settings = HiveCRUM().setting;
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
    try {
      if (!settings.blockAd) initAd();
    } catch (e) {
      FlutterError("Error ${e.toString()}");
    }
    try {
      checkIfDocsAreAvailable();
    } catch (e) {
      FlutterError(e.toString());
    }
    Fluttertoast.showToast(
        msg: AppLocalizations.instance.translate("languageHaveChanged"));
  }

  @override
  void initState() {
    super.initState();
    internetConnectionStream = InternetConnectionStream(setState);
    try {
      if (!settings.blockAd) initAd();
    } catch (e) {
      FlutterError("Error ${e.toString()}");
    }
    try {
      checkIfDocsAreAvailable();
    } catch (e) {
      FlutterError("Error ${e.toString()}");
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (bannerAd != null) {
      bannerAd!.dispose();
    }
  }

  initAd() {
    if (bannerAd != null) {
      bannerAd!.dispose();
    }
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerMainScreen,
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            isBannerLoad = true;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (ad, error) {
            debugPrint('BannerAd failed to load: $error');
            ad.dispose();
          },
        ),
        request: const AdRequest());
    bannerAd!.load();
    print("object");
  }

  checkIfDocsAreAvailable() async {
    List<ProductModel> items = List.of(HiveCRUM().myItems);
    if (items.isNotEmpty) {
      List<ProductModel> newItems = [];
      for (int i = 0; i < items.length; i++) {
        if (items[i].validity != null) {
          if (items[i].id == "adblocker") {
            if (items[i].validity!.isAfter(DateTime.now())) {
              adRemove(true);
            } else {
              adRemove(false);
            }
          }

          if (items[i].validity!.isAfter(DateTime.now())) {
            newItems.add(items[i]);
          }
        }
      }
      if (newItems != items) {
        HiveCRUM().rewriteItems(newItems);
      }
    }
  }

  adRemove(bool value) async {
    Settings settings = HiveCRUM().setting;
    if (value) {
      settings = settings.copyWith(blockAd: true);
      HiveCRUM().updateSettings(settings);
      if (bannerAd != null) {
        bannerAd!.dispose();
      }
    } else {
      settings = settings.copyWith(blockAd: false);
      HiveCRUM().updateSettings(settings);
      initAd();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RegistrationBloc(),
          ),
          BlocProvider(
            create: (context) => LoginBloc(),
          ),
          BlocProvider(
            create: (context) => RemindersBloc(),
          ),
          BlocProvider(
            create: (context) => SosContactsBloc(),
          ),
          BlocProvider(
            create: (context) => NavigationBloc(),
          ),
          BlocProvider(
            create: (context) => AddWardBloc(),
          ),
          BlocProvider(
            create: (context) => AddTaskBloc(),
          ),
          BlocProvider(
            create: (context) => InvitationBloc(),
          ),
        ],
        child: Builder(builder: (context) {
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.noScaling),
              child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: FGBGNotifier(
                      onEvent: (event) {
                        if (FGBGType.background == event ||
                            AppLifecycleState.inactive.name == event.name ||
                            AppLifecycleState.paused.name == event.name) {
                          internetConnectionStream.pause();
                        } else if (FGBGType.foreground == event ||
                            AppLifecycleState.resumed.name == event.name) {
                          internetConnectionStream.resume();
                        }
                        setState(() {});
                      },
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: KeyedSubtree(
                                  key: key,
                                  child: SizedBox(
                                    width: size.width,
                                    height: size.height,
                                    child: MaterialApp(
                                      debugShowCheckedModeBanner: false,
                                      theme: ThemeData(
                                          scaffoldBackgroundColor: beigeBG,
                                          dialogBackgroundColor: beigeBG,
                                          dialogTheme: DialogTheme(
                                              backgroundColor: beigeBG,
                                              surfaceTintColor: beigeBG),
                                          colorScheme: ColorScheme.fromSeed(
                                              seedColor: primary400),
                                          useMaterial3: true,
                                          popupMenuTheme: PopupMenuThemeData(
                                              color: beigeTransparent,
                                              surfaceTintColor:
                                                  beigeTransparent)),
                                      supportedLocales: const [
                                        Locale('uk'),
                                      ],
                                      localizationsDelegates: const [
                                        MyLocalizationsDelegate(),
                                        GlobalWidgetsLocalizations.delegate,
                                        GlobalCupertinoLocalizations.delegate,
                                        GlobalMaterialLocalizations.delegate,
                                      ],
                                      builder: (context, child) {
                                        final locale =
                                            Localizations.localeOf(context);
                                        Jiffy.setLocale(locale.toLanguageTag());
                                        return child!;
                                      },
                                      initialRoute: widget.route,
                                      routes: {
                                        "/": (context) => const MainPage(),
                                        "/signinup": (context) =>
                                            const SignInUpPage(),
                                        "/registration": (context) =>
                                            const RegistrationPage(),
                                        "/login": (context) =>
                                            const LoginPage(),
                                        "/enter_code": (context) =>
                                            const EnterCodeForRegister(),
                                        "/reminders": (context) =>
                                            const RemindersPage(),
                                        "/date_picker_for_tasks": (context) =>
                                            const CalendarTaskPage(),
                                        "/add_medicine": (context) =>
                                            BlocProvider(
                                              create: (context) =>
                                                  AddMedicineBloc(),
                                              child: const AddMedicinePage(),
                                            ),
                                        "/reset_password": (context) =>
                                            const ResetPassword(),
                                        "/tasks_for_today": (context) =>
                                            const TasksForToday(),
                                        "/menu": (context) => const MenuPage(),
                                        "/sos": (context) =>
                                            const MainPageSos(),
                                        "/add_contact": (context) =>
                                            const AddContactScreen(),
                                        "/add_group": (context) =>
                                            const AddGroupScreen(),
                                        "/onboarding_page": (context) =>
                                            const OnboardingPage(),
                                        "/onboarding_tutorial": (context) =>
                                            const OnboardingTutorial(),
                                        "/delete_contact_sos": (context) =>
                                            const DeleteContactsPage(),
                                        "/my_information": (context) =>
                                            const MyInformation(),
                                        "/replace_contact_sos": (context) =>
                                            const ReplaceContactSosScreen(),
                                        "/navigation_page": (context) =>
                                            const NavigationPage(),
                                        "/add_ward": (context) =>
                                            const AddWard(),
                                        "/check_my_invitation": (context) =>
                                            const CheckMyInvitation(),
                                        "/enter_accept_code": (context) =>
                                            const EnterAcceptCode(),
                                        "/choose_language": (context) =>
                                            const ChooseLanguage(),
                                      },
                                      localeResolutionCallback:
                                          (locale, supportedLocales) {
                                        for (Locale supportedLocale
                                            in supportedLocales) {
                                          if (supportedLocale.languageCode ==
                                                  locale?.languageCode ||
                                              supportedLocale.countryCode ==
                                                  locale?.countryCode) {
                                            return supportedLocale;
                                          }
                                        }

                                        return supportedLocales.first;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              if (InternetConnectionStream
                                  .showInternetConnection)
                                Container(
                                  color: beigeBG,
                                  child: SafeArea(
                                      top: false,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: InternetConnectionStream
                                                    .isUserHaveInternetConnection
                                                ? green
                                                : darkNeutral1000),
                                        height: 24,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              InternetConnectionStream
                                                      .isUserHaveInternetConnection
                                                  ? Icons.wifi
                                                  : Icons.wifi_off,
                                              color: primary50,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              InternetConnectionStream
                                                      .isUserHaveInternetConnection
                                                  ? AppLocalizations.instance
                                                      .translate(
                                                          "connectionRestored")
                                                  : AppLocalizations.instance
                                                      .translate(
                                                          "noConnection"),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: primary50),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              if (settings.blockAd == false &&
                                  isBannerLoad &&
                                  bannerAd != null)
                                Container(
                                    width: size.width,
                                    color: beigeBG,
                                    child: SafeArea(
                                        top: false,
                                        child: Center(
                                          child: SizedBox(
                                            height: bannerAd!.size.height
                                                .toDouble(),
                                            child: AdWidget(
                                              ad: bannerAd!,
                                            ),
                                          ),
                                        ))),
                            ],
                          ),
                        ],
                      ))));
        }));
  }
}
