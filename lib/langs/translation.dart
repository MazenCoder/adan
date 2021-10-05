import 'package:adan/langs/fr.dart';
import 'package:adan/langs/ar.dart';
import 'package:get/get.dart';


class Translation extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    'fr': fr,
    'ar': ar,
  };
}