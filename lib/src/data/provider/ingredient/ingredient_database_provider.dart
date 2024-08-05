import 'package:decoder/src/data/repositories_impl/ingredient_repository_impl.dart';
import 'package:decoder/src/domain/models/ingredient/ingredient_model.dart';
import 'package:flutter/material.dart';

class IngredientDatabaseProvider extends ChangeNotifier {
  List<Ingredient> _ingredients = [];
  List<Ingredient> get ingredients {
    getIngredientsFromDB();
    return _ingredients;
  }

  void getIngredientsFromDB() async {
    _ingredients = await IngredientRepositoryImpl().getIngredientList();
    notifyListeners();
  }

  void addUserToDb(Ingredient ingredient) {
    IngredientRepositoryImpl().insertNew(ingredient);
    notifyListeners();
  }

  void deleteUserData(Ingredient ingredient) {
    IngredientRepositoryImpl().deleteOne(ingredient.id);
    notifyListeners();
  }
}
