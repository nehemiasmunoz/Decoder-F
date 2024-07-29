import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ingredient name"),
      ),
      body: DetailScreenBody(),
    );
  }
}

class DetailScreenBody extends StatelessWidget {
  const DetailScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Description:"),
            Text(
              "Ad consequat ea ut veniam aliqua sunt cillum in est qui duis quis. Aute sit aute quis nisi cupidatat do veniam esse duis ex velit do labore. Irure duis ut fugiat ad mollit aliqua.",
            ),
            Divider(),
            Text("Recommended for diabetics"),
            Text(
              "Ad consequat ea ut veniam aliqua sunt cillum in est qui duis quis. Aute sit aute quis nisi cupidatat do veniam esse duis ex velit do labore. Irure duis ut fugiat ad mollit aliqua.",
            ),
            Divider(),
            Text("Recommended for hypertensive"),
            Text(
              "Ad consequat ea ut veniam aliqua sunt cillum in est qui duis quis. Aute sit aute quis nisi cupidatat do veniam esse duis ex velit do labore. Irure duis ut fugiat ad mollit aliqua.",
            ),
            Divider(),
            Text("Diabetics reasons"),
            Text(
              "Ad consequat ea ut veniam aliqua sunt cillum in est qui duis quis. Aute sit aute quis nisi cupidatat do veniam esse duis ex velit do labore. Irure duis ut fugiat ad mollit aliqua.",
            ),
            Divider(),
            Text("Hypertensive reasons"),
            Text(
              "Ad consequat ea ut veniam aliqua sunt cillum in est qui duis quis. Aute sit aute quis nisi cupidatat do veniam esse duis ex velit do labore. Irure duis ut fugiat ad mollit aliqua.",
            ),
            Divider(),
            Text("Nutritional info"),
            Text(
              "Ad consequat ea ut veniam aliqua sunt cillum in est qui duis quis. Aute sit aute quis nisi cupidatat do veniam esse duis ex velit do labore. Irure duis ut fugiat ad mollit aliqua.",
            ),
          ],
        ),
      ),
    );
  }
}
