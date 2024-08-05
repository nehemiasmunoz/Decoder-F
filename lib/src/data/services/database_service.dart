import 'package:decoder/src/data/services/database/database_tables.dart';
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
    const int version = 1;
    final database = await openDatabase(
      version: version,
      databasePath,
      onCreate: (db, version) async {
        for (var script in DatabaseTables.tables) {
          await db.execute(script);
        }
      },
    );
    return database;
  }

  Future close() async => _db?.close();
}
