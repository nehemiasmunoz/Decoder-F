import 'package:decoder/src/data/provider/ingredient/ingredient_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<IngredientSearchProvider>(
      builder: (BuildContext context, model, Widget? child) {
        return Form(
          key: model.formKey,
          child: TextFormField(
            controller: model.ingredientNameController,
            maxLines: 1,
            keyboardType: TextInputType.name,
            validator: (value) => model.validateIngredient(value),
            maxLength: 10,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: "Insert your ingredient",
              suffixIcon: IconButton.filled(
                tooltip: "Search",
                onPressed: () => model.submitForm(context),
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              border: const OutlineInputBorder(),
            ),
          ),
        );
      },
    );
  }
}
