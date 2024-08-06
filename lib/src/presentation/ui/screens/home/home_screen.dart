import 'package:decoder/src/data/provider/gemini/gemini_provider.dart';
import 'package:decoder/src/data/provider/ingredient/ingredient_database_provider.dart';
import 'package:decoder/src/data/provider/user/user_database_provider.dart';
import 'package:decoder/src/presentation/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User user = context.watch<UserDatabaseProvider>().user;

    return Scaffold(
      drawer: Drawer(
        child: user.name == ""
            ? ElevatedButton(
                onPressed: () {
                  context.go("/register");
                },
                child: const Text("Register"))
            : const DrawerMenu(),
      ),
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
      ),
      body: const HomeScreenBody(),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    GeminiProvider geminiProvider = Provider.of(context);
    IngredientDatabaseProvider ingredientDatabaseProvider =
        Provider.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(mainAxisSize: MainAxisSize.max, children: [
            const Expanded(
              flex: 3,
              child: TextField(
                maxLines: 1,
                autocorrect: false,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton.filled(
                onPressed: () async {
                  Ingredient ingredient =
                      await geminiProvider.getIngredientInformation("Azucar");
                  ingredientDatabaseProvider.addIngredientToDb(ingredient);
                },
                icon: const Icon(Icons.search),
              ),
            )
          ]),
          const Divider(),
          Expanded(
            child: Consumer<IngredientDatabaseProvider>(
              builder: (BuildContext context, value, Widget? child) {
                if (value.ingredients.isEmpty) {
                  return const Text("The ingredient database is empty");
                }
                return ListView.builder(
                  itemCount: value.ingredients.length,
                  itemBuilder: (context, i) => GestureDetector(
                    onTap: () =>
                        context.go("/detail", extra: value.ingredients[i]),
                    child: Card(
                      child: ListTile(
                        title: Text(value.ingredients[i].name),
                        trailing: const Icon(Icons.arrow_forward_ios_sharp),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
