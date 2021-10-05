import 'dart:convert';

SalahModel salahModelFromJson(String str) => SalahModel.fromJson(json.decode(str));

String salahModelToJson(SalahModel data) => json.encode(data.toJson());

class SalahModel {
  SalahModel({
    this.code,
    this.status,
    this.data,
  });

  int code;
  String status;
  Data data;

  factory SalahModel.fromJson(Map<String, dynamic> json) => SalahModel(
    code: json["code"],
    status: json["status"],
    data: json["data"] != null ? Data.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.timings,
    this.date,
  });

  Timings timings;
  Date date;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    timings: Timings.fromJson(json["timings"]),
    date: Date.fromJson(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "timings": timings.toJson(),
    "date": date.toJson(),
  };
}

class Date {
  Date({
    this.readable,
    this.dateHijri,
    this.timestamp,
  });

  String readable;
  String dateHijri;
  DateTime timestamp;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    readable: json["readable"],
    dateHijri: json["date_hijri"],
    timestamp: DateTime.fromMillisecondsSinceEpoch(json["timestamp"] * 1000, isUtc: true),
  );

  Map<String, dynamic> toJson() => {
    "readable": readable,
    "date_hijri": dateHijri,
    "timestamp": timestamp,
  };
}

class Timings {
  Timings({
    this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.maghrib,
    this.isha,
  });

  String fajr;
  String sunrise;
  String dhuhr;
  String asr;
  String maghrib;
  String isha;

  factory Timings.fromJson(Map<String, dynamic> json) => Timings(
    fajr: json["Fajr"],
    sunrise: json["Sunrise"],
    dhuhr: json["Dhuhr"],
    asr: json["Asr"],
    maghrib: json["Maghrib"],
    isha: json["Isha"],
  );

  Map<String, dynamic> toJson() => {
    "Fajr": fajr,
    "Sunrise": sunrise,
    "Dhuhr": dhuhr,
    "Asr": asr,
    "Maghrib": maghrib,
    "Isha": isha,
  };
}
