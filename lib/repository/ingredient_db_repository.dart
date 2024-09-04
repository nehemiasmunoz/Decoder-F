import '../models/models.dart';

abstract class IngredientDbRepository {
  Future<List<Ingredient>> getIngredients();
  Future<void> addIngredient(Ingredient ingredient);
  Future<void> deleteIngredient(int id);
  Future<void> updateIngredient(Ingredient ingredient);
}
