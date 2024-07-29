import 'package:decoder/src/data/util/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _db;
  //Solo una instancia a lo largo de la ejecucion
  static final DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final String dabaseDirPath = await getDatabasesPath();
    final databasePath = join(dabaseDirPath, "decoder_db.db");
    final database = await openDatabase(
      databasePath,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $userTableName (
         $userColumnId INTEGER PRIMARY KEY autoincrement,
          $userColumnName TEXT NOT NULL,
          $userColumnAge INTEGER NOT NULL,
          $userColumnHasDiabetes BOOLEAN NOT NULL,
          $userColumnHasDiabetes BOOLEAN NOT NULL,
          $userColumnDiabetesType TEXT,
          $userColumnHypertensionType TEXT,
        );
        CREATE TABLE $ingredientTableName (
          $ingredientColumnId INTEGER PRIMARY KEY autoincrement,
          $ingredientColumnName TEXT NOT NULL,
          $ingredientColumnDescription TEXT NOT NULL,
          $ingredientColumnRecommendedForDiabetics BOOLEAN NOT NULL,
          $ingredientColumnRecommendeForHypertensive BOOLEAN NOT NULL,
          $ingredientColumnDiabeticsReasons TEXT,
          $ingredientColumnHypertensiveReasons TEXT,
        );
      ''');
      },
    );
    return database;
  }

  Future close() async => _db?.close();
}