//User Table
const String userTable = "user";
const String userColumnId = "id";
const String userColumnName = "name";
const String userColumnAge = "age";
const String userColumnDiabetesType = "diabetes_type";
const String userColumnHypertensionType = "hypertension_type";
//Ingredient table
const String ingredientTable = "ingredient";
const String ingredientColumnId = "id";
const String ingredientColumnName = "name";
const String ingredientColumnDescription = "description";
const String ingredientColumnRecommendedForMe = "recommended_for_me";
const String ingredientColumnDiabeticsReasons = "diabetic_reasons";
const String ingredientColumnHypertensiveReasons = "hypertensive_reasons";
// Tables

const DatabaseTables = [
  '''CREATE TABLE IF NOT EXISTS $userTable (
         $userColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $userColumnName TEXT NOT NULL,
          $userColumnAge INTEGER NOT NULL,
          $userColumnDiabetesType TEXT,
          $userColumnHypertensionType TEXT
        )''',
  '''CREATE TABLE IF NOT EXISTS $ingredientTable (
          $ingredientColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $ingredientColumnName TEXT NOT NULL,
          $ingredientColumnDescription TEXT NOT NULL,
          $ingredientColumnRecommendedForMe BOOLEAN NOT NULL,
          $ingredientColumnDiabeticsReasons TEXT,
          $ingredientColumnHypertensiveReasons TEXT
        )'''
];
