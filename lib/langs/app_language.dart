import 'package:adan/helpers/preference_utils.dart';
import 'package:get/get.dart';
import '../main.dart';


class AppLanguage extends GetxController {

  @override
  void onInit() {
    super.onInit();
  }

  void saveLanguage(String lang) async {
    await PreferenceUtils.setString(KEY_LOCALE, lang);
    update();
  }
}