import 'package:adan/model/ReminderNotification.dart';
import 'package:rxdart/rxdart.dart';


final BehaviorSubject<ReminderNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReminderNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();


