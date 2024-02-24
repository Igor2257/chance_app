import 'dart:async';

import 'package:chance_app/firebase_options.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/add_medicine_page/add_medicine_page.dart';
import 'package:chance_app/ui/pages/main_page/main_page.dart';
import 'package:chance_app/ui/pages/menu/menu_page.dart';
import 'package:chance_app/ui/pages/reminders_page/reminders_page.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/calendar_task_page.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/tasks_for_today.dart';
import 'package:chance_app/ui/pages/sign_in_up/log_in/log_in_page.dart';
import 'package:chance_app/ui/pages/sign_in_up/log_in/reset_password.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/enter_code_for_register.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/registration_page.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/subscription_page.dart';
import 'package:chance_app/ui/pages/sign_in_up/sign_in_up_page.dart';
import 'package:chance_app/ui/pages/sos_page/add_contact_screen.dart';
import 'package:chance_app/ui/pages/sos_page/add_group_screen.dart';
import 'package:chance_app/ui/pages/sos_page/delete_contact_screen.dart';
import 'package:chance_app/ui/pages/sos_page/main_page_sos.dart';
import 'package:chance_app/ux/bloc/add_medicine_bloc/add_medicine_bloc.dart';
import 'package:chance_app/ux/bloc/login_bloc/login_bloc.dart';
import 'package:chance_app/ux/bloc/registration_bloc/registration_bloc.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:chance_app/ux/bloc/sos_contacts_bloc/sos_contacts_bloc.dart';
import 'package:chance_app/ux/model/me_user.dart';
import 'package:chance_app/ux/model/tasks_model.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart';
import 'package:timezone/timezone.dart';

enum Postpone {
  fiveMinute,
  tenMinute,
  fifteenMinute,
  thirtyMinute,
  oneHour,
  twoHour
}

void main() async {
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

  // Timezone setup, is required by scheduler
  final currentTimeZone = await FlutterTimezone.getLocalTimezone();
  initializeTimeZones();
  setLocalLocation(getLocation(currentTimeZone));

  await Permission.notification.request();

  await FlutterLocalNotificationsPlugin().initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    ),
  );

  await _initBoxes().then((value) async {
    await Repository().getUser().then((user) {
      String route = "/signinup";
      if (user != null) {
        route = "/";
      }
      runApp(MyApp(route));
    });
  });
}

class MyApp extends StatefulWidget {
  const MyApp(this.route, {super.key});

  static MyAppState? myAppState;
  final String route;

  static void addMessage(BuildContext context, RemoteMessage remoteMessage) {
    context.findAncestorStateOfType<MyAppState>()!.addMessage(remoteMessage);
  }

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Key key = UniqueKey();
  List<String> toasts = [];
  List<RemoteMessage> remoteMessages = [];

  void addMessage(RemoteMessage remoteMessage) {
    setState(() {
      remoteMessages.add(remoteMessage);
    });
  }

  @override
  void initState() {
    super.initState();
    MyApp.myAppState = this;
  }

  @override
  void dispose() {
    MyApp.myAppState = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
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
      ],
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            IgnorePointer(
              ignoring: remoteMessages.isNotEmpty,
              child: KeyedSubtree(
                key: key,
                child: MaterialApp(
                  title: 'Flutter Demo',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    useMaterial3: true,
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: darkNeutral600,
                      brightness: Brightness.light,
                    ),
                    appBarTheme: const AppBarTheme(
                      centerTitle: true,
                    ),
                  ),
                  supportedLocales: const [
                    Locale('en'),
                    Locale('uk'),
                    Locale('ru'),
                  ],
                  localizationsDelegates: const [
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                  ],
                  initialRoute: widget.route,
                  routes: {
                    "/": (context) => const MainPage(),
                    "/signinup": (context) => const SignInUpPage(),
                    "/registration": (context) => const RegistrationPage(),
                    "/login": (context) => LoginPage(),
                    "/enter_code": (context) => const EnterCodeForRegister(),
                    "/subscription_page": (context) => const SubscriptionPage(),
                    "/reminders": (context) => const RemindersPage(),
                    "/date_picker_for_tasks": (context) =>
                        const CalendarTaskPage(),
                    "/add_medicine": (context) => BlocProvider(
                          create: (context) => AddMedicineBloc(),
                          child: const AddMedicinePage(),
                        ),
                    "/reset_password": (context) => const ResetPassword(),
                    "/tasks_for_today": (context) => const TasksForToday(),
                    "/menu": (context) => const MenuPage(),
                    "/sos": (context) => const MainPageSos(),
                    "/add_contact": (context) => const AddContactScreen(),
                    "/add_group": (context) => const AddGroupScreen(),
                    "/delete_contact": (context) => const DeleteContactsPage(),
                  },
                ),
              ),
            ),
            if (remoteMessages.isNotEmpty)
              Container(
                color: Colors.black38,
                child: Center(
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: beige100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/tasks_big.svg",
                                color: beige500,
                              ),
                              Text(
                                "Завдання",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: primaryText,
                                ),
                              ),
                              Text(
                                remoteMessages.first.data["message"],
                                style: TextStyle(
                                  fontSize: 24,
                                  color: primaryText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: darkNeutral800,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    remoteMessages.removeAt(0);
                                  });
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
                                          border: Border.all(color: primary300),
                                        ),
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
                                        "Пропустити",
                                        style: TextStyle(
                                          color: primary50,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    await Repository()
                                        .updateTask(
                                            id: remoteMessages.first.data["id"]
                                                .toString(),
                                            isDone: true)
                                        .then((value) {
                                      if (value == null) {
                                        setState(() {
                                          remoteMessages.removeAt(0);
                                        });
                                      }
                                    });
                                  } catch (e) {
                                    print(e);
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
                                          color: primary300,
                                        ),
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
                                        "Виконано",
                                        style: TextStyle(
                                          color: primary50,
                                          fontSize: 16,
                                        ),
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
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Box? tasksBox;
Box? userBox;

Future<bool> _initBoxes() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  //await Repository().deleteCookie();
  //await Hive.deleteBoxFromDisk('user');
  Hive.registerAdapter(MeUserAdapter());
  Hive.registerAdapter(TaskModelAdapter());
  tasksBox = await Hive.openBox<TaskModel>("myTasks");
  userBox = await Hive.openBox<MeUser>("user");

  return true;
}
