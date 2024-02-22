import 'package:chance_app/firebase_options.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/main_page/main_page.dart';
import 'package:chance_app/ui/pages/reminders_page/reminders_page.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/calendar_task_page.dart';
import 'package:chance_app/ui/pages/reminders_page/tasks/tasks_for_today.dart';
import 'package:chance_app/ui/pages/sign_in_up/log_in/log_in_page.dart';
import 'package:chance_app/ui/pages/sign_in_up/log_in/reset_password.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/enter_code_for_register.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/registration_page.dart';
import 'package:chance_app/ui/pages/sign_in_up/registration/subscription_page.dart';
import 'package:chance_app/ui/pages/sign_in_up/sign_in_up_page.dart';
import 'package:chance_app/ux/bloc/login_bloc/login_bloc.dart';
import 'package:chance_app/ux/bloc/registration_bloc/registration_bloc.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:chance_app/ux/model/me_user.dart';
import 'package:chance_app/ux/model/tasks_model.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    if (!kDebugMode) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    }
    return false;
  };

  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);

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
  RemoteMessage? remoteMessage;

  void addMessage(RemoteMessage remoteMessage) {
    setState(() {
      key = UniqueKey();
    });
    this.remoteMessage = remoteMessage;
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
        ],
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Stack(
              children: [
                IgnorePointer(
                  ignoring: remoteMessage != null,
                  child: KeyedSubtree(
                      key: key,
                      child: SizedBox(
                          width: size.width,
                          height: size.height,
                          child: MaterialApp(
                            title: 'Flutter Demo',
                            debugShowCheckedModeBanner: false,
                            theme: ThemeData(
                              colorScheme: ColorScheme.fromSeed(
                                  seedColor: Colors.deepPurple),
                              useMaterial3: true,
                            ),
                            initialRoute: widget.route,
                            routes: {
                              "/": (context) => const MainPage(),
                              "/signinup": (context) => const SignInUpPage(),
                              "/registration": (context) =>
                                  const RegistrationPage(),
                              "/login": (context) => LoginPage(),
                              "/enter_code": (context) =>
                                  const EnterCodeForRegister(),
                              "/subscription_page": (context) =>
                                  const SubscriptionPage(),
                              "/reminders": (context) => const RemindersPage(),
                              "/date_picker_for_tasks": (context) =>
                                  const CalendarTaskPage(),
                              "/reset_password": (context) =>
                                  const ResetPassword(),
                              "/tasks_for_today": (context) =>
                                  const TasksForToday(),
                            },
                          ))),
                ),
                if (remoteMessage != null)
                  Center(
                    child: Container(
                      width: size.width,
                      height: size.height / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)),
                      padding:
                          const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      margin:
                          const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/tasks_big.svg",
                            color: beige500,
                          ),
                          Text(
                            "Завдання",
                            style: TextStyle(fontSize: 16, color: primaryText),
                          ),
                          Text(
                            remoteMessage!.data["message"],
                            style: TextStyle(fontSize: 24, color: primaryText),
                          ),

                        ],
                      ),
                    ),
                  )
              ],
            )));
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

