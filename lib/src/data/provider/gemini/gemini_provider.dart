import 'package:decoder/src/data/provider/ingredient/ingredient_database_provider.dart';
import 'package:decoder/src/data/services/gemini/gemini_service.dart';
import 'package:decoder/src/domain/models/ingredient/ingredient_model.dart';
import 'package:flutter/material.dart';

class GeminiProvider extends ChangeNotifier {
  GeminiService geminiService = GeminiService();
  IngredientDatabaseProvider ingredientDatabaseProvider =
      IngredientDatabaseProvider();

  Future<Ingredient> getIngredientInformation(String ingredientName) async {
    Ingredient newIngredient;
    try {
      // Fetch the response asynchronously
      final response = await geminiService.fetchResponse(ingredientName);

      // Create the new Ingredient from the response
      newIngredient = Ingredient.fromGeminiMap(response);
      newIngredient.id = 1;
      newIngredient.name = ingredientName;
    } catch (e) {
      // Handle any errors that occur during the fetch
      print('Error fetching ingredient information: $e');
      // You might want to return a default Ingredient or handle the error in another way
      throw e;
    }
    return newIngredient;
  }
}
