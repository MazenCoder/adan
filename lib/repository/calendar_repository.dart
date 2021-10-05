import 'package:adan/initial_app/data/models/salah_model.dart';
import 'package:adan/helpers/preference_utils.dart';
import 'package:adan/database/app_database.dart';
import 'package:adan/network/network_info.dart';
import 'package:http/http.dart' as http;
import 'package:adan/main.dart';
import 'package:intl/intl.dart';



abstract class CalendarRepository {

  Future<List<Salah>> fetchCalendar(DateTime dateTime);
}

class CalendarRepositoryImpl implements CalendarRepository {
  final http.Client client;
  final NetworkInfo networkInfo;
  CalendarRepositoryImpl({this.client, this.networkInfo});

  @override
  Future<List<Salah>> fetchCalendar(DateTime dateTime) async {
    List<Salah> salahList = [];
    try {
      if (!await networkInfo.isConnected) {
        throw NetworkException();
      }
      final villeId = PreferenceUtils.getInt(KEY_VILLE_ID, 1).toString();
      final format = DateFormat('yyyy-MM-dd').format(dateTime);
      http.Response response = await http.post(
        Uri.parse("http://inoser-education.com/Adhan/json/HorairePriere_ws"),
        body: {
          "adan_ws": """{
          "token":"123456",
          "id_ville": "$villeId",
          "date":"$format"
        }"""
        },
      );

      print("response.body: ${response.body}");
      SalahModel model = salahModelFromJson(response.body);
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
      return salahList;
    } catch(e) {
      return salahList;
    }
  }
}

class NetworkException implements Exception {}