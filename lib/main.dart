import 'dart:async';
import 'dart:io';

import 'package:chance_app/firebase_options.dart';
import 'package:chance_app/ui/components/ad_banner.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/l10n/app_localizations.dart';
import 'package:chance_app/ui/pages/doctor_appointment/doctor_appointment.dart';
import 'package:chance_app/ui/pages/documents/privacy_policy_page.dart';
import 'package:chance_app/ui/pages/job_search/job_search.dart';
import 'package:chance_app/ui/pages/main_page/main_page.dart';
import 'package:chance_app/ui/pages/menu/menu_page.dart';
import 'package:chance_app/ui/pages/menu/pages/my_information.dart';
import 'package:chance_app/ui/pages/menu/pages/select_language.dart';
import 'package:chance_app/ui/pages/navigation/add_ward/add_ward.dart';
import 'package:chance_app/ui/pages/navigation/invitations/check_my_invitation/check_my_invitation.dart';
import 'package:chance_app/ui/pages/navigation/invitations/enter_accept_code/enter_accept_code.dart';
import 'package:chance_app/ui/pages/navigation/my_wards/my_wards_guardians.dart';
import 'package:chance_app/ui/pages/navigation/navigation_page/navigation_page.dart';
import 'package:chance_app/ui/pages/onboarding/onboarding_page.dart';
import 'package:chance_app/ui/pages/onboarding/onboarding_tutorial.dart';
import 'package:chance_app/ui/pages/reminders_page/add_medicine_page/add_medicine_page.dart';
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
import 'package:chance_app/ui/pages/sos_page/delete_contact_sos.dart';
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
import 'package:chance_app/ux/helpers/app_router.dart';
import 'package:chance_app/ux/helpers/background_service_helper.dart';
import 'package:chance_app/ux/helpers/reminders_helper.dart';
import 'package:chance_app/ux/hive_crud.dart';
import 'package:chance_app/ux/internet_connection_stream.dart';
import 'package:chance_app/ux/model/product_model.dart';
import 'package:chance_app/ux/model/settings.dart';
import 'package:chance_app/ux/repository/navigation_repository.dart';
import 'package:chance_app/ux/repository/user_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart'
    show GoogleMapsFlutterPlatform;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jiffy/jiffy.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final GoogleMapsFlutterPlatform platform = GoogleMapsFlutterPlatform.instance;
  // Default to Hybrid Composition for the example.
  if (Platform.isAndroid) {
    (platform as GoogleMapsFlutterAndroid).useAndroidViewSurface = true;
  }
  FlutterError("some error");
  initializeMapRenderer();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    if (!kDebugMode) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    }
    return false;
  };

  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);

  await HiveCRUD().initialize().then((value) async {
    await Supabase.initialize(
            url: "https://tnvxszbqdurbkpnvjvgz.supabase.co",
            anonKey:
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRudnhzemJxZHVyYmtwbnZqdmd6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA4NDU5NjUsImV4cCI6MjAyNjQyMTk2NX0.I_Tf2UAA5Qo05EOSR2HXkv9yMun2NyixOZtCyr3OvoA")
        .then((value) async {
      //value.client.from("invitations").select().match(query)
      await NavigationRepository().isAppShouldSentLocation();
      await Permission.notification.request();
      await RemindersHelper.initialize();
      await BackgroundServiceHelper.initialize();

      if ((!HiveCRUD().setting.blockAd)) {
        unawaited(MobileAds.instance.initialize());
      }

      try {
        timeago.setLocaleMessages(AppLocalizations.instance.locale.languageCode,
            timeago.UkMessages());
      } catch (e) {
        FlutterError(e.toString());
      }
    });
  }).whenComplete(() async {
    String route = "/onboarding_page";
    UserRepository repository = UserRepository();
    if (await repository.isUserEnteredEarlier()) {
      await repository.getUser().then((user) async {
        route = "/signinup";
        if (user != null) {
          route = "/";
        } else {
          await repository.getCookie().then((value) {
            if (value != null) {
              route = "/";
            }
          });
        }
      });
    } else {
      route = "/onboarding_page";
    }

    runApp(MyApp(route));
  });
}

Completer<AndroidMapRenderer?>? _initializedRendererCompleter;

Future<AndroidMapRenderer?> initializeMapRenderer() async {
  if (_initializedRendererCompleter != null) {
    return _initializedRendererCompleter!.future;
  }

  final Completer<AndroidMapRenderer?> completer =
      Completer<AndroidMapRenderer?>();
  _initializedRendererCompleter = completer;

  final GoogleMapsFlutterPlatform platform = GoogleMapsFlutterPlatform.instance;
  if (Platform.isAndroid) {
    try {
      unawaited((platform as GoogleMapsFlutterAndroid)
          .initializeWithRenderer(AndroidMapRenderer.latest)
          .then((AndroidMapRenderer initializedRenderer) =>
              completer.complete(initializedRenderer)));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  return completer.future;
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
  late InternetConnectionStream internetConnectionStream;
  final Settings settings = HiveCRUD().setting;
  late String route;

  void restartApp() async {
    UserRepository repository = UserRepository();
    if (await repository.isUserEnteredEarlier()) {
      await repository.getUser().then((user) async {
        route = "/signinup";
        if (user != null) {
          route = "/";
        } else {
          await repository.getCookie().then((value) {
            ///TODO: проверить как это работает, чтобы при логауте и перезагрузки не кидало сюда опять
            if (value != null) {
              route = "/";
            }
          });
        }
      });
    } else {
      route = "/onboarding_page";
    }
    setState(() {
      key = UniqueKey();
    });
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
    route = widget.route;
    internetConnectionStream = InternetConnectionStream(setState);
    try {
      checkIfDocsAreAvailable();
    } catch (e) {
      FlutterError("Error ${e.toString()}");
    }
  }

  checkIfDocsAreAvailable() async {
    if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
      List<ProductModel> items = List.of(HiveCRUD().myItems);
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
          HiveCRUD().rewriteItems(newItems);
        }
      }
    }
  }

  adRemove(bool value) {
    Settings settings = HiveCRUD().setting;
    setState(() {
      if (value) {
        settings = settings.copyWith(blockAd: true);
        HiveCRUD().updateSettings(settings);
      } else {
        settings = settings.copyWith(blockAd: false);
        HiveCRUD().updateSettings(settings);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Builder(builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.noScaling),
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
                  SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Column(
                      children: [
                        Expanded(
                          child: KeyedSubtree(
                            key: key,
                            child: SizedBox(
                              width: size.width,
                              height: size.height,
                              child: MultiBlocProvider(
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
                                child: MaterialApp(
                                  debugShowCheckedModeBanner: false,
                                  theme: ThemeData(
                                      scaffoldBackgroundColor: beigeBG,
                                      dialogBackgroundColor: beigeBG,
                                      dialogTheme: const DialogTheme(
                                          backgroundColor: beigeBG,
                                          surfaceTintColor: beigeBG),
                                      colorScheme: ColorScheme.fromSeed(
                                          seedColor: primary400),
                                      useMaterial3: true,
                                      popupMenuTheme: const PopupMenuThemeData(
                                          color: beigeTransparent,
                                          surfaceTintColor: beigeTransparent)),
                                  supportedLocales: const [
                                    Locale('en'),
                                    Locale('uk'),
                                    Locale('ru'),
                                  ],
                                  onGenerateRoute: AppRouter.onGenerateRoute,
                                  localizationsDelegates: const [
                                    MyLocalizationsDelegate(),
                                    GlobalWidgetsLocalizations.delegate,
                                    GlobalCupertinoLocalizations.delegate,
                                    GlobalMaterialLocalizations.delegate,
                                  ],
                                  initialRoute: route,
                                  routes: {
                                    "/": (context) => const MainPage(),
                                    "/signinup": (context) =>
                                        const SignInUpPage(),
                                    "/registration": (context) =>
                                        const RegistrationPage(),
                                    "/login": (context) => const LoginPage(),
                                    "/enter_code": (context) =>
                                        const EnterCodeForRegister(),
                                    "/reminders": (context) =>
                                        const RemindersPage(),
                                    "/date_picker_for_tasks": (context) =>
                                        const CalendarTaskPage(),
                                    "/add_medicine": (context) => BlocProvider(
                                          create: (context) =>
                                              AddMedicineBloc(),
                                          child: const AddMedicinePage(),
                                        ),
                                    "/reset_password": (context) =>
                                        const ResetPassword(),
                                    "/tasks_for_today": (context) =>
                                        const TasksForToday(),
                                    "/menu": (context) => const MenuPage(),
                                    "/sos": (context) => const MainPageSos(),
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
                                    "/add_ward": (context) => const AddWard(),
                                    "/check_my_invitation": (context) =>
                                        const CheckMyInvitation(),
                                    "/enter_accept_code": (context) =>
                                        const EnterAcceptCode(),
                                    "/choose_language": (context) =>
                                        const ChooseLanguage(),
                                    "/my_wards": (context) =>
                                        const MyWardsGuardians(),
                                    "/doctor_appointment": (context) =>
                                        const DoctorAppointment(),
                                    "/job_search": (context) =>
                                        const JobSearch(),
                                    "/privacy_policy": (context) =>
                                        const PrivacyPolicyPage(),
                                  },
                                  builder: (context, child) {
                                    final locale =
                                        Localizations.localeOf(context);
                                    Jiffy.setLocale(locale.toLanguageTag());
                                    return child!;
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
                        ),
                        if (InternetConnectionStream.showInternetConnection)
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                .translate("connectionRestored")
                                            : AppLocalizations.instance
                                                .translate("noConnection"),
                                        style: const TextStyle(
                                            fontSize: 16, color: primary50),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        if (!settings.blockAd) const AdBanner(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
