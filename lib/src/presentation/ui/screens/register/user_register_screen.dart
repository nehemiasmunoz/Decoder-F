import 'package:decoder/src/data/provider/user/form/user_form.dart';
import 'package:decoder/src/data/provider/user/user_database_provider.dart';
import 'package:decoder/src/domain/models/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/models.dart';

class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({super.key, this.userData});
  final User? userData;

  @override
  Widget build(BuildContext context) {
    final UserForm form = Provider.of<UserForm>(context);
    final UserDatabaseProvider userDb =
        Provider.of<UserDatabaseProvider>(context);
    (userData != null) ? form.fillUser(userData!) : null;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro usuario"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: form.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  initialValue: form.newUser.name,
                  keyboard: TextInputType.name,
                  onChanged: (val) => form.newUser.name = val,
                  placeholder: "Nombre",
                  maxLength: 20,
                  validator: (val) => form.validateName(val),
                ),
                CustomTextField(
                  initialValue: form.newUser.age.toString(),
                  maxLength: 3,
                  keyboard: TextInputType.number,
                  placeholder: "Edad",
                  onChanged: (val) => form.newUser.age = int.parse(val),
                  validator: (val) => form.validateAge(val),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: .5),
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton<Diabetes>(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    isExpanded: true,
                    items: Diabetes.values.map((Diabetes item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item.type),
                      );
                    }).toList(),
                    onChanged: (Diabetes? value) => form.setDiabetes(value!),
                    value: form.newUser.diabetesType,
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    isExpanded: true,
                    items: Hypertension.values.map((Hypertension item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item.type),
                      );
                    }).toList(),
                    onChanged: (Hypertension? value) =>
                        form.setHypertension(value!),
                    value: form.newUser.hypertensionType,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!form.validateForm()) return;
                    if (userData != null) {
                      userDb.updateUser(form.getUserData());
                    } else {
                      userDb.addUserToDb(form.getUserData());
                    }
                    Navigator.pop(context);
                  },
                  child: const Text("Guardar"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.keyboard,
    required this.onChanged,
    required this.placeholder,
    required this.validator,
    required this.maxLength,
    this.initialValue,
  });
  final TextInputType keyboard;
  final int maxLength;
  final Function onChanged;
  final Function validator;
  final String placeholder;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: keyboard,
      decoration: InputDecoration(
          hintText: placeholder, border: const OutlineInputBorder()),
      maxLines: 1,
      onChanged: (value) => onChanged(value),
      maxLength: maxLength,
      validator: (val) => validator(val),
    );
  }
}
