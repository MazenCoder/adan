import 'package:adan/helpers/preference_utils.dart';
import 'package:after_layout/after_layout.dart';
import 'package:adan/helpers/app_utils.dart';
import 'package:adan/widgets/error_app.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get/get.dart';
import 'home_page.dart';
import '../main.dart';



class InitialScreen extends StatefulWidget {
  static String route = '/InitialScreen';
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen>
    with AfterLayoutMixin<InitialScreen> {

  final AppUtils appUtils = GetIt.I.get<AppUtils>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: SizedBox(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          // width: 20, height: 20,
        )),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    final timestamp = PreferenceUtils.getString(KEY_TIMESTAMP_JSON);
    if (timestamp.isNotEmpty) {
      DateTime times = DateTime.parse(timestamp);
      final now = DateTime.now();
      print("now: $now times: $times");
      if (true) { // TEST
      // if (now.year > times.year && now.month > times.month && now.day > times.day) {
        final ville = PreferenceUtils.getInt(KEY_VILLE_ID, 1);
        await appUtils.getHorairePriereCache(context, ville).then((value) async {
          if (value??false) {
            Get.offAll(() => HomePage());
          } else {
            Get.offAll(() => ErrorApp());
          }
        });
      } else {
        Get.offAll(() => HomePage());
      }
    } else {
      final ville = PreferenceUtils.getInt(KEY_VILLE_ID, 1);
      await appUtils.getHorairePriereCache(context, ville).then((value) async {
        if (value??false) {
          Get.offAll(() => HomePage());
        } else {
          Get.offAll(() => ErrorApp());
        }
      });
    }
  }
}


