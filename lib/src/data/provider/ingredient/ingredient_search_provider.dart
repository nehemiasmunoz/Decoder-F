import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/models.dart';
import '../providers.dart';

class IngredientSearchProvider extends ChangeNotifier {
  final TextEditingController ingredientNameController =
      TextEditingController(text: "");
  final formKey = GlobalKey<FormState>();

  String? validateIngredient(String? value) {
    if (value == null || value.isEmpty || value == " ") {
      return "Please enter a valid ingredient";
    }
    return null;
  }

  void submitForm(BuildContext context) {
    User user = context.read<UserDatabaseProvider>().user;
    if (user.name == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("You have to complete the register first")));
      Future.delayed(const Duration(seconds: 1));
      Navigator.pushNamed(context, "register");
      return;
    }
    if (formKey.currentState!.validate()) {
      context
          .read<IngredientDatabaseProvider>()
          .getIngredientIfExist(ingredientNameController.text)
          .then((ingredient) {
        if (ingredient.name != "") {
          Navigator.pushNamed(context, "detail", arguments: ingredient);
          return;
        }
        context
            .read<GeminiProvider>()
            .getIngredientInformation(ingredientNameController.text, user)
            .then(
          (ingredient) {
            if (ingredient.description == "") {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Invalid ingredient")));
              return;
            }
            Provider.of<IngredientDatabaseProvider>(context, listen: false)
                .addIngredientToDb(ingredient);
          },
        );
      });
    }
  }
}
