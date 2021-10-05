// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Salah extends DataClass implements Insertable<Salah> {
  final int id;
  final String name;
  final String englishName;
  final String time;
  final String dateHijri;
  final bool isNotificationEnabled;
  final DateTime date;
  Salah(
      {@required this.id,
      @required this.name,
      this.englishName,
      this.time,
      this.dateHijri,
      @required this.isNotificationEnabled,
      @required this.date});
  factory Salah.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Salah(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      englishName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}english_name']),
      time: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time']),
      dateHijri: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date_hijri']),
      isNotificationEnabled: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}is_notification_enabled']),
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || englishName != null) {
      map['english_name'] = Variable<String>(englishName);
    }
    if (!nullToAbsent || time != null) {
      map['time'] = Variable<String>(time);
    }
    if (!nullToAbsent || dateHijri != null) {
      map['date_hijri'] = Variable<String>(dateHijri);
    }
    if (!nullToAbsent || isNotificationEnabled != null) {
      map['is_notification_enabled'] = Variable<bool>(isNotificationEnabled);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    return map;
  }

  SalahsCompanion toCompanion(bool nullToAbsent) {
    return SalahsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      englishName: englishName == null && nullToAbsent
          ? const Value.absent()
          : Value(englishName),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
      dateHijri: dateHijri == null && nullToAbsent
          ? const Value.absent()
          : Value(dateHijri),
      isNotificationEnabled: isNotificationEnabled == null && nullToAbsent
          ? const Value.absent()
          : Value(isNotificationEnabled),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  factory Salah.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Salah(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      englishName: serializer.fromJson<String>(json['englishName']),
      time: serializer.fromJson<String>(json['time']),
      dateHijri: serializer.fromJson<String>(json['dateHijri']),
      isNotificationEnabled:
          serializer.fromJson<bool>(json['isNotificationEnabled']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'englishName': serializer.toJson<String>(englishName),
      'time': serializer.toJson<String>(time),
      'dateHijri': serializer.toJson<String>(dateHijri),
      'isNotificationEnabled': serializer.toJson<bool>(isNotificationEnabled),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Salah copyWith(
          {int id,
          String name,
          String englishName,
          String time,
          String dateHijri,
          bool isNotificationEnabled,
          DateTime date}) =>
      Salah(
        id: id ?? this.id,
        name: name ?? this.name,
        englishName: englishName ?? this.englishName,
        time: time ?? this.time,
        dateHijri: dateHijri ?? this.dateHijri,
        isNotificationEnabled:
            isNotificationEnabled ?? this.isNotificationEnabled,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Salah(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('englishName: $englishName, ')
          ..write('time: $time, ')
          ..write('dateHijri: $dateHijri, ')
          ..write('isNotificationEnabled: $isNotificationEnabled, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              englishName.hashCode,
              $mrjc(
                  time.hashCode,
                  $mrjc(
                      dateHijri.hashCode,
                      $mrjc(
                          isNotificationEnabled.hashCode, date.hashCode)))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Salah &&
          other.id == this.id &&
          other.name == this.name &&
          other.englishName == this.englishName &&
          other.time == this.time &&
          other.dateHijri == this.dateHijri &&
          other.isNotificationEnabled == this.isNotificationEnabled &&
          other.date == this.date);
}

class SalahsCompanion extends UpdateCompanion<Salah> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> englishName;
  final Value<String> time;
  final Value<String> dateHijri;
  final Value<bool> isNotificationEnabled;
  final Value<DateTime> date;
  const SalahsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.englishName = const Value.absent(),
    this.time = const Value.absent(),
    this.dateHijri = const Value.absent(),
    this.isNotificationEnabled = const Value.absent(),
    this.date = const Value.absent(),
  });
  SalahsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.englishName = const Value.absent(),
    this.time = const Value.absent(),
    this.dateHijri = const Value.absent(),
    this.isNotificationEnabled = const Value.absent(),
    @required DateTime date,
  })  : name = Value(name),
        date = Value(date);
  static Insertable<Salah> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> englishName,
    Expression<String> time,
    Expression<String> dateHijri,
    Expression<bool> isNotificationEnabled,
    Expression<DateTime> date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (englishName != null) 'english_name': englishName,
      if (time != null) 'time': time,
      if (dateHijri != null) 'date_hijri': dateHijri,
      if (isNotificationEnabled != null)
        'is_notification_enabled': isNotificationEnabled,
      if (date != null) 'date': date,
    });
  }

  SalahsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> englishName,
      Value<String> time,
      Value<String> dateHijri,
      Value<bool> isNotificationEnabled,
      Value<DateTime> date}) {
    return SalahsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      englishName: englishName ?? this.englishName,
      time: time ?? this.time,
      dateHijri: dateHijri ?? this.dateHijri,
      isNotificationEnabled:
          isNotificationEnabled ?? this.isNotificationEnabled,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (englishName.present) {
      map['english_name'] = Variable<String>(englishName.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    if (dateHijri.present) {
      map['date_hijri'] = Variable<String>(dateHijri.value);
    }
    if (isNotificationEnabled.present) {
      map['is_notification_enabled'] =
          Variable<bool>(isNotificationEnabled.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalahsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('englishName: $englishName, ')
          ..write('time: $time, ')
          ..write('dateHijri: $dateHijri, ')
          ..write('isNotificationEnabled: $isNotificationEnabled, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $SalahsTable extends Salahs with TableInfo<$SalahsTable, Salah> {
  final GeneratedDatabase _db;
  final String _alias;
  $SalahsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedColumn<int> _id;
  @override
  GeneratedColumn<int> get id =>
      _id ??= GeneratedColumn<int>('id', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedColumn<String> _name;
  @override
  GeneratedColumn<String> get name =>
      _name ??= GeneratedColumn<String>('name', aliasedName, false,
          typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _englishNameMeta =
      const VerificationMeta('englishName');
  GeneratedColumn<String> _englishName;
  @override
  GeneratedColumn<String> get englishName => _englishName ??=
      GeneratedColumn<String>('english_name', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _timeMeta = const VerificationMeta('time');
  GeneratedColumn<String> _time;
  @override
  GeneratedColumn<String> get time =>
      _time ??= GeneratedColumn<String>('time', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _dateHijriMeta = const VerificationMeta('dateHijri');
  GeneratedColumn<String> _dateHijri;
  @override
  GeneratedColumn<String> get dateHijri =>
      _dateHijri ??= GeneratedColumn<String>('date_hijri', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _isNotificationEnabledMeta =
      const VerificationMeta('isNotificationEnabled');
  GeneratedColumn<bool> _isNotificationEnabled;
  @override
  GeneratedColumn<bool> get isNotificationEnabled => _isNotificationEnabled ??=
      GeneratedColumn<bool>('is_notification_enabled', aliasedName, false,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints: 'CHECK (is_notification_enabled IN (0, 1))',
          defaultValue: Constant(true));
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedColumn<DateTime> _date;
  @override
  GeneratedColumn<DateTime> get date =>
      _date ??= GeneratedColumn<DateTime>('date', aliasedName, false,
          typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, englishName, time, dateHijri, isNotificationEnabled, date];
  @override
  String get aliasedName => _alias ?? 'salahs';
  @override
  String get actualTableName => 'salahs';
  @override
  VerificationContext validateIntegrity(Insertable<Salah> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('english_name')) {
      context.handle(
          _englishNameMeta,
          englishName.isAcceptableOrUnknown(
              data['english_name'], _englishNameMeta));
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time'], _timeMeta));
    }
    if (data.containsKey('date_hijri')) {
      context.handle(_dateHijriMeta,
          dateHijri.isAcceptableOrUnknown(data['date_hijri'], _dateHijriMeta));
    }
    if (data.containsKey('is_notification_enabled')) {
      context.handle(
          _isNotificationEnabledMeta,
          isNotificationEnabled.isAcceptableOrUnknown(
              data['is_notification_enabled'], _isNotificationEnabledMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Salah map(Map<String, dynamic> data, {String tablePrefix}) {
    return Salah.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SalahsTable createAlias(String alias) {
    return $SalahsTable(_db, alias);
  }
}

class Ville extends DataClass implements Insertable<Ville> {
  final int id_ville;
  final String ville;
  final String ville_ar;
  Ville(
      {@required this.id_ville, @required this.ville, @required this.ville_ar});
  factory Ville.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Ville(
      id_ville: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id_ville']),
      ville: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}ville']),
      ville_ar: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}ville_ar']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id_ville != null) {
      map['id_ville'] = Variable<int>(id_ville);
    }
    if (!nullToAbsent || ville != null) {
      map['ville'] = Variable<String>(ville);
    }
    if (!nullToAbsent || ville_ar != null) {
      map['ville_ar'] = Variable<String>(ville_ar);
    }
    return map;
  }

  VillesCompanion toCompanion(bool nullToAbsent) {
    return VillesCompanion(
      id_ville: id_ville == null && nullToAbsent
          ? const Value.absent()
          : Value(id_ville),
      ville:
          ville == null && nullToAbsent ? const Value.absent() : Value(ville),
      ville_ar: ville_ar == null && nullToAbsent
          ? const Value.absent()
          : Value(ville_ar),
    );
  }

  factory Ville.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Ville(
      id_ville: serializer.fromJson<int>(json['id_ville']),
      ville: serializer.fromJson<String>(json['ville']),
      ville_ar: serializer.fromJson<String>(json['ville_ar']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id_ville': serializer.toJson<int>(id_ville),
      'ville': serializer.toJson<String>(ville),
      'ville_ar': serializer.toJson<String>(ville_ar),
    };
  }

  Ville copyWith({int id_ville, String ville, String ville_ar}) => Ville(
        id_ville: id_ville ?? this.id_ville,
        ville: ville ?? this.ville,
        ville_ar: ville_ar ?? this.ville_ar,
      );
  @override
  String toString() {
    return (StringBuffer('Ville(')
          ..write('id_ville: $id_ville, ')
          ..write('ville: $ville, ')
          ..write('ville_ar: $ville_ar')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id_ville.hashCode, $mrjc(ville.hashCode, ville_ar.hashCode)));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ville &&
          other.id_ville == this.id_ville &&
          other.ville == this.ville &&
          other.ville_ar == this.ville_ar);
}

class VillesCompanion extends UpdateCompanion<Ville> {
  final Value<int> id_ville;
  final Value<String> ville;
  final Value<String> ville_ar;
  const VillesCompanion({
    this.id_ville = const Value.absent(),
    this.ville = const Value.absent(),
    this.ville_ar = const Value.absent(),
  });
  VillesCompanion.insert({
    this.id_ville = const Value.absent(),
    @required String ville,
    @required String ville_ar,
  })  : ville = Value(ville),
        ville_ar = Value(ville_ar);
  static Insertable<Ville> custom({
    Expression<int> id_ville,
    Expression<String> ville,
    Expression<String> ville_ar,
  }) {
    return RawValuesInsertable({
      if (id_ville != null) 'id_ville': id_ville,
      if (ville != null) 'ville': ville,
      if (ville_ar != null) 'ville_ar': ville_ar,
    });
  }

  VillesCompanion copyWith(
      {Value<int> id_ville, Value<String> ville, Value<String> ville_ar}) {
    return VillesCompanion(
      id_ville: id_ville ?? this.id_ville,
      ville: ville ?? this.ville,
      ville_ar: ville_ar ?? this.ville_ar,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id_ville.present) {
      map['id_ville'] = Variable<int>(id_ville.value);
    }
    if (ville.present) {
      map['ville'] = Variable<String>(ville.value);
    }
    if (ville_ar.present) {
      map['ville_ar'] = Variable<String>(ville_ar.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VillesCompanion(')
          ..write('id_ville: $id_ville, ')
          ..write('ville: $ville, ')
          ..write('ville_ar: $ville_ar')
          ..write(')'))
        .toString();
  }
}

class $VillesTable extends Villes with TableInfo<$VillesTable, Ville> {
  final GeneratedDatabase _db;
  final String _alias;
  $VillesTable(this._db, [this._alias]);
  final VerificationMeta _id_villeMeta = const VerificationMeta('id_ville');
  GeneratedColumn<int> _id_ville;
  @override
  GeneratedColumn<int> get id_ville =>
      _id_ville ??= GeneratedColumn<int>('id_ville', aliasedName, false,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _villeMeta = const VerificationMeta('ville');
  GeneratedColumn<String> _ville;
  @override
  GeneratedColumn<String> get ville =>
      _ville ??= GeneratedColumn<String>('ville', aliasedName, false,
          typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _ville_arMeta = const VerificationMeta('ville_ar');
  GeneratedColumn<String> _ville_ar;
  @override
  GeneratedColumn<String> get ville_ar =>
      _ville_ar ??= GeneratedColumn<String>('ville_ar', aliasedName, false,
          typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id_ville, ville, ville_ar];
  @override
  String get aliasedName => _alias ?? 'villes';
  @override
  String get actualTableName => 'villes';
  @override
  VerificationContext validateIntegrity(Insertable<Ville> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_ville')) {
      context.handle(_id_villeMeta,
          id_ville.isAcceptableOrUnknown(data['id_ville'], _id_villeMeta));
    }
    if (data.containsKey('ville')) {
      context.handle(
          _villeMeta, ville.isAcceptableOrUnknown(data['ville'], _villeMeta));
    } else if (isInserting) {
      context.missing(_villeMeta);
    }
    if (data.containsKey('ville_ar')) {
      context.handle(_ville_arMeta,
          ville_ar.isAcceptableOrUnknown(data['ville_ar'], _ville_arMeta));
    } else if (isInserting) {
      context.missing(_ville_arMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id_ville};
  @override
  Ville map(Map<String, dynamic> data, {String tablePrefix}) {
    return Ville.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $VillesTable createAlias(String alias) {
    return $VillesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  _$AppDatabase.connect(DatabaseConnection c) : super.connect(c);
  $SalahsTable _salahs;
  $SalahsTable get salahs => _salahs ??= $SalahsTable(this);
  $VillesTable _villes;
  $VillesTable get villes => _villes ??= $VillesTable(this);
  SalahsDao _salahsDao;
  SalahsDao get salahsDao => _salahsDao ??= SalahsDao(this as AppDatabase);
  VillesDao _villesDao;
  VillesDao get villesDao => _villesDao ??= VillesDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [salahs, villes];
}
