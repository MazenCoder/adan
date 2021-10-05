import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'initial_app/presentation/pages/initial_app_page.dart';
import 'package:adan/providers/initial_screen_provider.dart';
import 'package:adan/helpers/injection_container.dart' as di;
import 'package:adan/repository/calendar_repository.dart';
import 'package:adan/services/notifications.dart';
import 'package:adan/screens/initial_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'helpers/injection_container.dart';
import 'model/ReminderNotification.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'helpers/preference_utils.dart';
import 'helpers/app_utils_impl.dart';
import 'package:rxdart/rxdart.dart';
import 'database/app_database.dart';
import 'cubit/calendar_cubit.dart';
import 'langs/translation.dart';
import 'screens/home_page.dart';
import 'package:get/get.dart';



const KEY_LOCALE = "KEY_LOCALE";
const KEY_VILLE_ID = "KEY_VILLE_ID";
const KEY_VILLE_NAME = "KEY_VILLE_NAME";
const KEY_SALAH_JSON = "KEY_SALAH_JSON";
const KEY_TIMESTAMP_JSON = "KEY_TIMESTAMP_JSON";
const myTask = "syncWithTheBackEnd0";

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  'This channel is used for important notifications.',
  importance: Importance.max,
  playSound: true,
  // sound: RawResourceAndroidNotificationSound('adan1')
);

final BehaviorSubject<ReminderNotification> didReceiveNotificationSubject = BehaviorSubject<ReminderNotification>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

initializePlatformSpecifics() async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  var initializationSettingsAndroid = AndroidInitializationSettings('@drawable/ic_stat_name');
  var initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification: (id, title, body, payload) async {
      ReminderNotification receivedNotification = ReminderNotification(
          id: id, title: title, body: body, payload: payload);
      didReceiveNotificationSubject.add(receivedNotification);
    },
  );
  final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  tz.initializeTimeZones();
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: selectNotification,
  );
}

Future selectNotification(String payload) async {
  if (payload != null) {

  }
}

void main() async {
  var db = AppDatabase.instance;
  WidgetsFlutterBinding.ensureInitialized();
  initializePlatformSpecifics();
  await di.setup();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppUtilsImpl()),
        Provider<AppDatabase>(
          create: (_) => db,
          dispose: (context, value) => value.close(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => InitialScreenProvider(),
        ),
        Provider<CalendarCubit>(
          create: (_) => CalendarCubit(
              calendarRepository: CalendarRepositoryImpl(
                networkInfo: sl(),
              ),
          ),
          dispose: (context, value) => value.close(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final hasVilleId = PreferenceUtils.containsKey(KEY_VILLE_ID, false);
    return GetMaterialApp(
      title: 'Adan Maroc',
      debugShowCheckedModeBanner: false,
      translations: Translation(),
      locale: Locale(PreferenceUtils.getString(KEY_LOCALE, 'fr')),
      fallbackLocale: Locale('fr'),
      // home: InitialAppPage(),
      home: hasVilleId ? InitialScreen() : InitialAppPage(),
      routes: {
        HomePage.route: (context) => HomePage(),
        InitialScreen.route: (context) => InitialAppPage(),
      },
    );
  }
}
