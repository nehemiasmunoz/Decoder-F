import 'package:decoder/src/domain/models/ingredient/ingredient_model.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ingredient name"),
      ),
      body: const DetailScreenBody(),
    );
  }
}

class DetailScreenBody extends StatelessWidget {
  const DetailScreenBody({super.key});
  @override
  Widget build(BuildContext context) {
    final ingredient = ModalRoute.of(context)!.settings.arguments as Ingredient;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Description:"),
            Text(ingredient == null ? "" : "${ingredient?.description}"),
            const Divider(),
            const Text("Recommended for diabetics"),
            Text(ingredient == null
                ? ""
                : "${ingredient?.recommendedForDiabetics}"),
            const Divider(),
            const Text("Recommended for hypertensive"),
            Text(
              ingredient == null
                  ? ""
                  : "${ingredient?.recommendedForHypertensives}",
            ),
            const Divider(),
            const Text("Diabetics reasons"),
            Text(ingredient == null ? "" : "${ingredient?.diabeticsReasons}"),
            const Divider(),
            const Text("Hypertensive reasons"),
            Text(
                ingredient == null ? "" : "${ingredient?.hypertensiveReasons}"),
          ],
        ),
      ),
    );
  }
}
