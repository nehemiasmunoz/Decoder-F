import 'package:decoder/controllers/provider/user/form/user_form.dart';
import 'package:decoder/controllers/provider/user/user_database_provider.dart';
import 'package:decoder/models/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/models.dart';

class UserRegisterView extends StatelessWidget {
  const UserRegisterView({super.key, this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    final notifierFunctions = Provider.of<UserForm>(context, listen: false);
    final userDb = Provider.of<UserDatabaseProvider>(context);
    (user != null) ? notifierFunctions.fillUser(user!) : null;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro usuario"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Consumer<UserForm>(
          builder: (BuildContext context, UserForm notifier, Widget? child) {
            return Form(
              key: notifier.formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextField(
                      controller: notifier.ctrlName,
                      keyboard: TextInputType.name,
                      placeholder: "Nombre",
                      maxLength: 20,
                      validator: (val) => notifier.validateName(val),
                    ),
                    CustomTextField(
                      controller: notifier.ctrlAge,
                      maxLength: 3,
                      keyboard: TextInputType.number,
                      placeholder: "Edad",
                      validator: (val) => notifier.validateAge(val),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: .5),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton<Diabetes>(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        isExpanded: true,
                        items: Diabetes.values.map((Diabetes item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item.type),
                          );
                        }).toList(),
                        onChanged: (Diabetes? value) =>
                            notifier.setDiabetes(value!),
                        value: notifier.diabetesType,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: .5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButton<Hypertension>(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        isExpanded: true,
                        items: Hypertension.values.map((Hypertension item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item.type),
                          );
                        }).toList(),
                        onChanged: (Hypertension? value) =>
                            notifier.setHypertension(value!),
                        value: notifier.hypertensionType,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (!notifier.validateForm()) return;
                        if (user != null) {
                          userDb.updateUser(notifier.getUserData());
                        } else {
                          userDb.addUser(notifier.getUserData());
                        }
                        Navigator.pop(context);
                      },
                      child: const Text("Guardar"),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.keyboard,
    required this.placeholder,
    required this.validator,
    required this.maxLength,
    this.initialValue,
    required this.controller,
  });
  final TextInputType keyboard;
  final int maxLength;
  final Function validator;
  final String placeholder;
  final String? initialValue;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        hintText: placeholder,
        border: const OutlineInputBorder(),
      ),
      maxLines: 1,
      // onChanged: (value) => onChanged(value),
      maxLength: maxLength,
      validator: (val) => validator(val),
    );
  }
}
