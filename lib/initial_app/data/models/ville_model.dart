import 'package:adan/database/app_database.dart';
import 'dart:convert';


VilleModel villeModelFromJson(String str) => VilleModel.fromJson(json.decode(str));

String villeModelToJson(VilleModel data) => json.encode(data.toJson());

class VilleModel {
  VilleModel({
    this.code,
    this.status,
    this.message,
    this.villes,
  });

  int code;
  String status;
  String message;
  List<VilleMod> villes;

  factory VilleModel.fromJson(Map<String, dynamic> json) => VilleModel(
    code: json["code"],
    message: json["message"],
    status: json["status"],
    villes: List<VilleMod>.from(json["Villes"].map((x) => VilleMod.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "Villes": List<VilleMod>.from(villes.map((x) => x.toJsonMod())),
  };
}

class VilleMod extends Ville {
  VilleMod({
    this.idVille,
    this.ville,
    this.villeAr,
  }) : super(
    id_ville: idVille,
    ville: ville,
    ville_ar: villeAr
  );

  int idVille;
  String ville;
  String villeAr;

  factory VilleMod.fromJson(Map<String, dynamic> json) => VilleMod(
    idVille: json["id_ville"],
    ville: json["ville"],
    villeAr: json["ville_ar"],
  );

  Map<String, dynamic> toJsonMod() => {
    "id_ville": idVille,
    "ville": ville,
    "ville_ar": villeAr,
  };
}
