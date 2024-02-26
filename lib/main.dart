import 'package:chance_app/firebase_options.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/add_medicine_page/add_medicine_page.dart';
import 'package:chance_app/ui/pages/main_page/main_page.dart';
import 'package:chance_app/ui/pages/menu/menu_page.dart';
import 'package:chance_app/ui/pages/menu/pages/my_information.dart';
import 'package:chance_app/ui/pages/onboarding/onboarding_page.dart';
import 'package:chance_app/ui/pages/onboarding/onboarding_tutorial.dart';
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
import 'package:chance_app/ui/pages/sos_page/call_contacn_sos_screen.dart';
import 'package:chance_app/ui/pages/sos_page/delete_contact_screen.dart';
import 'package:chance_app/ui/pages/sos_page/main_page_sos.dart';
import 'package:chance_app/ux/bloc/add_medicine_bloc/add_medicine_bloc.dart';
import 'package:chance_app/ui/pages/sos_page/replace_contact_sos.dart';
import 'package:chance_app/ux/bloc/login_bloc/login_bloc.dart';
import 'package:chance_app/ux/bloc/registration_bloc/registration_bloc.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:chance_app/ux/bloc/sos_contacts_bloc/sos_contacts_bloc.dart';
import 'package:chance_app/ux/model/me_user.dart';
import 'package:chance_app/ux/model/medicine_model.dart';
import 'package:chance_app/ux/model/tasks_model.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest_all.dart';
import 'package:timezone/timezone.dart';

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

  await _initBoxes().then((value) async {
    Repository repository = Repository();
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

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Key key = UniqueKey();
  List<String> toasts = [];
  static bool isUserHaveOfflineData = false;

  static void addMessageThatUserHaveOfflineData() {
    isUserHaveOfflineData = true;
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
        ],
        child: Directionality(
            textDirection: TextDirection.ltr,
            child: Stack(
              children: [
                KeyedSubtree(
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
                            "/registration": (context) =>
                                const RegistrationPage(),
                            "/login": (context) => const LoginPage(),
                            "/enter_code": (context) =>
                                const EnterCodeForRegister(),
                            "/subscription_page": (context) =>
                                const SubscriptionPage(),
                            "/reminders": (context) => const RemindersPage(),
                            "/date_picker_for_tasks": (context) =>
                                const CalendarTaskPage(),
                            "/add_medicine": (context) => BlocProvider(
                                  create: (context) => AddMedicineBloc(),
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
                            "/add_group": (context) => const AddGroupScreen(),
                            "/onboarding_page": (context) =>
                                const OnboardingPage(),
                            "/onboarding_tutorial": (context) =>
                                const OnboardingTutorial(),
                            "/delete_contact_sos": (context) =>
                                const DeleteContactsPage(),
                            "/my_information": (context) =>
                                const MyInformation(),
                            "/call_contact_sos": (context) =>
                                const CallContactSosScreen(),
                            "/replace_contact_sos": (context) =>
                                const ReplaceContactSosScreen(),
                          },
                        ))),
                if (isUserHaveOfflineData)
                  Container(
                      color: Colors.black38,
                      child: Center(
                        child: Container(
                          width: size.width,
                          decoration: BoxDecoration(
                              color: beige100,
                              borderRadius: BorderRadius.circular(16)),
                          margin: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
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
                                      "Завдання",
                                      style: TextStyle(
                                          fontSize: 24, color: primaryText),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      "У вас є не синхронізовані дані з сервером. Бажаєте відправити ваші данні на сервер чи синхронізувати ваші дані із сервером?",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontSize: 16, color: primaryText),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(4),
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: darkNeutral800),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await Repository()
                                            .sendAllLocalData()
                                            .then((value) {
                                          if (value) {
                                            setState(() {
                                              isUserHaveOfflineData = false;
                                            });
                                          }
                                        });
                                      },
                                      child: SizedBox(
                                        width: (size.width / 2.1) - 50,
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
                                                  Icons.upload,
                                                  color: primaryText,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Відправити мої дані на сервер",
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: primary50,
                                                    fontSize: 16),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        Repository repository = Repository();
                                        await repository
                                            .clearTasks()
                                            .whenComplete(() async {
                                          await repository
                                              .updateLocalTasks()
                                              .whenComplete(() {
                                            setState(() {
                                              isUserHaveOfflineData = false;
                                            });
                                          });
                                        });
                                      },
                                      child: SizedBox(
                                        width: (size.width / 2.1) - 50,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 56,
                                              width: 56,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(90),
                                                  border: Border.all(
                                                      color: primary300)),
                                              child: Center(
                                                child: Icon(
                                                  Icons.download,
                                                  color: primary50,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Синхронізація із сервером",
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: primary50,
                                                    fontSize: 16),
                                              ),
                                            )
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
                      )),
              ],
            )));
  }
}

Box? tasksBox;
Box? userBox;
Box? medicineBox;

Future<bool> _initBoxes() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  //await Repository().deleteCookie();
  //await Hive.deleteBoxFromDisk('user');
  //await Hive.deleteBoxFromDisk('myTasks');
  Hive.registerAdapter(MeUserAdapter());
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(MedicineModelAdapter());
  tasksBox = await Hive.openBox<TaskModel>("myTasks");
  userBox = await Hive.openBox<MeUser>("user");
  //medicineBox = await Hive.openBox<MedicineModel>("myMedicines");

  return true;
}
