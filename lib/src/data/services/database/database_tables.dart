import '../../util/constants.dart';

class DatabaseTables {
  static const tables = [
    '''CREATE TABLE IF NOT EXISTS $userTableName (
         $userColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $userColumnName TEXT NOT NULL,
          $userColumnAge INTEGER NOT NULL,
          $userColumnHasDiabetes BOOLEAN NOT NULL,
          $userColumnHasHypertension BOOLEAN NOT NULL,
          $userColumnDiabetesType TEXT,
          $userColumnHypertensionType TEXT
        )''',
    '''CREATE TABLE IF NOT EXISTS $ingredientTableName (
          $ingredientColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $ingredientColumnName TEXT NOT NULL,
          $ingredientColumnDescription TEXT NOT NULL,
          $ingredientColumnRecommendedForDiabetics BOOLEAN NOT NULL,
          $ingredientColumnRecommendeForHypertensive BOOLEAN NOT NULL,
          $ingredientColumnDiabeticsReasons TEXT,
          $ingredientColumnHypertensiveReasons TEXT
        )'''
  ];
}
