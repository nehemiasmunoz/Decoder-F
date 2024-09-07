import 'package:decoder/models/ingredient/ingredient_model.dart';
import 'package:flutter/material.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key, required this.ingredient});
  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          ingredient.name.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: DetailViewBody(ingredient: ingredient),
    );
  }
}

class DetailViewBody extends StatelessWidget {
  const DetailViewBody({super.key, required this.ingredient});
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
              margin: EdgeInsets.symmetric(
                  vertical: size.height * .02, horizontal: size.width * .01),
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
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const Text("Descripción"),
            Text(ingredient.description),
            const Divider(),
            const Text("Recomendado para mi"),
            Text(
                ingredient.recommendedForMe ? "Recomendado" : "No recomendado"),
            const Divider(),
            Visibility(
                visible: (ingredient.diabeticsReasons != ""),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Razones para diabeticos"),
                    Text(ingredient.diabeticsReasons),
                    const Divider(),
                  ],
                )),
            Visibility(
              visible: (ingredient.hypertensiveReasons != ""),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Razones para hipertensos"),
                  Text(ingredient.hypertensiveReasons),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
