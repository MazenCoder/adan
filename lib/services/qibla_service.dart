import 'package:adan/shared_pref/location_pref.dart';
import 'package:adan/shared_pref/method_pref.dart';
import 'package:adan/shared_pref/qibla_pref.dart';
import 'package:adan/shared_pref/data_json.dart';
import 'package:adan/database/db_provider.dart';
import 'package:adan/model/salah.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:ffi';
import 'dart:io';


String url = 'https://api.aladhan.com/v1/qibla';

Future<double> getQiblaDirection() async {

  final response = await http.get(Uri.parse('$url/${await getLatitude()}/${await getLongitude()}'));
  print(response);
  if(jsonDecode(response.body)["data"]["direction"] is double){
    double direction = jsonDecode(response.body)["data"]["direction"];
    await setQibla(direction);
    return direction;
  }
  double dir =  await getQibla();
  return dir;
}

