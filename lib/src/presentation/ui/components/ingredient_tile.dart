import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/provider/ingredient/ingredient_database_provider.dart';
import '../../../domain/models/models.dart';

class IngredientTile extends StatelessWidget {
  const IngredientTile({super.key, required this.ingredient});

  final Ingredient ingredient;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        context
            .read<IngredientDatabaseProvider>()
            .deleteIngredientFormDb(ingredient);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "${ingredient.name} Has been deleted",
            ),
          ),
        );
      },
      onTap: () =>
          Navigator.pushNamed(context, "detail", arguments: ingredient),
      child: Card(
        child: ListTile(
          title: Text(ingredient.name),
          trailing: const Icon(Icons.arrow_forward_ios_sharp),
        ),
      ),
    );
  }
}
