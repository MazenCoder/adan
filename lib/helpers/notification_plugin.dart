// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:adan/shared_pref/preferred_adhan_pref.dart';
// import 'package:adan/services/NextSalahCalculator.dart';
// import 'package:adan/database/app_database.dart';
// import 'package:flutter/material.dart';
// import 'package:rxdart/subjects.dart';
// import 'dart:math';
// import 'dart:io';
//
//
//
// class NotificationPlugin {
//
//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   static var initializationSettings;
//   //object fro notifications
//   static final BehaviorSubject<RecievedNotification> didReceiveNotificationSubject =
//   BehaviorSubject<RecievedNotification>();
//
//   NotificationPlugin._() {
//     init();
//   }
//
//   static void init() {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//     if (Platform.isIOS) {
//       _requestIOSPermission();
//     }
//     initializePlatformSpecifics();
//   }
//
//   //this function is only for android not for the ios
//   static _requestIOSPermission() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         IOSFlutterLocalNotificationsPlugin>()
//         .requestPermissions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
//
//   //initalize the platforms
//   static initializePlatformSpecifics() {
//     var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
//     // var initializationSettingsAndroid = AndroidInitializationSettings('drawable/ic_stat_name');
//     var initializationSettingsIOS = IOSInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       onDidReceiveLocalNotification: (id, title, body, payload) async {
//         // your call back to the UI
//         RecievedNotification receivedNotification = RecievedNotification(
//             id: id, title: title, body: body, payload: payload);
//         didReceiveNotificationSubject.add(receivedNotification);
//       },
//     );
//     initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//
//     flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onSelectNotification: (payload) async {
//         print("___ oayload is $payload");
//       },
//     );
//   }
//
//   static Future<void> showNotification(int id, String title, DateTime dateTime) async {
//     // var testTime = DateTime.now().add(Duration(seconds: 5));
//     var androidChannelSpecifics = AndroidNotificationDetails(
//       'CHANNEL_ID',
//       'CHANNEL_NAME',
//       "CHANNEL_DESCRIPTION",
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//       timeoutAfter: 5000,
//       color: Colors.red,
//       sound: RawResourceAndroidNotificationSound("adan1"),
//       styleInformation: DefaultStyleInformation(true, true),
//     );
//     var iosChannelSpecifics = IOSNotificationDetails(
//       sound: "adan1.mp3",
//     );
//     var platformChannelSpecifics =
//     NotificationDetails(android: androidChannelSpecifics, iOS: iosChannelSpecifics);
//     await flutterLocalNotificationsPlugin.schedule(
//       id,
//       title,
//       'Adan Maroc', //null
//       dateTime, platformChannelSpecifics,
//       payload: 'New Payload',
//     );
//   }
//
//   Future<bool> setWeeklyAtDayTime(int hour, int minute, String alarmName,
//       String alarmDescription, int id, Day day) async {
//     try {
//       final sound = await getPreferredAdhan();
//       var time = Time(hour, minute, 0);
//       var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'CHANNEL_ID',
//         'CHANNEL_NAME',
//         "CHANNEL_DESCRIPTION",
//         sound: RawResourceAndroidNotificationSound("$sound"),
//         importance: Importance.max,
//         priority: Priority.high,
//         styleInformation: DefaultStyleInformation(true, true),
//         timeoutAfter: 60000,
//       );
//       var iOSPlatformChannelSpecifics = IOSNotificationDetails(
//         sound: "$sound.mp3",
//         presentSound: true,
//         presentAlert: true,
//         presentBadge: true,
//       );
//       var platformChannelSpecifics = NotificationDetails(
//           android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
//       await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
//           id, // has to change
//           '$alarmName',
//           '$alarmDescription',
//           day,
//           time,
//           platformChannelSpecifics,
//           payload: "My Alarm");
//       print("alarm added sucussfully");
//       return true;
//     } catch (e) {
//       print("Set alarm failed $e");
//       return false;
//     }
//   }
//
//   static void setRecorringAlarm(
//       int hour,
//       int minute,
//       String alarmName,
//       String alarmDescription,
//       int id,
//       List<int> dayList) {
//     print("day list data length is ${dayList.length}");
//
//     if (dayList.contains(1)) {
//       notificationPlugin.setWeeklyAtDayTime(
//         hour,
//         minute,
//         alarmName,
//         alarmDescription,
//         id+1,
//         Day.monday,
//       );
//     }
//     if (dayList.contains(2)) {
//       notificationPlugin.setWeeklyAtDayTime(
//         hour,
//         minute,
//         alarmName,
//         alarmDescription,
//         id+2,
//         Day.tuesday,
//       );
//     }
//     if (dayList.contains(3)) {
//       notificationPlugin.setWeeklyAtDayTime(
//         hour,
//         minute,
//         alarmName,
//         alarmDescription,
//         id+3,
//         Day.wednesday,
//       );
//     }
//     if (dayList.contains(4)) {
//       notificationPlugin.setWeeklyAtDayTime(
//         hour,
//         minute,
//         alarmName,
//         alarmDescription,
//         id+4,
//         Day.thursday,
//       );
//     }
//     if (dayList.contains(5)) {
//       notificationPlugin.setWeeklyAtDayTime(
//         hour,
//         minute,
//         alarmName,
//         alarmDescription,
//         id+5,
//         Day.friday,
//       );
//     }
//     if (dayList.contains(6)) {
//       notificationPlugin.setWeeklyAtDayTime(
//         hour,
//         minute,
//         alarmName,
//         alarmDescription,
//         id+6,
//         Day.saturday,
//       );
//     }
//     if (dayList.contains(7)) {
//       notificationPlugin.setWeeklyAtDayTime(
//         hour,
//         minute,
//         alarmName,
//         alarmDescription,
//         id+7,
//         Day.sunday,
//       );
//     }
//
//     /*
//     if (dayList.isEmpty) {
//       final _now = DateTime.now();
//       if (DateTime(_now.year, _now.month, _now.day, hour, minute, 0).millisecondsSinceEpoch <= _now.millisecondsSinceEpoch) {
//         print('----قبل----');
//         showNotification(id, alarmName, DateTime(_now.year, _now.month, _now.day, hour, minute, 0).add(Duration(days: 1)));
//       } else {
//         print('----بعد----');
//         showNotification(id, alarmName, DateTime(_now.year, _now.month, _now.day, hour, minute, 0));
//       }
//     }
//
//      */
//
//   }
//
//   void cancelAlarm(bool value, var alarm) async {
//     print('value: $value list: ${alarm.dayList}');
//     if (!value && alarm.dayList.isEmpty) {
//       print('value: $value list: ${alarm.dayList}');
//       flutterLocalNotificationsPlugin.cancel(alarm.id);
//     } else if (value && alarm.dayList.isEmpty) {
//       final _now = DateTime.now();
//       if (DateTime(_now.year, _now.month, _now.day, alarm.hour, alarm.minute, 0).millisecondsSinceEpoch <= _now.millisecondsSinceEpoch) {
//         print('----قبل----');
//         showNotification(alarm.id, alarm.title, DateTime(_now.year, _now.month, _now.day, alarm.hour, alarm.minute, 0).add(Duration(days: 1)));
//       } else {
//         print('----بعد----');
//         showNotification(alarm.id, alarm.title, DateTime(_now.year, _now.month, _now.day, alarm.hour, alarm.minute, 0));
//       }
//     } else if (!value && alarm.dayList.isNotEmpty) {
//       if (alarm.dayList.contains('1')) {
//         flutterLocalNotificationsPlugin.cancel(alarm.id+1);
//       }
//       if (alarm.dayList.contains('2')) {
//         flutterLocalNotificationsPlugin.cancel(alarm.id+2);
//       }
//       if (alarm.dayList.contains('3')) {
//         flutterLocalNotificationsPlugin.cancel(alarm.id+3);
//       }
//       if (alarm.dayList.contains('4')) {
//         flutterLocalNotificationsPlugin.cancel(alarm.id+4);
//       }
//       if (alarm.dayList.contains('5')) {
//         flutterLocalNotificationsPlugin.cancel(alarm.id+5);
//       }
//       if (alarm.dayList.contains('6')) {
//         flutterLocalNotificationsPlugin.cancel(alarm.id+6);
//       }
//       if (alarm.dayList.contains('7')) {
//         flutterLocalNotificationsPlugin.cancel(alarm.id+7);
//       }
//     } else if (value && alarm.dayList.isNotEmpty) {
//       List<int> dayList = alarm.dayList.split(',').map((data) => int.parse(data)).toList();
//
//       if (dayList.contains(1)) {
//         notificationPlugin.setWeeklyAtDayTime(
//           alarm.hour,
//           alarm.minute,
//           alarm.title,
//           "String alarmDescription",
//           alarm.id+1,
//           Day.monday,
//         );
//       }
//       if (dayList.contains(2)) {
//         notificationPlugin.setWeeklyAtDayTime(
//           alarm.hour,
//           alarm.minute,
//           alarm.title,
//           "String alarmDescription",
//           alarm.id+2,
//           Day.tuesday,
//         );
//       }
//       if (dayList.contains(3)) {
//         notificationPlugin.setWeeklyAtDayTime(
//           alarm.hour,
//           alarm.minute,
//           alarm.title,
//           "String alarmDescription",
//           alarm.id+3,
//           Day.wednesday,
//         );
//       }
//       if (dayList.contains(4)) {
//         notificationPlugin.setWeeklyAtDayTime(
//           alarm.hour,
//           alarm.minute,
//           alarm.title,
//           "String alarmDescription",
//           alarm.id+4,
//           Day.thursday,
//         );
//       }
//       if (dayList.contains(5)) {
//         notificationPlugin.setWeeklyAtDayTime(
//           alarm.hour,
//           alarm.minute,
//           alarm.title,
//           "String alarmDescription",
//           alarm.id+5,
//           Day.friday,
//         );
//       }
//       if (dayList.contains(6)) {
//         notificationPlugin.setWeeklyAtDayTime(
//           alarm.hour,
//           alarm.minute,
//           alarm.title,
//           "String alarmDescription",
//           alarm.id+6,
//           Day.saturday,
//         );
//       }
//       if (dayList.contains(7)) {
//         notificationPlugin.setWeeklyAtDayTime(
//           alarm.hour,
//           alarm.minute,
//           alarm.title,
//           "String alarmDescription",
//           alarm.id+7,
//           Day.sunday,
//         );
//       }
//     }
//   }
//
//   void deleteAlarmInfo(var alarm) async {
//     if (alarm.dayList.isEmpty) {
//       flutterLocalNotificationsPlugin.cancel(alarm.id);
//     } else if (alarm.dayList.isNotEmpty) {
//       if (alarm.dayList.contains('1')) {
//         flutterLocalNotificationsPlugin.cancel(alarm.id+1);
//       }
//       if (alarm.dayList.contains('2')) {
//         flutterLocalNotificationsPlugin.cancel(alarm.id+2);
//       }
//       if (alarm.dayList.contains('3')) {
//         flutterLocalNotificationsPlugin.cancel(alarm.id+3);
//       }
//       if (alarm.dayList.contains('4')) {
//         flutterLocalNotificationsPlugin.cancel(alarm.id+4);
//       }
//       if (alarm.dayList.contains('5')) {
//         flutterLocalNotificationsPlugin.cancel(alarm.id+5);
//       }
//       if (alarm.dayList.contains('6')) {
//         flutterLocalNotificationsPlugin.cancel(alarm.id+6);
//       }
//       if (alarm.dayList.contains('7')) {
//         flutterLocalNotificationsPlugin.cancel(alarm.id+7);
//       }
//     }
//   }
//
//   static Future<void> showNotificationCustomSound() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//     // int i = 1;
//     List<Salah> salahs = await getCachedSalah();
//     for(Salah sal in salahs) {
//       var rng = new Random();
//       print('hour: ${int.parse(sal.time.substring(0, 2))}');
//       print('minute: ${int.parse(sal.time.substring(3, 5))}');
//       print("${sal.name}");
//       print("id: ${rng.nextInt(99999)}");
//       setRecorringAlarm(
//         int.parse(sal.time.substring(0, 2)),
//         int.parse(sal.time.substring(3, 5)),
//         "${sal.name}",
//         "Adan Maroc",
//         rng.nextInt(99999),
//         [1, 2, 3, 4, 5, 6, 7]
//       );
//       // i= i+1;
//       print('--------------------');
//     }
//
//     /*
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'CHANNEL_ID',
//       'CHANNEL_NAME',
//       "CHANNEL_DESCRIPTION",
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//       sound: RawResourceAndroidNotificationSound('adan1'),
//     );
//     IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails(sound: 'adan1.mp3');
//
//     NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );
//     await flutterLocalNotificationsPlugin.show(0, 'Adan Maroc', '$salah', platformChannelSpecifics);
//     */
//   }
// }
//
// NotificationPlugin notificationPlugin = NotificationPlugin._();
//
// class RecievedNotification {
//   final int id;
//   final String title;
//   final String body;
//   final String payload;
//
//   RecievedNotification({this.id, this.title, this.body, this.payload});
// }
