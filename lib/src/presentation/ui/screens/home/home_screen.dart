import 'package:decoder/src/data/provider/gemini/gemini_provider.dart';
import 'package:decoder/src/data/provider/ingredient/ingredient_database_provider.dart';
import 'package:decoder/src/data/provider/user/user_database_provider.dart';
import 'package:decoder/src/presentation/ui/components/components.dart';
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Searchbar(),
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
                    onTap: () => Navigator.pushNamed(context, "detail",
                        arguments: value.ingredients[i]),
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

class Searchbar extends StatelessWidget {
  const Searchbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String inputValue = "";
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: TextFormField(
        maxLines: 1,
        maxLength: 10,
        onChanged: (value) => inputValue = value,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: "Insert your ingredient",
          suffixIcon: IconButton.filled(
            tooltip: "Search",
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                Ingredient ingredient = await context
                    .read<GeminiProvider>()
                    .getIngredientInformation(inputValue);
                Provider.of<IngredientDatabaseProvider>(context, listen: false)
                    .addIngredientToDb(ingredient);
              }
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value == null || value.isEmpty || value == " ") {
            return "Please enter a valid ingredient";
          }
          return null;
        },
      ),
    );
  }
}
