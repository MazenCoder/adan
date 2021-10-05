import 'package:adan/database/app_database.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'mobx_app.g.dart';

class MobxApp = MobxAppBase with _$MobxApp;

abstract class MobxAppBase with Store {

  @observable
  String query = '';

  @action
  void setQuery(String search) => this.query = search;

  @observable
  int index;

  @action
  void setIndex(int val) => this.index = val;

  @observable
  double direction = 0;

  @action
  void setDirection(double val) => this.direction = val;

  @observable
  int endTime = 0;

  @action
  void setEndTime(int val) => this.endTime = val;

  @observable
  var salah;

  @action
  void setSalah(Salah val) => this.salah = val;

}