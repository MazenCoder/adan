import 'package:adan/initial_app/data/models/salah_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adan/database/app_database.dart';
import 'package:adan/helpers/app_utils.dart';
import 'package:adan/model/salah.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:adan/main.dart';



double remainingTime = 0;
Future<Salah> getNxtSalah() async {
  // final AppUtils appUtils = GetIt.I.get<AppUtils>();
  List<Salah> list = [];
  // list = await appUtils.getAllSalah();
  list = await getCachedSalah();
  // list = await getSalahOfTheDay();

  TimeOfDay nowTime = TimeOfDay.now();
  double _doubleNowTime = nowTime.hour.toDouble() + (nowTime.minute.toDouble() / 60);
  TimeOfDay salahTime;
  List<double> timeDiffList = [];

  list.forEach((salah) {
    salahTime = TimeOfDay(
        hour: int.parse(salah.time.substring(0, salah.time.indexOf(':'))),
        minute: int.parse(salah.time.substring(salah.time.indexOf(':') + 1, 5)),
    );

    double _doubleTempTime =
        salahTime.hour.toDouble() + (salahTime.minute.toDouble() / 60);
    double _timeDiff = (_doubleTempTime - _doubleNowTime);
    timeDiffList.add(_timeDiff);
  });

  int negativeCounter = 0;
  double minValue;

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
    remainingTime = (timeDiffList[0] * -1) - 6;
    return list[0];
  } else {
    remainingTime = minValue;
    try {
      return list[timeDiffList.indexOf(minValue)];
    } catch (e) {
      print(e);
      return Salah(name: '', englishName: '', time: '00:00', isNotificationEnabled: false, date: DateTime.now());
    }
  }
}

Future<Salah> getNxtSalahFromDatabase(AppDatabase database) async {

  List<Salah> list = [];

  list = await database.salahsDao.getAllSalah();
  // list = await getSalahOfTheDay();
  print('list: $list');

  TimeOfDay nowTime = TimeOfDay.now();
  double _doubleNowTime = nowTime.hour.toDouble() + (nowTime.minute.toDouble() / 60);
  TimeOfDay salahTime;
  List<double> timeDiffList = [];

  list.forEach((salah) {
    salahTime = TimeOfDay(
        hour: int.parse(salah.time.substring(0, salah.time.indexOf(':'))),
        minute: int.parse(salah.time.substring(salah.time.indexOf(':') + 1, 5)),
    );

    double _doubleTempTime =
        salahTime.hour.toDouble() + (salahTime.minute.toDouble() / 60);
    double _timeDiff = (_doubleTempTime - _doubleNowTime);
    timeDiffList.add(_timeDiff);
  });

  int negativeCounter = 0;
  double minValue;

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
    remainingTime = (timeDiffList[0] * -1) - 6;
    return list[0];
  } else {
    remainingTime = minValue;
    try {
      return list[timeDiffList.indexOf(minValue)];
    } catch (e) {
      print(e);
      return Salah(name: '', englishName: '', time: '00:00', isNotificationEnabled: false, date: DateTime.now());
    }
  }
}

Future<List<Salah>> getCachedSalah() async {
  List<Salah> salahList = [];
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final stringJson = preferences.getString(KEY_SALAH_JSON);
    if (stringJson != null) {
      SalahModel model = salahModelFromJson(stringJson);
      salahList = [
        Salah(
          id: 1,
          name: "الفجر",
          englishName: "Fajr",
          date: model.data.date.timestamp,
          isNotificationEnabled: true,
          time: model.data.timings.fajr,
          dateHijri: model.data.date.dateHijri,
        ),
        Salah(
          id: 2,
          name: "الشروق",
          englishName: "Sunrise",
          date: model.data.date.timestamp,
          isNotificationEnabled: true,
          time: model.data.timings.sunrise,
          dateHijri: model.data.date.dateHijri,
        ),
        Salah(
          id: 3,
          name: "الظهر",
          englishName: "Dhuhr",
          date: model.data.date.timestamp,
          isNotificationEnabled: true,
          time: model.data.timings.dhuhr,
          dateHijri: model.data.date.dateHijri,
        ),
        Salah(
          id: 4,
          name: "العصر",
          englishName: "Asr",
          date: model.data.date.timestamp,
          isNotificationEnabled: true,
          time: model.data.timings.asr,
          dateHijri: model.data.date.dateHijri,
        ),
        Salah(
          id: 5,
          name: "المغرب",
          englishName: "Maghrib",
          date: model.data.date.timestamp,
          isNotificationEnabled: true,
          time: model.data.timings.maghrib,
          dateHijri: model.data.date.dateHijri,
        ),
        Salah(
          id: 6,
          name: "العشاء",
          englishName: "Isha",
          date: model.data.date.timestamp,
          isNotificationEnabled: true,
          time: model.data.timings.isha,
          dateHijri: model.data.date.dateHijri,
        ),
      ];
    }
    return salahList;
  } catch(e) {
    return salahList;
  }
}
