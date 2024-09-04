import 'package:decoder/util/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
    final String databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "decoder_db.db");
    const int version = 1;
    final database = await openDatabase(
      version: version,
      databasePath,
      onCreate: (db, version) async {
        for (var script in DatabaseTables) {
          await db.execute(script);
        }
      },
    );
    return database;
  }

  Future close() async => _db?.close();
}
