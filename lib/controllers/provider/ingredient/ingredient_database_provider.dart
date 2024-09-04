import 'package:decoder/models/ingredient/ingredient_model.dart';
import 'package:decoder/repository/repositoryImpl/ingredient_repo_impl.dart';
import 'package:decoder/services/database_service.dart';
import 'package:flutter/material.dart';

import '/util/constants.dart';

class IngredientDatabaseProvider extends ChangeNotifier {
  final IngredientRepoImpl _ingredientRepoImpl = IngredientRepoImpl();
  List<Ingredient> _ingredients = [];
  List<Ingredient> get ingredients => _ingredients;

  fetchIngredients() async {
    _ingredients = await _ingredientRepoImpl.getIngredients();
    notifyListeners();
  }

  Future<Ingredient?> getIngredientIfExist(String name) async {
    final db = await DatabaseService.instance.database;
    final dbIngredient = await db.rawQuery(
        'SELECT * FROM $ingredientTable WHERE $ingredientColumnName = "$name"');
    if (dbIngredient.isNotEmpty) {
      return Ingredient.fromDBMap(dbIngredient.first);
    }
    return null;
  }

  addIngredient(Ingredient ingredient) async {
    _ingredientRepoImpl.addIngredient(ingredient);
    await fetchIngredients();
  }

  deleteIngredient(int id) async {
    _ingredientRepoImpl.deleteIngredient(id);
    await fetchIngredients();
  }

  void init() {
    fetchIngredients();
    notifyListeners();
  }
}
