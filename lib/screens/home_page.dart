import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:adan/widgets/navigation_bottom_bar.dart';
import 'package:adan/widgets/salah_time_section.dart';
import 'package:adan/widgets/navigation_widget.dart';
import 'package:adan/widgets/settings_widget.dart';
import 'package:adan/widgets/summary_widget.dart';
import 'package:adan/widgets/calendar_weeks.dart';
import 'package:adan/services/notifications.dart';
import 'package:adan/usecases/flash_helper.dart';
import 'package:adan/database/app_database.dart';
import 'package:after_layout/after_layout.dart';
import 'package:adan/widgets/info_widget.dart';
import 'package:adan/helpers/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:get/get.dart';
import '../main.dart';
import 'dart:math';
import 'dart:io';



class HomePage extends StatefulWidget {
  static String route = '/HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin<HomePage> {

  static final platform = MethodChannel('adan/battery');
  final AppUtils appUtils = GetIt.I.get<AppUtils>();
  String selectedMenuItem = 'home';
  String _batteryLevel = 'Unknown';
  double remainingTime = 0;
  String _currentAddress;
  List<Salah> list = [];


  @override
  void initState() {
    super.initState();
    /*
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(context: context,
          builder: (context) => AlertDialog(
            title: Text('allow_notify'.tr),
            content: Text('send_notify'.tr),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'dont_allow'.tr,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text('allow'.tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        );
      }
    });

    AwesomeNotifications().createdStream.listen((notification) {
      print('Notification Created on ${notification.channelKey}');
    });

    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then(
              (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1),
        );
      }
    });
    */
  }


  void selectMenuTo(String val) {
    setState(() {
      selectedMenuItem = val;
    });
  }

  void getSalahList() async {
    list = await appUtils.getAllSalah();
    setState(() {});
  }


  Widget getCurrentDisplayingWidget() {
    switch (selectedMenuItem) {
      case 'home':
        {
          return SalahTimeSection(list: list, fromHome: true);
        }
      case 'calendar':
        {
          return CalendarWeeks();
        }
      case 'info':
        {
          return InfoWidget();
        }
      case 'navigation':
        {
          return NavigationWidget();
        }
      case 'settings':
        {
          return SettingsWidget();
        }
      default:
        {
          return SalahTimeSection(list: list);
        }
    }
  }

  Salah getNxtSalah() {
    TimeOfDay nowTime = TimeOfDay.now();
    double _doubleNowTime = nowTime.hour.toDouble() + (nowTime.minute.toDouble() / 60);
    TimeOfDay salahTime;
    List<double> timeDiffList = [];

    list.forEach((salah) {
      if (salah.time != null) {
        salahTime = TimeOfDay(hour: int.parse(salah.time.substring(0, salah.time.indexOf(':'))),
            minute: int.parse(salah.time.substring(salah.time.indexOf(':') + 1, 5)));

        double _doubleTempTime = salahTime.hour.toDouble() + (salahTime.minute.toDouble() / 60);
        double _timeDiff = (_doubleTempTime - _doubleNowTime);
        timeDiffList.add(_timeDiff);
      }
    });

    int negativeCounter = 0;
    double minValue;

    if (timeDiffList != null && timeDiffList.isNotEmpty) {
      minValue = (list.length > 0) ? timeDiffList[5] : 0;

      timeDiffList.forEach((timeDifference) {
        if (timeDifference > 0) {
          if (minValue > timeDifference) {
            minValue = timeDifference;
          }
        }
        if (timeDifference < 0) {
          negativeCounter++;
        }
      });

      if (negativeCounter >= 6) {
        setState(() {
          remainingTime = (timeDiffList[0] * -1) - 6;
        });
        return list[0];
      } else {
        setState(() {
          remainingTime = minValue;
        });
        try {
          return list[timeDiffList.indexOf(minValue)];
        } catch (e) {
          print(e);
          return Salah(name: '', englishName: '', time: '00:00', isNotificationEnabled: false, date: DateTime.now());
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    getSalahList();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // AwesomeNotifications().actionSink.close();
    // AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              if (!selectedMenuItem.contains('calendar'))
                SummaryWidget(
                  currentAddress: _currentAddress ?? 'loading'.tr,
                  // salah: getNxtSalah(),
                  // remainingTime: remainingTime,
                ),
              getCurrentDisplayingWidget(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        callback: selectMenuTo,
        selectedItem: selectedMenuItem,
        screenHeight: size.height,
      ),
      /*
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.notifications_active),
        onPressed: () async {
          final now = DateTime.now().add(Duration(seconds: 30));
          await flutterLocalNotificationsPlugin.showDailyAtTime(
            199,
            ' صلاة ',
            ' حان الان موعد اذان ',
            Time(now.hour, now.minute, 0),
            NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  priority: Priority.high,
                  importance: Importance.max,
                  sound: RawResourceAndroidNotificationSound('adan1')
                // other properties...
              ),
              iOS: IOSNotificationDetails(
                sound: "adan1.wav",
              ),
            ),
            // payload: sal.name,
          );
          /*
          final now = DateTime.now().add(Duration(seconds: 30));
          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 0,
              channelKey: 'scheduled_channel_with_sound',
              title: ' صلاة',
              body: ' تبقى لصلاه 0 دقائق ',
              notificationLayout: NotificationLayout.Default,
              icon: 'resource://drawable/ic_stat_name',
            ),
            schedule: NotificationCalendar(
              timeZone: 'Africa/Casablanca',
              // weekday: timeCorrect.day,
              hour: now.hour,
              minute: now.minute,
              millisecond: 0,
              second: now.second,
              repeats: true,
            ),
          );
          */
        },
      ),
       */
    );
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    await NotificationService.showNotificationCustomSound();
    await _getBatteryLevel();

  }

  Future<void> _getBatteryLevel() async {
    try {
      final bool result = await platform.invokeMethod('isPowerSaveMode');
      // final int result = await platform.invokeMethod('getBatteryLevel');
      _batteryLevel = 'isPowerSaveMode: $result';
      FlashHelper.infoBar(context, message: 'mode save power is: $result');
      // _batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      _batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    print("_batteryLevel: $_batteryLevel");
  }

}
