import 'package:permission_handler/permission_handler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


Future<bool> requestPermission(Permission permission) async {
  if (!await permission.request().isGranted) {
    await permission.request();
  }
  // final PermissionHandler _permissionHandler = PermissionHandler();
  // var result = await _permissionHandler.requestPermissions([permission]);
  // if (result[permission] == PermissionStatus.granted) {
  //   return true;
  // }
  // return false;
  return (await permission.request().isGranted);
}

Future checkGps(BuildContext context,Function callback) async {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  if (!(await _geolocatorPlatform.isLocationServiceEnabled())) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 150,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                    child: Icon(
                      Icons.location_off,
                      size: 50,
                      color: Colors.black45,
                    ),
                  ),
                  Text(
                    'make_sure_gps_turn'.tr,
                    style: GoogleFonts.tajawal(
                      height: 1.9,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text(
                    "try_again".tr,
                    style: GoogleFonts.tajawal(),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    callback();
                  })
            ],
          );
        });
  }
}

Future<bool> checkGPSEnabled() async {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  return await _geolocatorPlatform.isLocationServiceEnabled();
}

Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
  if (!await Permission.location.request().isGranted) {
    await Permission.location.request();
  }
  // var granted = await requestPermission(PermissionGroup.location);
  return (await Permission.location.request().isGranted);
}

Future<bool> requestNotificationPermission({Function onPermissionDenied}) async {
  if (!await Permission.notification.request().isGranted) {
    await Permission.notification.request();
  }
  // var granted = await requestPermission(PermissionGroup.notification);
  return (await Permission.notification.request().isGranted);
}
