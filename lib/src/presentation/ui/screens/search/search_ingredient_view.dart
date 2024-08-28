import 'package:decoder/src/data/provider/ingredient/ingredient_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/provider/providers.dart';
import '../../../../domain/models/models.dart';

class SearchIngredientView extends StatelessWidget {
  const SearchIngredientView({super.key});

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
                  "Enter your ingredient",
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
                  controller: model.ingredientNameController,
                  autofocus: true,
                  autocorrect: false,
                  textAlign: TextAlign.center,
                  validator: (value) => model.validateIngredient(value),
                  decoration:
                      const InputDecoration(hintText: "Insert your ingredient"),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                ElevatedButton(
                  onPressed: () async {
                    User user = context.read<UserDatabaseProvider>().user;
                    if (user.name == "") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("You have to complete the register first"),
                        ),
                      );
                      Future.delayed(const Duration(seconds: 1));
                      Navigator.pushNamed(context, "register");
                      return;
                    }
                    if (!model.isFormValid) return;

                    final ingredient = await model.submitForm(context, user);
                    if (ingredient != null) {
                      if (!context.mounted) return;
                      Navigator.pushNamed(context, "detail",
                          arguments: ingredient);
                    } else {
                      if (!context.mounted) return;
                      final data = await model.getDataFromGemini(context, user);

                      if (data.description == "") {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Invalid ingredient"),
                        ));
                      } else {
                        if (!context.mounted) return;
                        Provider.of<IngredientDatabaseProvider>(context,
                                listen: false)
                            .addIngredientToDb(data);
                      }
                    }
                    model.ingredientNameController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Search"),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
