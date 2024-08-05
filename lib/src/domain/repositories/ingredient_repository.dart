import 'package:decoder/src/domain/models/ingredient/ingredient_model.dart';

abstract class IngredientRepository {
  Future<List<Ingredient>?> getIngredientsList();
  Future<int> insertIngredient(Ingredient ingredient);
  Future<int> deleteIngredient(int ingredientId);
}
