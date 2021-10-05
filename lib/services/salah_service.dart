// import 'package:adan/database/app_database.dart';
// import 'package:adan/shared_pref/location_pref.dart';
// import 'package:adan/shared_pref/method_pref.dart';
// import 'package:adan/shared_pref/data_json.dart';
// import 'package:adan/database/db_provider.dart';
// import 'package:adan/model/salah.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'dart:async';
// import 'dart:io';
//
//
// String url = 'https://api.aladhan.com/v1/calendar?';
// Future loadSalahFromOnline (
//     double lat, double long, String method, int day, int month, int year) async {
//   var dt;
//   var timings;
//   String tpUrl = 'https://api.aladhan.com/v1/calendar?';
//   print(method);
//   if(method == "SMJ") {
//     tpUrl+="latitude=$lat&longitude=$long&method=99&methodSettings=14.5,null,14.0&month=$month&year=$year";
//   } else {
//     tpUrl+="latitude=$lat&longitude=$long&method=3&month=$month&year=$year";
//   }
//   print(tpUrl);
//
//   // final response = await http.get(tpUrl);
//   final responseBody = """
//   {
//     "code": 200,
//     "status": "OK",
//     "data": [
//         {
//             "timings": {
//                 "Fajr": "04:21 (+01)",
//                 "Sunrise": "06:07 (+01)",
//                 "Dhuhr": "13:19 (+01)",
//                 "Asr": "17:08 (+01)",
//                 "Sunset": "20:32 (+01)",
//                 "Maghrib": "20:32 (+01)",
//                 "Isha": "22:10 (+01)",
//                 "Imsak": "04:11 (+01)",
//                 "Midnight": "01:19 (+01)"
//             },
//             "date": {
//                 "readable": "01 Jun 2021",
//                 "timestamp": "1622534461",
//                 "gregorian": {
//                     "date": "01-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "01",
//                     "weekday": {
//                         "en": "Tuesday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "20-10-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "20",
//                     "weekday": {
//                         "en": "Al Thalaata",
//                         "ar": "الثلاثاء"
//                     },
//                     "month": {
//                         "number": 10,
//                         "en": "Shawwāl",
//                         "ar": "شَوّال"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:20 (+01)",
//                 "Sunrise": "06:06 (+01)",
//                 "Dhuhr": "13:19 (+01)",
//                 "Asr": "17:08 (+01)",
//                 "Sunset": "20:32 (+01)",
//                 "Maghrib": "20:32 (+01)",
//                 "Isha": "22:11 (+01)",
//                 "Imsak": "04:10 (+01)",
//                 "Midnight": "01:19 (+01)"
//             },
//             "date": {
//                 "readable": "02 Jun 2021",
//                 "timestamp": "1622620861",
//                 "gregorian": {
//                     "date": "02-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "02",
//                     "weekday": {
//                         "en": "Wednesday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "21-10-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "21",
//                     "weekday": {
//                         "en": "Al Arba'a",
//                         "ar": "الاربعاء"
//                     },
//                     "month": {
//                         "number": 10,
//                         "en": "Shawwāl",
//                         "ar": "شَوّال"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:20 (+01)",
//                 "Sunrise": "06:06 (+01)",
//                 "Dhuhr": "13:19 (+01)",
//                 "Asr": "17:08 (+01)",
//                 "Sunset": "20:33 (+01)",
//                 "Maghrib": "20:33 (+01)",
//                 "Isha": "22:12 (+01)",
//                 "Imsak": "04:10 (+01)",
//                 "Midnight": "01:19 (+01)"
//             },
//             "date": {
//                 "readable": "03 Jun 2021",
//                 "timestamp": "1622707261",
//                 "gregorian": {
//                     "date": "03-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "03",
//                     "weekday": {
//                         "en": "Thursday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "22-10-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "22",
//                     "weekday": {
//                         "en": "Al Khamees",
//                         "ar": "الخميس"
//                     },
//                     "month": {
//                         "number": 10,
//                         "en": "Shawwāl",
//                         "ar": "شَوّال"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:19 (+01)",
//                 "Sunrise": "06:06 (+01)",
//                 "Dhuhr": "13:19 (+01)",
//                 "Asr": "17:08 (+01)",
//                 "Sunset": "20:33 (+01)",
//                 "Maghrib": "20:33 (+01)",
//                 "Isha": "22:13 (+01)",
//                 "Imsak": "04:09 (+01)",
//                 "Midnight": "01:20 (+01)"
//             },
//             "date": {
//                 "readable": "04 Jun 2021",
//                 "timestamp": "1622793661",
//                 "gregorian": {
//                     "date": "04-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "04",
//                     "weekday": {
//                         "en": "Friday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "23-10-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "23",
//                     "weekday": {
//                         "en": "Al Juma'a",
//                         "ar": "الجمعة"
//                     },
//                     "month": {
//                         "number": 10,
//                         "en": "Shawwāl",
//                         "ar": "شَوّال"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:19 (+01)",
//                 "Sunrise": "06:06 (+01)",
//                 "Dhuhr": "13:20 (+01)",
//                 "Asr": "17:08 (+01)",
//                 "Sunset": "20:34 (+01)",
//                 "Maghrib": "20:34 (+01)",
//                 "Isha": "22:14 (+01)",
//                 "Imsak": "04:09 (+01)",
//                 "Midnight": "01:20 (+01)"
//             },
//             "date": {
//                 "readable": "05 Jun 2021",
//                 "timestamp": "1622880061",
//                 "gregorian": {
//                     "date": "05-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "05",
//                     "weekday": {
//                         "en": "Saturday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "24-10-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "24",
//                     "weekday": {
//                         "en": "Al Sabt",
//                         "ar": "السبت"
//                     },
//                     "month": {
//                         "number": 10,
//                         "en": "Shawwāl",
//                         "ar": "شَوّال"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:18 (+01)",
//                 "Sunrise": "06:05 (+01)",
//                 "Dhuhr": "13:20 (+01)",
//                 "Asr": "17:09 (+01)",
//                 "Sunset": "20:34 (+01)",
//                 "Maghrib": "20:34 (+01)",
//                 "Isha": "22:14 (+01)",
//                 "Imsak": "04:08 (+01)",
//                 "Midnight": "01:20 (+01)"
//             },
//             "date": {
//                 "readable": "06 Jun 2021",
//                 "timestamp": "1622966461",
//                 "gregorian": {
//                     "date": "06-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "06",
//                     "weekday": {
//                         "en": "Sunday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "25-10-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "25",
//                     "weekday": {
//                         "en": "Al Ahad",
//                         "ar": "الاحد"
//                     },
//                     "month": {
//                         "number": 10,
//                         "en": "Shawwāl",
//                         "ar": "شَوّال"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:18 (+01)",
//                 "Sunrise": "06:05 (+01)",
//                 "Dhuhr": "13:20 (+01)",
//                 "Asr": "17:09 (+01)",
//                 "Sunset": "20:35 (+01)",
//                 "Maghrib": "20:35 (+01)",
//                 "Isha": "22:15 (+01)",
//                 "Imsak": "04:08 (+01)",
//                 "Midnight": "01:20 (+01)"
//             },
//             "date": {
//                 "readable": "07 Jun 2021",
//                 "timestamp": "1623052861",
//                 "gregorian": {
//                     "date": "07-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "07",
//                     "weekday": {
//                         "en": "Monday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "26-10-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "26",
//                     "weekday": {
//                         "en": "Al Athnayn",
//                         "ar": "الاثنين"
//                     },
//                     "month": {
//                         "number": 10,
//                         "en": "Shawwāl",
//                         "ar": "شَوّال"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:18 (+01)",
//                 "Sunrise": "06:05 (+01)",
//                 "Dhuhr": "13:20 (+01)",
//                 "Asr": "17:09 (+01)",
//                 "Sunset": "20:35 (+01)",
//                 "Maghrib": "20:35 (+01)",
//                 "Isha": "22:16 (+01)",
//                 "Imsak": "04:08 (+01)",
//                 "Midnight": "01:20 (+01)"
//             },
//             "date": {
//                 "readable": "08 Jun 2021",
//                 "timestamp": "1623139261",
//                 "gregorian": {
//                     "date": "08-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "08",
//                     "weekday": {
//                         "en": "Tuesday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "27-10-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "27",
//                     "weekday": {
//                         "en": "Al Thalaata",
//                         "ar": "الثلاثاء"
//                     },
//                     "month": {
//                         "number": 10,
//                         "en": "Shawwāl",
//                         "ar": "شَوّال"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:17 (+01)",
//                 "Sunrise": "06:05 (+01)",
//                 "Dhuhr": "13:20 (+01)",
//                 "Asr": "17:09 (+01)",
//                 "Sunset": "20:36 (+01)",
//                 "Maghrib": "20:36 (+01)",
//                 "Isha": "22:17 (+01)",
//                 "Imsak": "04:07 (+01)",
//                 "Midnight": "01:20 (+01)"
//             },
//             "date": {
//                 "readable": "09 Jun 2021",
//                 "timestamp": "1623225661",
//                 "gregorian": {
//                     "date": "09-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "09",
//                     "weekday": {
//                         "en": "Wednesday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "28-10-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "28",
//                     "weekday": {
//                         "en": "Al Arba'a",
//                         "ar": "الاربعاء"
//                     },
//                     "month": {
//                         "number": 10,
//                         "en": "Shawwāl",
//                         "ar": "شَوّال"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:17 (+01)",
//                 "Sunrise": "06:05 (+01)",
//                 "Dhuhr": "13:21 (+01)",
//                 "Asr": "17:09 (+01)",
//                 "Sunset": "20:36 (+01)",
//                 "Maghrib": "20:36 (+01)",
//                 "Isha": "22:17 (+01)",
//                 "Imsak": "04:07 (+01)",
//                 "Midnight": "01:21 (+01)"
//             },
//             "date": {
//                 "readable": "10 Jun 2021",
//                 "timestamp": "1623312061",
//                 "gregorian": {
//                     "date": "10-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "10",
//                     "weekday": {
//                         "en": "Thursday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "29-10-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "29",
//                     "weekday": {
//                         "en": "Al Khamees",
//                         "ar": "الخميس"
//                     },
//                     "month": {
//                         "number": 10,
//                         "en": "Shawwāl",
//                         "ar": "شَوّال"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:17 (+01)",
//                 "Sunrise": "06:05 (+01)",
//                 "Dhuhr": "13:21 (+01)",
//                 "Asr": "17:10 (+01)",
//                 "Sunset": "20:37 (+01)",
//                 "Maghrib": "20:37 (+01)",
//                 "Isha": "22:18 (+01)",
//                 "Imsak": "04:07 (+01)",
//                 "Midnight": "01:21 (+01)"
//             },
//             "date": {
//                 "readable": "11 Jun 2021",
//                 "timestamp": "1623398461",
//                 "gregorian": {
//                     "date": "11-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "11",
//                     "weekday": {
//                         "en": "Friday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "01-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "01",
//                     "weekday": {
//                         "en": "Al Juma'a",
//                         "ar": "الجمعة"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:17 (+01)",
//                 "Sunrise": "06:05 (+01)",
//                 "Dhuhr": "13:21 (+01)",
//                 "Asr": "17:10 (+01)",
//                 "Sunset": "20:37 (+01)",
//                 "Maghrib": "20:37 (+01)",
//                 "Isha": "22:18 (+01)",
//                 "Imsak": "04:07 (+01)",
//                 "Midnight": "01:21 (+01)"
//             },
//             "date": {
//                 "readable": "12 Jun 2021",
//                 "timestamp": "1623484861",
//                 "gregorian": {
//                     "date": "12-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "12",
//                     "weekday": {
//                         "en": "Saturday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "02-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "02",
//                     "weekday": {
//                         "en": "Al Sabt",
//                         "ar": "السبت"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:17 (+01)",
//                 "Sunrise": "06:05 (+01)",
//                 "Dhuhr": "13:21 (+01)",
//                 "Asr": "17:10 (+01)",
//                 "Sunset": "20:38 (+01)",
//                 "Maghrib": "20:38 (+01)",
//                 "Isha": "22:19 (+01)",
//                 "Imsak": "04:07 (+01)",
//                 "Midnight": "01:21 (+01)"
//             },
//             "date": {
//                 "readable": "13 Jun 2021",
//                 "timestamp": "1623571261",
//                 "gregorian": {
//                     "date": "13-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "13",
//                     "weekday": {
//                         "en": "Sunday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "03-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "03",
//                     "weekday": {
//                         "en": "Al Ahad",
//                         "ar": "الاحد"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:17 (+01)",
//                 "Sunrise": "06:05 (+01)",
//                 "Dhuhr": "13:21 (+01)",
//                 "Asr": "17:10 (+01)",
//                 "Sunset": "20:38 (+01)",
//                 "Maghrib": "20:38 (+01)",
//                 "Isha": "22:19 (+01)",
//                 "Imsak": "04:07 (+01)",
//                 "Midnight": "01:21 (+01)"
//             },
//             "date": {
//                 "readable": "14 Jun 2021",
//                 "timestamp": "1623657661",
//                 "gregorian": {
//                     "date": "14-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "14",
//                     "weekday": {
//                         "en": "Monday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "04-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "04",
//                     "weekday": {
//                         "en": "Al Athnayn",
//                         "ar": "الاثنين"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:16 (+01)",
//                 "Sunrise": "06:05 (+01)",
//                 "Dhuhr": "13:22 (+01)",
//                 "Asr": "17:11 (+01)",
//                 "Sunset": "20:38 (+01)",
//                 "Maghrib": "20:38 (+01)",
//                 "Isha": "22:20 (+01)",
//                 "Imsak": "04:06 (+01)",
//                 "Midnight": "01:22 (+01)"
//             },
//             "date": {
//                 "readable": "15 Jun 2021",
//                 "timestamp": "1623744061",
//                 "gregorian": {
//                     "date": "15-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "15",
//                     "weekday": {
//                         "en": "Tuesday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "05-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "05",
//                     "weekday": {
//                         "en": "Al Thalaata",
//                         "ar": "الثلاثاء"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:16 (+01)",
//                 "Sunrise": "06:05 (+01)",
//                 "Dhuhr": "13:22 (+01)",
//                 "Asr": "17:11 (+01)",
//                 "Sunset": "20:39 (+01)",
//                 "Maghrib": "20:39 (+01)",
//                 "Isha": "22:20 (+01)",
//                 "Imsak": "04:06 (+01)",
//                 "Midnight": "01:22 (+01)"
//             },
//             "date": {
//                 "readable": "16 Jun 2021",
//                 "timestamp": "1623830461",
//                 "gregorian": {
//                     "date": "16-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "16",
//                     "weekday": {
//                         "en": "Wednesday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "06-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "06",
//                     "weekday": {
//                         "en": "Al Arba'a",
//                         "ar": "الاربعاء"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:16 (+01)",
//                 "Sunrise": "06:05 (+01)",
//                 "Dhuhr": "13:22 (+01)",
//                 "Asr": "17:11 (+01)",
//                 "Sunset": "20:39 (+01)",
//                 "Maghrib": "20:39 (+01)",
//                 "Isha": "22:20 (+01)",
//                 "Imsak": "04:06 (+01)",
//                 "Midnight": "01:22 (+01)"
//             },
//             "date": {
//                 "readable": "17 Jun 2021",
//                 "timestamp": "1623916861",
//                 "gregorian": {
//                     "date": "17-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "17",
//                     "weekday": {
//                         "en": "Thursday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "07-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "07",
//                     "weekday": {
//                         "en": "Al Khamees",
//                         "ar": "الخميس"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:17 (+01)",
//                 "Sunrise": "06:05 (+01)",
//                 "Dhuhr": "13:22 (+01)",
//                 "Asr": "17:11 (+01)",
//                 "Sunset": "20:39 (+01)",
//                 "Maghrib": "20:39 (+01)",
//                 "Isha": "22:21 (+01)",
//                 "Imsak": "04:07 (+01)",
//                 "Midnight": "01:22 (+01)"
//             },
//             "date": {
//                 "readable": "18 Jun 2021",
//                 "timestamp": "1624003261",
//                 "gregorian": {
//                     "date": "18-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "18",
//                     "weekday": {
//                         "en": "Friday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "08-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "08",
//                     "weekday": {
//                         "en": "Al Juma'a",
//                         "ar": "الجمعة"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:17 (+01)",
//                 "Sunrise": "06:05 (+01)",
//                 "Dhuhr": "13:23 (+01)",
//                 "Asr": "17:12 (+01)",
//                 "Sunset": "20:40 (+01)",
//                 "Maghrib": "20:40 (+01)",
//                 "Isha": "22:21 (+01)",
//                 "Imsak": "04:07 (+01)",
//                 "Midnight": "01:23 (+01)"
//             },
//             "date": {
//                 "readable": "19 Jun 2021",
//                 "timestamp": "1624089661",
//                 "gregorian": {
//                     "date": "19-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "19",
//                     "weekday": {
//                         "en": "Saturday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "09-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "09",
//                     "weekday": {
//                         "en": "Al Sabt",
//                         "ar": "السبت"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:17 (+01)",
//                 "Sunrise": "06:06 (+01)",
//                 "Dhuhr": "13:23 (+01)",
//                 "Asr": "17:12 (+01)",
//                 "Sunset": "20:40 (+01)",
//                 "Maghrib": "20:40 (+01)",
//                 "Isha": "22:21 (+01)",
//                 "Imsak": "04:07 (+01)",
//                 "Midnight": "01:23 (+01)"
//             },
//             "date": {
//                 "readable": "20 Jun 2021",
//                 "timestamp": "1624176061",
//                 "gregorian": {
//                     "date": "20-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "20",
//                     "weekday": {
//                         "en": "Sunday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "10-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "10",
//                     "weekday": {
//                         "en": "Al Ahad",
//                         "ar": "الاحد"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:17 (+01)",
//                 "Sunrise": "06:06 (+01)",
//                 "Dhuhr": "13:23 (+01)",
//                 "Asr": "17:12 (+01)",
//                 "Sunset": "20:40 (+01)",
//                 "Maghrib": "20:40 (+01)",
//                 "Isha": "22:22 (+01)",
//                 "Imsak": "04:07 (+01)",
//                 "Midnight": "01:23 (+01)"
//             },
//             "date": {
//                 "readable": "21 Jun 2021",
//                 "timestamp": "1624262461",
//                 "gregorian": {
//                     "date": "21-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "21",
//                     "weekday": {
//                         "en": "Monday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "11-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "11",
//                     "weekday": {
//                         "en": "Al Athnayn",
//                         "ar": "الاثنين"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:17 (+01)",
//                 "Sunrise": "06:06 (+01)",
//                 "Dhuhr": "13:23 (+01)",
//                 "Asr": "17:12 (+01)",
//                 "Sunset": "20:40 (+01)",
//                 "Maghrib": "20:40 (+01)",
//                 "Isha": "22:22 (+01)",
//                 "Imsak": "04:07 (+01)",
//                 "Midnight": "01:23 (+01)"
//             },
//             "date": {
//                 "readable": "22 Jun 2021",
//                 "timestamp": "1624348861",
//                 "gregorian": {
//                     "date": "22-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "22",
//                     "weekday": {
//                         "en": "Tuesday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "12-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "12",
//                     "weekday": {
//                         "en": "Al Thalaata",
//                         "ar": "الثلاثاء"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:18 (+01)",
//                 "Sunrise": "06:06 (+01)",
//                 "Dhuhr": "13:23 (+01)",
//                 "Asr": "17:12 (+01)",
//                 "Sunset": "20:40 (+01)",
//                 "Maghrib": "20:40 (+01)",
//                 "Isha": "22:22 (+01)",
//                 "Imsak": "04:08 (+01)",
//                 "Midnight": "01:23 (+01)"
//             },
//             "date": {
//                 "readable": "23 Jun 2021",
//                 "timestamp": "1624435261",
//                 "gregorian": {
//                     "date": "23-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "23",
//                     "weekday": {
//                         "en": "Wednesday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "13-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "13",
//                     "weekday": {
//                         "en": "Al Arba'a",
//                         "ar": "الاربعاء"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:18 (+01)",
//                 "Sunrise": "06:07 (+01)",
//                 "Dhuhr": "13:24 (+01)",
//                 "Asr": "17:13 (+01)",
//                 "Sunset": "20:41 (+01)",
//                 "Maghrib": "20:41 (+01)",
//                 "Isha": "22:22 (+01)",
//                 "Imsak": "04:08 (+01)",
//                 "Midnight": "01:24 (+01)"
//             },
//             "date": {
//                 "readable": "24 Jun 2021",
//                 "timestamp": "1624521661",
//                 "gregorian": {
//                     "date": "24-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "24",
//                     "weekday": {
//                         "en": "Thursday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "14-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "14",
//                     "weekday": {
//                         "en": "Al Khamees",
//                         "ar": "الخميس"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:18 (+01)",
//                 "Sunrise": "06:07 (+01)",
//                 "Dhuhr": "13:24 (+01)",
//                 "Asr": "17:13 (+01)",
//                 "Sunset": "20:41 (+01)",
//                 "Maghrib": "20:41 (+01)",
//                 "Isha": "22:22 (+01)",
//                 "Imsak": "04:08 (+01)",
//                 "Midnight": "01:24 (+01)"
//             },
//             "date": {
//                 "readable": "25 Jun 2021",
//                 "timestamp": "1624608061",
//                 "gregorian": {
//                     "date": "25-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "25",
//                     "weekday": {
//                         "en": "Friday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "15-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "15",
//                     "weekday": {
//                         "en": "Al Juma'a",
//                         "ar": "الجمعة"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:19 (+01)",
//                 "Sunrise": "06:07 (+01)",
//                 "Dhuhr": "13:24 (+01)",
//                 "Asr": "17:13 (+01)",
//                 "Sunset": "20:41 (+01)",
//                 "Maghrib": "20:41 (+01)",
//                 "Isha": "22:22 (+01)",
//                 "Imsak": "04:09 (+01)",
//                 "Midnight": "01:24 (+01)"
//             },
//             "date": {
//                 "readable": "26 Jun 2021",
//                 "timestamp": "1624694461",
//                 "gregorian": {
//                     "date": "26-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "26",
//                     "weekday": {
//                         "en": "Saturday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "16-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "16",
//                     "weekday": {
//                         "en": "Al Sabt",
//                         "ar": "السبت"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:19 (+01)",
//                 "Sunrise": "06:08 (+01)",
//                 "Dhuhr": "13:24 (+01)",
//                 "Asr": "17:13 (+01)",
//                 "Sunset": "20:41 (+01)",
//                 "Maghrib": "20:41 (+01)",
//                 "Isha": "22:22 (+01)",
//                 "Imsak": "04:09 (+01)",
//                 "Midnight": "01:24 (+01)"
//             },
//             "date": {
//                 "readable": "27 Jun 2021",
//                 "timestamp": "1624780861",
//                 "gregorian": {
//                     "date": "27-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "27",
//                     "weekday": {
//                         "en": "Sunday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "17-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "17",
//                     "weekday": {
//                         "en": "Al Ahad",
//                         "ar": "الاحد"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:20 (+01)",
//                 "Sunrise": "06:08 (+01)",
//                 "Dhuhr": "13:24 (+01)",
//                 "Asr": "17:13 (+01)",
//                 "Sunset": "20:41 (+01)",
//                 "Maghrib": "20:41 (+01)",
//                 "Isha": "22:22 (+01)",
//                 "Imsak": "04:10 (+01)",
//                 "Midnight": "01:24 (+01)"
//             },
//             "date": {
//                 "readable": "28 Jun 2021",
//                 "timestamp": "1624867261",
//                 "gregorian": {
//                     "date": "28-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "28",
//                     "weekday": {
//                         "en": "Monday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "18-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "18",
//                     "weekday": {
//                         "en": "Al Athnayn",
//                         "ar": "الاثنين"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:20 (+01)",
//                 "Sunrise": "06:08 (+01)",
//                 "Dhuhr": "13:25 (+01)",
//                 "Asr": "17:14 (+01)",
//                 "Sunset": "20:41 (+01)",
//                 "Maghrib": "20:41 (+01)",
//                 "Isha": "22:22 (+01)",
//                 "Imsak": "04:10 (+01)",
//                 "Midnight": "01:25 (+01)"
//             },
//             "date": {
//                 "readable": "29 Jun 2021",
//                 "timestamp": "1624953661",
//                 "gregorian": {
//                     "date": "29-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "29",
//                     "weekday": {
//                         "en": "Tuesday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "19-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "19",
//                     "weekday": {
//                         "en": "Al Thalaata",
//                         "ar": "الثلاثاء"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// },
//         {
//             "timings": {
//                 "Fajr": "04:21 (+01)",
//                 "Sunrise": "06:09 (+01)",
//                 "Dhuhr": "13:25 (+01)",
//                 "Asr": "17:14 (+01)",
//                 "Sunset": "20:41 (+01)",
//                 "Maghrib": "20:41 (+01)",
//                 "Isha": "22:22 (+01)",
//                 "Imsak": "04:11 (+01)",
//                 "Midnight": "01:25 (+01)"
//             },
//             "date": {
//                 "readable": "30 Jun 2021",
//                 "timestamp": "1625040061",
//                 "gregorian": {
//                     "date": "30-06-2021",
//                     "format": "DD-MM-YYYY",
//                     "day": "30",
//                     "weekday": {
//                         "en": "Wednesday"
//                     },
//                     "month": {
//                         "number": 6,
//                         "en": "June"
//                     },
//                     "year": "2021",
//                     "designation": {
//                         "abbreviated": "AD",
//                         "expanded": "Anno Domini"
//                     }
//                 },
//                 "hijri": {
//                     "date": "20-11-1442",
//                     "format": "DD-MM-YYYY",
//                     "day": "20",
//                     "weekday": {
//                         "en": "Al Arba'a",
//                         "ar": "الاربعاء"
//                     },
//                     "month": {
//                         "number": 11,
//                         "en": "Dhū al-Qaʿdah",
//                         "ar": "ذوالقعدة"
//                     },
//                     "year": "1442",
//                     "designation": {
//                         "abbreviated": "AH",
//                         "expanded": "Anno Hegirae"
//                     },
//                     "holidays": []
//                 }
//             },
//             "meta": {
//                 "latitude": 35.6243514,
//                 "longitude": -5.2769693,
//                 "timezone": "Africa/Casablanca",
//                 "method": {
//                     "id": 3,
//                     "name": "Muslim World League",
//                     "params": {
//                         "Fajr": 18,
//                         "Isha": 17
//                     }
//                 },
//                 "latitudeAdjustmentMethod": "ANGLE_BASED",
//                 "midnightMode": "STANDARD",
//                 "school": "STANDARD",
//                 "offset": {
//                     "Imsak": 0,
//                     "Fajr": 0,
//                     "Sunrise": 0,
//                     "Dhuhr": 0,
//                     "Asr": 0,
//                     "Maghrib": 0,
//                     "Sunset": 0,
//                     "Isha": 0,
//                     "Midnight": 0
//                 }
//             }
// }
// ]
// }
//   """;
//   dt = jsonDecode(responseBody)["data"];
//   // dt = jsonDecode(response.body)["data"];
//
//   print('dt: $dt');
//
//   int index = 0;
//   var date;
//
//   for (var day in dt) {
//     print('day ${index + 1} saved');
//     print(index);
//     timings = day["timings"];
//     date = DateTime(DateTime.now().year, DateTime.now().month, index + 1);
//     List<Salah> salahList = [
//       Salah('الفجر', 'Fajr', timings["Fajr"].toString().substring(0, 5), true, date),
//       Salah('الشروق', 'Sunrise', timings["Sunrise"].toString().substring(0, 5), false, date),
//       Salah('الظهر', 'Dhuhr', timings["Dhuhr"].toString().substring(0, 5), true, date),
//       Salah('العصر', 'Asr', timings["Asr"].toString().substring(0, 5), true, date),
//       Salah('المغرب', 'Maghrib', timings["Maghrib"].toString().substring(0, 5), true, date),
//       Salah('العشاء', 'Isha', timings["Isha"].toString().substring(0, 5), true, date),
//     ];
//     await saveSalahListToDatabase(salahList);
//     index++;
//   }
// }
//
// Future saveSalahListToDatabase(List<Salah> listSalah) async {
//   for (Salah salah in listSalah) {
//     await DBProvider.db.newSalah(salah);
//   }
// }
//
// Future<List<Salah>> getSalahOfTheDay() async {
//   int timestamp = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
//           .toUtc().millisecondsSinceEpoch;
//   List<Salah> list = await DBProvider.db.findSalahByTimestamp(timestamp);
//
//   if (list.isEmpty) {
//     try {
//       await loadSalahFromOnline(await getLatitude(), await getLongitude(), await getMethod(),
//           DateTime.now().day, DateTime.now().month, DateTime.now().year);
//       list = await DBProvider.db.findSalahByTimestamp(timestamp);
//     } catch (e) {
//       print('From getSalahOfTheDay: $e');
//     }
//   }
//   return list;
// }
//
// Future<List<Salah>> getSalahByDay({DateTime dateTime}) async {
//   int timestamp = DateTime(dateTime.year, dateTime.month, dateTime.day)
//       .toUtc().millisecondsSinceEpoch;
//   List<Salah> list = await DBProvider.db.findSalahByTimestamp(timestamp);
//
//   if (list.isEmpty) {
//     try {
//       await loadSalahFromOnline(await getLatitude(), await getLongitude(), await getMethod(),
//           DateTime.now().day, DateTime.now().month, DateTime.now().year);
//       list = await DBProvider.db.findSalahByTimestamp(timestamp);
//     } catch (e) {
//       print('From getSalahOfTheDay: $e');
//     }
//   }
//   return list;
// }
