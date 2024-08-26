import 'package:decoder/src/data/provider/ingredient/ingredient_database_provider.dart';
import 'package:decoder/src/data/provider/user/user_database_provider.dart';
import 'package:decoder/src/presentation/ui/components/components.dart';
import 'package:decoder/src/presentation/ui/screens/search/search_ingredient_view.dart';
import 'package:flutter/material.dart';
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
                onPressed: () => Navigator.pushNamed(context, "register"),
                child: const Text("Register"))
            : const DrawerMenu(),
      ),
      appBar: AppBar(
        title: const Text(
          "Home Screen",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.camera))],
      ),
      body: const HomeScreenBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (ctx) => SearchIngredientView(),
          );
        },
        label: const Text("Search"),
        icon: const Icon(Icons.search),
      ),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Consumer<IngredientDatabaseProvider>(
          builder: (BuildContext context, value, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "${value.ingredients.length} Ingredients",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Consumer<IngredientDatabaseProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  if (value.ingredients.isEmpty) {
                    return const Center(
                        child: Text("The ingredient database is empty"));
                  }
                  return ListView.builder(
                    itemCount: value.ingredients.length,
                    itemBuilder: (context, i) => IngredientTile(
                      ingredient: value.ingredients[i],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 70,
            )
          ],
        );
      }),
    );
  }
}
