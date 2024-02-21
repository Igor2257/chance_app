import 'package:chance_app/firebase_options.dart';
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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

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

  // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
  await _requests();

  await _initBoxes().then((value) async {
    await Repository().getUser().then((user) {
      String route = "/signinup";
      print(user);
      if (user != null) {
        route = "/";
      }
      runApp(MyApp(route));
    });
  });
}

class MyApp extends StatelessWidget {
  const MyApp(this.route, {super.key});
final String route;
  @override
  Widget build(BuildContext context) {
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
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: route,
          routes: {
            "/": (context) => const MainPage(),
            "/signinup": (context) => const SignInUpPage(),
            "/registration": (context) => const RegistrationPage(),
            "/login": (context) => LoginPage(),
            "/enter_code": (context) => const EnterCodeForRegister(),
            "/subscription_page": (context) => const SubscriptionPage(),
            "/reminders": (context) => const RemindersPage(),
            "/date_picker_for_tasks": (context) => const CalendarTaskPage(),
            "/reset_password": (context) => const ResetPassword(),
            "/tasks_for_today": (context) => const TasksForToday(),
          },
        ));
  }
}

Box? tasksBox;
Box? userBox;

Future<bool> _initBoxes() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  //await Hive.deleteBoxFromDisk('myTasks');
  Hive.registerAdapter(MeUserAdapter());
  Hive.registerAdapter(TaskModelAdapter());
  tasksBox = await Hive.openBox<TaskModel>("myTasks");
  userBox = await Hive.openBox<MeUser>("user");

  return true;
}

late AndroidNotificationChannel _androidNotificationChannel;

_requests() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  } else {
    _requests();
  }
  _loadFCM();
}

_loadFCM() async {
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
    _listenFCM();
  }
}

_listenFCM() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
print("object");
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
