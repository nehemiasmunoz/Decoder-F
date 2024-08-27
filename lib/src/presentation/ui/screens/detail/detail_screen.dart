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
        title: Text(ingredient.name.toUpperCase()),
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
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.amber[100],
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.amberAccent)),
              padding: const EdgeInsets.all(10),
              width: size.width * .9,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(flex: 1, child: Icon(Icons.info_outline)),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "La información generada por IA debe ser considerada como una hipótesis a verificar con un profesional de la salud.",
                      style: TextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            const Text("Description:"),
            Text(ingredient.description),
            const Divider(),
            const Text("Recommended for me"),
            Text(ingredient.recommendedForMe.toString()),
            const Divider(),
            Visibility(
                visible: (ingredient.diabeticsReasons != "[]"),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Diabetics reasons"),
                    Text(
                      ingredient.diabeticsReasons
                          .replaceAll(RegExp(r'[\[\]]'), ''),
                    ),
                    const Divider(),
                  ],
                )),
            Visibility(
              visible: (ingredient.hypertensiveReasons != "[]"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Hypertensive reasons"),
                  Text(ingredient.hypertensiveReasons
                      .replaceAll(RegExp(r'[\[\]]'), '')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
