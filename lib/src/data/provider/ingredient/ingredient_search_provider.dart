import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../providers.dart';

class IngredientSearchProvider extends ChangeNotifier {
  final TextEditingController ingredientNameController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? validateIngredient(String? value) {
    if (value == null || value.isEmpty || value == " ") {
      return "Please enter a valid ingredient";
    }
    return null;
  }

  void submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context
          .read<GeminiProvider>()
          .getIngredientInformation(ingredientNameController.text)
          .then(
        (ingredient) {
          Provider.of<IngredientDatabaseProvider>(context, listen: false)
              .addIngredientToDb(ingredient);
        },
      );
    }
    ingredientNameController.text = "";
  }
}
