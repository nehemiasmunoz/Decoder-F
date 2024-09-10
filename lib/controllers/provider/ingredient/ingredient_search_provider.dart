import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/models.dart';
import '../providers.dart';

class IngredientSearchProvider extends ChangeNotifier {
  final TextEditingController ctrlIngredient = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool get isFormValid {
    return formKey.currentState!.validate();
  }

  String? validateIngredient(String? value) {
    if (value == null || value.isEmpty || value == " ") {
      return "Please enter a valid ingredient";
    }
    return null;
  }

  Future<Ingredient?> submitForm(BuildContext context, User user) async {
    Ingredient? ingredient = await context
        .read<IngredientDatabaseProvider>()
        .getIngredientIfExist(ctrlIngredient.text.trim());
    return ingredient;
  }

  Future<Ingredient> getDataFromGemini(BuildContext context, user) async {
    final data = await context
        .read<GeminiProvider>()
        .getIngredientInformation(ctrlIngredient.text.trim(), user);
    return data;
  }
}
