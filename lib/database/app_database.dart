import 'package:path_provider/path_provider.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:adan/entities/salahs.dart';
import 'package:adan/entities/villes.dart';
import 'package:path/path.dart' as p;
import 'package:moor/moor.dart';
import 'package:moor/ffi.dart';
import 'dart:io';

part 'app_database.g.dart';

@UseMoor(
    /// All Tables
    tables: [
      Salahs,
      Villes,
    ],
    /// All Daos
    daos: [
      SalahsDao,
      VillesDao,
    ],
    /// All Queries
    queries: {

    },
)
class AppDatabase extends _$AppDatabase {

  // AppDatabase() : super(VmDatabase.memory());
  AppDatabase() : super((FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.sqlite',
    logStatements: true,
  )));

  Future<void> deleteAllData() {
    return transaction(() async {
      for (var table in allTables) {
        await delete(table).go();
      }
    });
  }

  /*
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from == 1) {
      }
    },
  );
  */

  @override
  int get schemaVersion => 1;

  //! SINGLETON
  static final AppDatabase _singleton = new AppDatabase._internal();
  // AppDatabase._internal() : super(VmDatabase.memory());
  AppDatabase._internal() : super((FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.sqlite',
    logStatements: true,
  )));

  static AppDatabase get instance => _singleton;


  // AppDatabase() : super(VmDatabase.memory());
  // AppDatabase(QueryExecutor e) : super(e);
  AppDatabase.connect(DatabaseConnection connection) : super.connect(connection);

}

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}