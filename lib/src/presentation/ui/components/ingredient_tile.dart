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
      onTap: () =>
          Navigator.pushNamed(context, "detail", arguments: ingredient),
      child: Card(
        child: Row(
          children: [
            IconButton(
                onPressed: () {
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
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
            Expanded(
              child: ListTile(
                title: Text(ingredient.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: (ingredient.recommendedForMe)
                              ? Colors.green
                              : Colors.red,
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 6),
                      child: Text(
                        (ingredient.recommendedForMe)
                            ? "Recommended"
                            : "Not recommended",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Icon(Icons.arrow_forward_ios_sharp),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
