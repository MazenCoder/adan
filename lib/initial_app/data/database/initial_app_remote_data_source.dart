import 'package:adan/initial_app/data/models/salah_model.dart';
import 'package:adan/initial_app/data/models/ville_model.dart';
import 'package:adan/helpers/preference_utils.dart';
import 'package:adan/error/failures.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:adan/main.dart';
import 'package:get/get.dart';



abstract class InitialAppRemoteDataSource {
  Future<VilleModel> getVilles(String products);
  Future<SalahModel> getHorairePriere(String products);
}

class InitialAppRemoteDataSourceImpl implements InitialAppRemoteDataSource {

  final http.Client client;
  InitialAppRemoteDataSourceImpl({
    @required this.client,
  });
  final logger = Logger();


  @override
  Future<SalahModel> getHorairePriere(String products) async {
    try {
      print("getHorairePriere: $products");
      http.Response response = await client.post(
        Uri.parse("http://inoser-education.com/Adhan/json/HorairePriere_ws"),
        body: {
          "adan_ws": products
        },
      );

      if (PreferenceUtils.containsKey(KEY_SALAH_JSON)) {
        await PreferenceUtils.removeKey(KEY_SALAH_JSON);
      }
      await PreferenceUtils.setString(KEY_SALAH_JSON, response.body);
      SalahModel model = salahModelFromJson(response.body);
      if (model != null && model.data != null) {
        await PreferenceUtils.setString(
          KEY_TIMESTAMP_JSON,
          model.data.date.timestamp.toString(),
        );
      }

      return model;
    } catch(_) {
      throw ServerFailure(message: 'error_server'.tr);
    }
  }

  @override
  Future<VilleModel> getVilles(String products) async {
    try {
      print("getVilles: $products");
      http.Response response = await client.post(
        Uri.parse("http://inoser-education.com/Adhan/json/Villes_ws"),
        body: {"adan_ws": """{"token":"123456"}"""},
      );

      print("response.body: ${response.body}");
      return villeModelFromJson(response.body);

    } catch(_) {
      throw ServerFailure(message: 'error_server'.tr);
    }
  }
}