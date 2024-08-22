import 'package:decoder/src/domain/models/ingredient/ingredient_model.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ingredient = ModalRoute.of(context)!.settings.arguments as Ingredient;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(ingredient.name),
      ),
      body: DetailScreenBody(ingredient: ingredient),
    );
  }
}

class DetailScreenBody extends StatelessWidget {
  const DetailScreenBody({super.key, required this.ingredient});
  final Ingredient ingredient;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Description:"),
            Text(ingredient.description),
            const Divider(),
            const Text("Recommended for diabetics"),
            Text(ingredient.recommendedForDiabetics.toString()),
            const Divider(),
            const Text("Recommended for hypertensive"),
            Text(
              ingredient.recommendedForHypertensives.toString(),
            ),
            const Divider(),
            const Text("Diabetics reasons"),
            Text(ingredient.diabeticsReasons.replaceAll(RegExp(r'[\[\]]'), '')),
            const Divider(),
            const Text("Hypertensive reasons"),
            Text(ingredient.hypertensiveReasons
                .replaceAll(RegExp(r'[\[\]]'), '')),
          ],
        ),
      ),
    );
  }
}
