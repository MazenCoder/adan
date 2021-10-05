import 'package:adan/initial_app/data/repositories/search_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adan/widgets/loading_dialog.dart';
import 'package:adan/database/app_database.dart';
import 'package:adan/usecases/flash_helper.dart';
import 'package:adan/network/network_info.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'injection_container.dart';
import 'package:adan/main.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'app_utils.dart';



class AppUtilsImpl extends AppUtils {

  final SharedPreferences preferences;
  final NetworkInfo networkInfo;
  final AppDatabase database;
  var logger = Logger();

  AppUtilsImpl({this.preferences, this.database, this.networkInfo}) {
    Future.delayed(Duration(seconds: 3)).then((_) => sl.signalReady(this));
  }

  @override
  Future<bool> getHorairePriere(BuildContext context, int id) async {
    try {
      if (await networkInfo.isConnected) {
        LoadingDialog.show(context);
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd').format(now);
        final impl = InitialAppRepositoryImpl(
          networkInfo: sl(),
          localDataSource: sl(),
          remoteDataSource: sl(),
        );
        final params = """{"token":"123456", "id_ville":"$id", "date":"$formattedDate"}""";
        print('params: $params');
        final priere = await impl.remoteDataSource.getHorairePriere(params);
        if (priere != null && priere.status.contains('OK')) {
          await database.delete(database.salahs).go();
          await impl.localDataSource.cacheSalah(priere);
          LoadingDialog.hide(context);
          await preferences.setInt(KEY_VILLE_ID, id);
          return true;
        }
        LoadingDialog.hide(context);
        return false;
      } else {
        FlashHelper.errorBar(context, message: "error_connection".tr);
        return false;
      }
    } catch(e) {
      logger.e('$e');
      LoadingDialog.hide(context);
      FlashHelper.errorBar(context, message: "error_wrong".tr);
      return false;
    }
  }

  @override
  Future<bool> getHorairePriereCache(BuildContext context, int id) async {
    try {
      if (await networkInfo.isConnected) {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd').format(now);
        final impl = InitialAppRepositoryImpl(
          networkInfo: sl(),
          localDataSource: sl(),
          remoteDataSource: sl(),
        );
        final params = """{"token":"123456", "id_ville":"$id", "date":"$formattedDate"}""";
        final priere = await impl.remoteDataSource.getHorairePriere(params);
        if (priere != null && priere.status.contains('OK')) {
          await impl.localDataSource.cacheSalah(priere);
          return true;
        }
        return false;
      } else {
        FlashHelper.errorBar(context, message: 'error_connection'.tr);
      }
    } catch(e) {
      logger.e('$e');
      FlashHelper.errorBar(context, message: "error_wrong".tr);
      return false;
    }
  }

  @override
  Future<List<Salah>> getAllSalah() async {
    return await database.salahsDao.getAllSalah()??[];
  }

  @override
  Future<void> updateSalahNotification(Salah salah, bool val) async {
    await database.salahsDao.updateNotification(id: salah.id, val: val);
    await preferences.setBool('${salah.id}', val);
  }

  @override
  Future<Ville> getVilleById() async {
    int villeId = preferences.getInt(KEY_VILLE_ID)??1;
    return await database.villesDao.getVilleById(villeId);
  }

  @override
  Future<void> openSetting(BuildContext context) async {
    final size = MediaQuery.of(context).size;
    return showDialog(context: context,
      builder: (context) => new AlertDialog(
        title: new Text("battery_settings".tr,
          textAlign: TextAlign.center,
        ),
        content: Container(
          height: size.height - 300,
          child: new Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('msg_setting'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14
                  ),
                ),
              ),
              Flexible(
                child: Image.asset("assets/step.webp",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          new TextButton(
            onPressed: () => Get.back(),
            child: new Text('cancel'.tr),
          ),
          new TextButton(
            onPressed: () async {
              // PreferenceUtils.setBool(Keys.SETTINGS, true);
              // return await AppSettings.openBatteryOptimizationSettings().then((value) {
              //   Get.back();
              // });
            },
            child: new Text('open_settings'.tr),
          ),
        ],
      ),
    );
  }
}