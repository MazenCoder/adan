// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_app.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MobxApp on MobxAppBase, Store {
  final _$queryAtom = Atom(name: 'MobxAppBase.query');

  @override
  String get query {
    _$queryAtom.reportRead();
    return super.query;
  }

  @override
  set query(String value) {
    _$queryAtom.reportWrite(value, super.query, () {
      super.query = value;
    });
  }

  final _$indexAtom = Atom(name: 'MobxAppBase.index');

  @override
  int get index {
    _$indexAtom.reportRead();
    return super.index;
  }

  @override
  set index(int value) {
    _$indexAtom.reportWrite(value, super.index, () {
      super.index = value;
    });
  }

  final _$directionAtom = Atom(name: 'MobxAppBase.direction');

  @override
  double get direction {
    _$directionAtom.reportRead();
    return super.direction;
  }

  @override
  set direction(double value) {
    _$directionAtom.reportWrite(value, super.direction, () {
      super.direction = value;
    });
  }

  final _$endTimeAtom = Atom(name: 'MobxAppBase.endTime');

  @override
  int get endTime {
    _$endTimeAtom.reportRead();
    return super.endTime;
  }

  @override
  set endTime(int value) {
    _$endTimeAtom.reportWrite(value, super.endTime, () {
      super.endTime = value;
    });
  }

  final _$salahAtom = Atom(name: 'MobxAppBase.salah');

  @override
  dynamic get salah {
    _$salahAtom.reportRead();
    return super.salah;
  }

  @override
  set salah(dynamic value) {
    _$salahAtom.reportWrite(value, super.salah, () {
      super.salah = value;
    });
  }

  final _$MobxAppBaseActionController = ActionController(name: 'MobxAppBase');

  @override
  void setQuery(String search) {
    final _$actionInfo =
        _$MobxAppBaseActionController.startAction(name: 'MobxAppBase.setQuery');
    try {
      return super.setQuery(search);
    } finally {
      _$MobxAppBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIndex(int val) {
    final _$actionInfo =
        _$MobxAppBaseActionController.startAction(name: 'MobxAppBase.setIndex');
    try {
      return super.setIndex(val);
    } finally {
      _$MobxAppBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDirection(double val) {
    final _$actionInfo = _$MobxAppBaseActionController.startAction(
        name: 'MobxAppBase.setDirection');
    try {
      return super.setDirection(val);
    } finally {
      _$MobxAppBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEndTime(int val) {
    final _$actionInfo = _$MobxAppBaseActionController.startAction(
        name: 'MobxAppBase.setEndTime');
    try {
      return super.setEndTime(val);
    } finally {
      _$MobxAppBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSalah(dynamic val) {
    final _$actionInfo =
        _$MobxAppBaseActionController.startAction(name: 'MobxAppBase.setSalah');
    try {
      return super.setSalah(val);
    } finally {
      _$MobxAppBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
query: ${query},
index: ${index},
direction: ${direction},
endTime: ${endTime},
salah: ${salah}
    ''';
  }
}
