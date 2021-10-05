import 'package:adan/database/app_database.dart';
import 'package:moor/moor.dart';

part 'salahs.g.dart';

class Salahs extends Table {

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get englishName => text().nullable()();
  TextColumn get time => text().nullable()();
  TextColumn get dateHijri => text().nullable()();
  BoolColumn get isNotificationEnabled => boolean().withDefault(Constant(true))();
  DateTimeColumn get date => dateTime()();
  // DateTimeColumn get dateInsert => dateTime().withDefault(Constant(DateTime.now()))();

  // @override
  // Set<Column> get primaryKey => {id};
}

@UseDao(tables: [Salahs])
class SalahsDao extends DatabaseAccessor<AppDatabase>
    with _$SalahsDaoMixin {

  final AppDatabase db;
  SalahsDao(this.db) : super(db);

  Stream<List<Salah>> watchAllSalah() => select(salahs).watch();
  Future<List<Salah>> getAllSalah() => select(salahs).get();

  Future<void> insertAllSalah(List<Insertable<Salah>> rows) =>
      batch((batch) => batch.insertAll(salahs, rows, mode: InsertMode.replace));
  Future insertSalah(Insertable<Salah> row) => into(salahs).insert(row, mode: InsertMode.replace);
  Future updateSalah(Insertable<Salah> row) => update(salahs).replace(row);
  Future deleteSalah(Insertable<Salah> row) => delete(salahs).delete(row);

  Future<Salah> getSalahById(int id) {
    return (select(salahs)
      ..where((table) => table.id.equals(id))
    ).getSingle();
  }

  Future<Salah> getSalahByName(String name) {
    return (select(salahs)
      ..where((table) => table.name.equals(name))
    ).getSingle();
  }

  Stream<Salah> watchSalahById(int id) {
    return (select(salahs)
      ..where((table) => table.id.equals(id))
    ).watchSingle();
  }

  Future updateNotification({int id, bool val}) {
    return (update(salahs)
      ..where((t) => t.id.equals(id))
    ).write(Salah(isNotificationEnabled: val),
    );
  }

  Future updateDate({int id, String time, String dateHijri, DateTime date}) {
    return (update(salahs)
      ..where((t) => t.id.equals(id))
    ).write(Salah(
        time: time,
        dateHijri: dateHijri,
        date: date,
      ),
    );
  }
}