import 'package:decoder/models/ingredient/ingredient_model.dart';
import 'package:decoder/repository/ingredient_db_repository.dart';
import 'package:decoder/util/constants.dart';

import '../../services/database_service.dart';

class IngredientRepoImpl implements IngredientDbRepository {
  @override
  Future<void> addIngredient(Ingredient ingredient) async {
    final db = await DatabaseService.instance.database;
    db.insert(ingredientTable, ingredient.toMap());
  }

  @override
  Future<void> deleteIngredient(int id) async {
    final db = await DatabaseService.instance.database;
    db.delete(ingredientTable,
        where: "$ingredientColumnId =?", whereArgs: [id]);
  }

  @override
  Future<List<Ingredient>> getIngredients() async {
    final db = await DatabaseService.instance.database;
    List<Map<String, Object?>> res = await db.query(ingredientTable);
    return res.map((e) => Ingredient.fromDBMap(e)).toList();
  }

  @override
  Future<void> updateIngredient(Ingredient ingredient) async {
    final db = await DatabaseService.instance.database;
    db.update(ingredientTable, ingredient.toMap(),
        where: "$ingredientColumnId =?", whereArgs: [ingredient.id]);
  }
}
