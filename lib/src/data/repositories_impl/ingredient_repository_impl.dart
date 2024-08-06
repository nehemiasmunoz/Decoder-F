import 'package:decoder/src/data/util/constants.dart';
import 'package:decoder/src/domain/models/ingredient/ingredient_model.dart';
import 'package:decoder/src/domain/repositories/ingredient_repository.dart';

import '../services/database_service.dart';

class IngredientRepositoryImpl implements IngredientRepository {
  @override
  Future<int> deleteIngredient(int ingredientId) async {
    final db = await DatabaseService.instance.database;
    return await db.delete(ingredientTableName,
        where: '$ingredientColumnId = ?', whereArgs: [ingredientId]);
  }

  @override
  Future<List<Ingredient>> getIngredientsList() async {
    final db = await DatabaseService.instance.database;
    List<Map<String, Object?>> dbIngredients =
        await db.rawQuery('SELECT * FROM $ingredientTableName');
    if (dbIngredients.isNotEmpty) {
      List<Ingredient> ingredientList = [];
      for (var item in dbIngredients) {
        ingredientList.add(Ingredient.fromDBMap(item));
      }
      return ingredientList;
    }
    return Future(() => []);
  }

  @override
  Future<Ingredient> insertIngredient(Ingredient ingredient) async {
    final db = await DatabaseService.instance.database;
    ingredient.id = await db.insert(ingredientTableName, ingredient.toMap());
    return ingredient;
  }
}
