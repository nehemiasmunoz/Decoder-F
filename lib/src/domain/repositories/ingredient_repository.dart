import 'package:decoder/src/domain/models/ingredient/ingredient_model.dart';

abstract class IngredientRepository {
  Future<List<Ingredient>?> getIngredientList();
  Future<int> insertNew(Ingredient ingredient);
  Future<int> deleteOne(int ingredientId);
}
