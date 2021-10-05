import 'package:adan/database/app_database.dart';
import 'package:moor/moor.dart';

part 'villes.g.dart';

class Villes extends Table {

  IntColumn get id_ville => integer()();
  TextColumn get ville => text()();
  TextColumn get ville_ar => text()();

  @override
  Set<Column> get primaryKey => {id_ville};
}

@UseDao(tables: [Villes])
class VillesDao extends DatabaseAccessor<AppDatabase>
    with _$VillesDaoMixin {

  final AppDatabase db;
  VillesDao(this.db) : super(db);

  Stream<List<Ville>> watchAllVille() => select(villes).watch();
  Future<List<Ville>> getAllVille() => select(villes).get();

  Future<void> insertAllVille(List<Insertable<Ville>> rows) =>
      batch((batch) => batch.insertAll(villes, rows, mode: InsertMode.replace));
  Future insertVille(Insertable<Ville> row) => into(villes).insert(row, mode: InsertMode.replace);
  Future updateVille(Insertable<Ville> row) => update(villes).replace(row);
  Future deleteVille(Insertable<Ville> row) => delete(villes).delete(row);

  Future<Ville> getVilleById(int id) {
    return (select(villes)
      ..where((table) => table.id_ville.equals(id))
    ).getSingle();
  }

  Stream<Ville> watchVilleById(int id) {
    return (select(villes)
      ..where((table) => table.id_ville.equals(id))
    ).watchSingle();
  }

  Stream<List<Ville>> watchAllVilleByQuery(String query) {
    return (select(villes)..where(
            (tbl) => tbl.ville.like('%$query%') | tbl.ville_ar.like('%$query%'))
    ).watch();
  }
}