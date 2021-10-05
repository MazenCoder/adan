import 'package:adan/initial_app/data/models/ville_model.dart';
import 'package:adan/initial_app/data/models/salah_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adan/database/app_database.dart';
import 'package:adan/error/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';



abstract class InitialAppLocalDataSource {

  Future<void> cacheVille(VilleModel model);
  Future<void> cacheSalah(SalahModel model);
}

class InitialAppLocalDataSourceImpl implements InitialAppLocalDataSource {

  final logger = Logger();

  final AppDatabase db;
  final SharedPreferences preferences;
  InitialAppLocalDataSourceImpl({
    @required this.db, @required this.preferences,
  });



  @override
  Future<void> cacheSalah(SalahModel model) async {
    try {

      List<Salah> salahList = [
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

      final list = await db.salahsDao.getAllSalah()??[];
      if (list.isNotEmpty && list.length == 6) {
        for (Salah salah in salahList) {
          await db.salahsDao.updateDate(
            id: salah.id,
            time: salah.time,
            date: salah.date,
            dateHijri: salah.dateHijri,
          );
        }
      } else {
        await db.salahsDao.insertAllSalah(salahList);
      }
    } catch(e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheVille(VilleModel model) async {
    try {
      await db.delete(db.villes).go();
      await db.villesDao.insertAllVille(model.villes);
    } catch(e) {
      throw CacheException();
    }
  }
}