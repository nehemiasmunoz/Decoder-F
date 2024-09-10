import 'package:decoder/controllers/provider/providers.dart';
import 'package:decoder/views/screens/detail/detail_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/models.dart';

class SearchIngredientView extends StatelessWidget {
  const SearchIngredientView({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: size.height * .02,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Consumer<IngredientSearchProvider>(builder: (ctx, model, child) {
          return Form(
            key: model.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Ingresa tu ingrediente",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                TextFormField(
                  maxLines: 1,
                  maxLength: 20,
                  keyboardType: TextInputType.name,
                  controller: model.ctrlIngredient,
                  autofocus: true,
                  autocorrect: false,
                  textAlign: TextAlign.center,
                  validator: (value) => model.validateIngredient(value),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (!model.isFormValid) return;
                    final ingredient = await model.submitForm(context, user);
                    if (ingredient != null) {
                      sendToDetailScreen(ctx, ingredient);
                      model.ctrlIngredient.clear();
                      return;
                    } else {
                      final newIngredient =
                          await model.getDataFromGemini(context, user);

                      if (newIngredient.diabeticsReasons == "" &&
                          newIngredient.hypertensiveReasons == "") {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Ingrediente invalido"),
                        ));
                        return;
                      } else {
                        Provider.of<IngredientDatabaseProvider>(context,
                                listen: false)
                            .addIngredient(newIngredient);
                        model.ctrlIngredient.clear();
                        Navigator.pop(context);
                        sendToDetailScreen(ctx, newIngredient);
                        return;
                      }
                    }
                  },
                  child: const Text("Buscar"),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

void sendToDetailScreen(BuildContext ctx, Ingredient ingredient) {
  Navigator.of(ctx).push(
    MaterialPageRoute(
      builder: (ctx) => DetailView(ingredient: ingredient),
    ),
  );
}
