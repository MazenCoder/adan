import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:adan/shared_pref/salah_reminder_pref.dart';
import 'package:adan/services/NextSalahCalculator.dart';
import 'package:adan/helpers/preference_utils.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:adan/database/app_database.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';
import '../main.dart';
import 'dart:async';
import 'dart:ui';



class NotificationService {


  Future<void> cancelScheduledNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    // await AwesomeNotifications().cancelAllSchedules();
  }


  Future selectNotification(String payload) async {
    if (payload != null) {

    }
  }


  static Future<void> enableNotification(Salah sal) async {
    final subtract = PreferenceUtils.getInt(cSalahReminder, 3);
    print('salahs: ${sal.name} id: ${sal.id}');
    final timeBefore = DateTime(sal.date.year, sal.date.month, sal.date.day, int.parse(sal.time.substring(0, 2)), int.parse(sal.time.substring(3, 5))).subtract(Duration(minutes: subtract));
    await flutterLocalNotificationsPlugin.zonedSchedule(
      sal.id,
      ' صلاة ${sal.name}',
      ' تبقى لصلاه ${sal.name} $subtract دقائق ',
      tz.TZDateTime(
        tz.local,
        timeBefore.year,
        timeBefore.month,
        timeBefore.day,
        timeBefore.hour,
        timeBefore.minute,
        0,
      ),
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
          priority: Priority.high,
          importance: Importance.max,
          // playSound: false,
          // sound: RawResourceAndroidNotificationSound('adan1')
          // other properties...
        ),
        iOS: IOSNotificationDetails(),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: sal.name,
    );

    /// ----------------------- Salah ----------------------- ///
    final timeCorrect = DateTime(sal.date.year, sal.date.month, sal.date.day, int.parse(sal.time.substring(0, 2)), int.parse(sal.time.substring(3, 5)));
    await flutterLocalNotificationsPlugin.zonedSchedule(
      sal.id+10,
      ' صلاة ${sal.name}',
      ' حان الان موعد اذان ${sal.name}',
      tz.TZDateTime(
        tz.local,
        timeCorrect.year,
        timeCorrect.month,
        timeCorrect.day,
        timeCorrect.hour,
        timeCorrect.minute,
        0,
      ),
      NotificationDetails(
        android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            priority: Priority.high,
            importance: Importance.max,
            playSound: true,
            sound: RawResourceAndroidNotificationSound('adan1')
          // other properties...
        ),
        iOS: IOSNotificationDetails(sound: "adan1.wav"),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: sal.name,
    );
    /*
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: sal.id,
        channelKey: 'scheduled_channel',
        title: ' صلاة ${sal.name}',
        body: ' تبقى لصلاه ${sal.name} $subtract دقائق ',
        notificationLayout: NotificationLayout.Default,
        icon: 'resource://drawable/ic_stat_name',
      ),
      schedule: NotificationCalendar(
        // weekday: timeCorrect.day,
        hour: timeBefore.hour,
        minute: timeBefore.minute,
        millisecond: 0,
        second: 0,
        repeats: true,
      ),
    );

    final timeCorrect = DateTime(sal.date.year, sal.date.month, sal.date.day, int.parse(sal.time.substring(0, 2)), int.parse(sal.time.substring(3, 5)));
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: sal.id+10,
        channelKey: 'scheduled_channel_with_sound',
        title: ' صلاة ${sal.name}',
        body: ' حان الان موعد اذان ${sal.name}',
        notificationLayout: NotificationLayout.Default,
        icon: 'resource://drawable/ic_stat_name',
      ),
      schedule: NotificationCalendar(
        // weekday: timeCorrect.day,
        hour: timeCorrect.hour,
        minute: timeCorrect.minute,
        millisecond: 0,
        second: 0,
        repeats: true,
      ),
    );
    */
  }

  static Future<void> cancelNotification(int id) async {
    // await AwesomeNotifications().cancelSchedule(id);
    // await AwesomeNotifications().cancelSchedule(id+10);
    await flutterLocalNotificationsPlugin.cancel(id);
    await flutterLocalNotificationsPlugin.cancel(id+10);
  }

  static Future<void> showNotificationCustomSound() async {
    String dtz = await FlutterNativeTimezone.getLocalTimezone();
    List<Salah> salahs = await getCachedSalah();
    print('salahs list: ${salahs.length} dtz: $dtz');
    if (salahs == null || salahs.isEmpty) return;
    for(Salah sal in salahs) {
      print('salahs: ${sal.englishName} id: ${sal.id}');
      final subtract = PreferenceUtils.getInt(cSalahReminder, 3);
      final timeBefore = DateTime(sal.date.year, sal.date.month, sal.date.day, int.parse(sal.time.substring(0, 2)), int.parse(sal.time.substring(3, 5))).subtract(Duration(minutes: subtract));
      await flutterLocalNotificationsPlugin.zonedSchedule(
        sal.id,
        ' صلاة ${sal.name}',
        ' تبقى لصلاه ${sal.name} $subtract دقائق ',
        tz.TZDateTime(
          tz.getLocation(dtz),
          timeBefore.year,
          timeBefore.month,
          timeBefore.day,
          timeBefore.hour,
          timeBefore.minute,
          0,
        ),
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            priority: Priority.high,
            importance: Importance.max,
          ),
          iOS: IOSNotificationDetails(),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: sal.name,
      );

      /// ----------------------- Salah ----------------------- ///
      final timeCorrect = DateTime(sal.date.year, sal.date.month, sal.date.day, int.parse(sal.time.substring(0, 2)), int.parse(sal.time.substring(3, 5)));
      await flutterLocalNotificationsPlugin.zonedSchedule(
        sal.id+10,
        ' صلاة ${sal.name}',
        ' حان الان موعد اذان ${sal.name}',
        tz.TZDateTime(
          tz.getLocation(dtz),
          timeCorrect.year,
          timeCorrect.month,
          timeCorrect.day,
          timeCorrect.hour,
          timeCorrect.minute,
          0,
        ),
        NotificationDetails(
          android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              priority: Priority.high,
              importance: Importance.max,
              playSound: (sal.id == 2) ? false : true,
              sound: (sal.id == 2) ? null : RawResourceAndroidNotificationSound('adan1')
            // other properties...
          ),
          iOS: IOSNotificationDetails(sound: "adan1.wav"),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: sal.name,
      );
    }
  }
    /*
    await AwesomeNotifications().cancelAllSchedules();
    String localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    List<Salah> salahs = await getCachedSalah();
    print('salahs: $salahs');
    print('salahs: ${salahs.length}');
    if (salahs == null || salahs.isEmpty) return;
    for(Salah sal in salahs) {
      final subtract = PreferenceUtils.getInt(cSalahReminder, 3);
      final timeBefore = DateTime(sal.date.year, sal.date.month, sal.date.day, int.parse(sal.time.substring(0, 2)), int.parse(sal.time.substring(3, 5))).subtract(Duration(minutes: subtract));
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: sal.id,
          channelKey: 'scheduled_channel',
          title: ' صلاة ${sal.name}',
          body: ' تبقى لصلاه ${sal.name} $subtract دقائق ',
          notificationLayout: NotificationLayout.Default,
          icon: 'resource://drawable/ic_stat_name',
        ),
        schedule: NotificationCalendar(
          timeZone: 'Africa/Casablanca',
          // weekday: timeCorrect.day,
          hour: timeBefore.hour,
          minute: timeBefore.minute,
          millisecond: 0,
          second: 0,
          repeats: true,
        ),
      );

      final timeCorrect = DateTime(sal.date.year, sal.date.month, sal.date.day, int.parse(sal.time.substring(0, 2)), int.parse(sal.time.substring(3, 5)));
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: sal.id+10,
          channelKey: 'scheduled_channel_with_sound',
          title: ' صلاة ${sal.name}',
          body: ' حان الان موعد اذان ${sal.name}',
          notificationLayout: NotificationLayout.Default,
          icon: 'resource://drawable/ic_stat_name',
        ),
        schedule: NotificationCalendar(
          // weekday: timeCorrect.day,
          timeZone: 'Africa/Casablanca',
          hour: timeCorrect.hour,
          minute: timeCorrect.minute,
          millisecond: 0,
          second: 0,
          repeats: true,
        ),
      );
    }
    */
  // }

  static scheduledNotification(int id, String s, String t, DateTime repeatDateTime, int parse, int parse2) {

  }
}




int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

class NotificationWeekAndTime {
  final int dayOfTheWeek;
  final TimeOfDay timeOfDay;

  NotificationWeekAndTime({
    @required this.dayOfTheWeek,
    @required this.timeOfDay,
  });
}

Future<NotificationWeekAndTime> pickSchedule(BuildContext context) async {
  List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  TimeOfDay timeOfDay;
  DateTime now = DateTime.now();
  int selectedDay;

  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'I want to be reminded every:',
            textAlign: TextAlign.center,
          ),
          content: Wrap(
            alignment: WrapAlignment.center,
            spacing: 3,
            children: [
              for (int index = 0; index < weekdays.length; index++)
                ElevatedButton(
                  onPressed: () {
                    selectedDay = index + 1;
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.teal,
                    ),
                  ),
                  child: Text(weekdays[index]),
                ),
            ],
          ),
        );
      });

  if (selectedDay != null) {
    timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          now.add(
            Duration(minutes: 1),
          ),
        ),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.teal,
              ),
            ),
            child: child,
          );
        });

    if (timeOfDay != null) {
      print('NotificationWeekAndTime: $selectedDay, $timeOfDay');
      return NotificationWeekAndTime(dayOfTheWeek: selectedDay, timeOfDay: timeOfDay);
    }
  }
  return null;
}
