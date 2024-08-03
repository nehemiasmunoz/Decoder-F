import 'package:decoder/src/data/util/constants.dart';
import 'package:decoder/src/domain/models/ingredient/ingredient_model.dart';
import 'package:decoder/src/domain/repositories/ingredient_repository.dart';

import '../services/database_service.dart';

class IngredientRepositoryImpl implements IngredientRepository {
  @override
  Future<int> deleteOne(int ingredientId) async {
    final db = await DatabaseService.instance.database;
    return db.delete(ingredientTableName,
        where: '$ingredientColumnId = ?', whereArgs: [ingredientId]);
  }

  @override
  Future<List<Ingredient>> getIngredientList() async {
    final db = await DatabaseService.instance.database;
    List<Map<String, Object?>> dbIngredients =
        await db.query(ingredientTableName, columns: [
      ingredientColumnId,
      ingredientColumnName,
      ingredientColumnDescription,
      ingredientColumnDiabeticsReasons,
      ingredientColumnHypertensiveReasons
    ]);

    if (dbIngredients.isNotEmpty) {
      List<Ingredient> ingredientList = [];
      dbIngredients.map((element) {
        ingredientList.add(Ingredient.fromMap(element));
      });
      return ingredientList;
    }

    return Future(() => []);
  }

  @override
  Future<int> insertNew(Ingredient ingredient) async {
    final db = await DatabaseService.instance.database;
    return db.insert(ingredientTableName, ingredient.toMap());
  }
}
