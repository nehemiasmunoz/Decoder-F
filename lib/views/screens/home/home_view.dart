import 'package:decoder/controllers/provider/providers.dart';
import 'package:decoder/views/components/components.dart';
import 'package:decoder/views/screens/views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDatabaseProvider>(context).user;
    return Scaffold(
      drawer: Drawer(
        child: (user.isNotEmpty)
            ? DrawerMenu(user: user.first)
            : ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "register"),
                child: const Text("Registrarse"),
              ),
      ),
      appBar: AppBar(
        title: const Text(
          "Inicio",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.camera))],
      ),
      body: const HomeScreenBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (user.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Primero debes completar el registro"),
              ),
            );
            Future.delayed(const Duration(seconds: 1));
            Navigator.pushNamed(context, "register");
            return;
          }
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (ctx) => SearchIngredientView(
              user: user.first,
            ),
          );
        },
        label: const Text("Buscar"),
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
          builder: (BuildContext context, notifier, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "${notifier.ingredients.length} Ingredientes",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: (notifier.ingredients.isEmpty)
                  ? const Center(
                      child: Text("Aun no existen registros"),
                    )
                  : ListView.builder(
                      itemCount: notifier.ingredients.length,
                      itemBuilder: (context, i) => IngredientTile(
                        ingredient: notifier.ingredients[i],
                      ),
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
