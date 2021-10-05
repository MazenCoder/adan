import 'package:adan/database/app_database.dart';
import 'package:flutter/material.dart';


abstract class AppUtils extends ChangeNotifier {

  Future<bool> getHorairePriere(BuildContext context, int id);
  Future<bool> getHorairePriereCache(BuildContext context, int id);
  Future<List<Salah>> getAllSalah();
  Future<void> updateSalahNotification(Salah salah, bool val);
  Future<Ville> getVilleById();
  Future<void> openSetting(BuildContext context);
}
