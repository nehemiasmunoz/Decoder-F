import 'package:decoder/src/data/repositories_impl/ingredient_repository_impl.dart';
import 'package:decoder/src/domain/models/ingredient/ingredient_model.dart';
import 'package:flutter/material.dart';

class IngredientDatabaseProvider extends ChangeNotifier {
  List<Ingredient> _ingredients = [];
  List<Ingredient> get ingredients {
    getIngredientsFromDb();
    return _ingredients;
  }

  void getIngredientsFromDb() async {
    _ingredients = await IngredientRepositoryImpl().getIngredientsList();
    notifyListeners();
  }

  void addIngredientToDb(Ingredient ingredient) {
    IngredientRepositoryImpl().insertIngredient(ingredient);
    notifyListeners();
  }

  void deleteIngredientFormDb(Ingredient ingredient) {
    IngredientRepositoryImpl().deleteIngredient(ingredient.id);
    notifyListeners();
  }
}
