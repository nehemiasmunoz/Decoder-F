import 'package:decoder/src/data/provider/user/form/user_form.dart';
import 'package:decoder/src/data/provider/user/user_database_provider.dart';
import 'package:decoder/src/domain/models/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserForm form = Provider.of<UserForm>(context);
    final UserDatabaseProvider userDb =
        Provider.of<UserDatabaseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Register"),
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
                  keyboard: TextInputType.name,
                  onChanged: (val) => form.newUser.name = val,
                  placeholder: "Name",
                  maxLength: 20,
                  validator: (val) => form.validateName(val),
                ),
                CustomTextField(
                  maxLength: 3,
                  keyboard: TextInputType.number,
                  placeholder: "Age",
                  onChanged: (val) => form.newUser.age = int.parse(val),
                  validator: (val) => form.validateAge(val),
                ),
                CustomCheckbox(
                  isChecked: form.newUser.hasDiabetes,
                  title: "Diabetes",
                  onChanged: (val) =>
                      Provider.of<UserForm>(context, listen: false)
                          .toggleDiabetes(),
                ),
                Visibility(
                  visible: form.newUser.hasDiabetes,
                  child: Container(
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
                      onChanged: (Diabetes? value) => form.setDiabetes(value!),
                      value: form.newUser.diabetesType,
                    ),
                  ),
                ),
                CustomCheckbox(
                  title: "Hypertension",
                  isChecked: form.newUser.hasHypertension,
                  onChanged: (val) =>
                      Provider.of<UserForm>(context, listen: false)
                          .toggleHypertension(),
                ),
                Visibility(
                  visible: form.newUser.hasHypertension,
                  child: Container(
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
                          form.setHypertension(value!),
                      value: form.newUser.hypertensionType,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!form.validateForm()) return;
                    userDb.addUserToDb(form.getUserData());
                    Navigator.pop(context);
                  },
                  child: const Text("Add"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.title,
    required this.isChecked,
    required this.onChanged,
  });

  final String title;
  final bool isChecked;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(width: .5),
          borderRadius: BorderRadius.circular(5)),
      child: ListTile(
        title: Text(title),
        trailing: Checkbox(
          value: isChecked,
          onChanged: (val) => onChanged(val),
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
  });
  final TextInputType keyboard;
  final int maxLength;
  final Function onChanged;
  final Function validator;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
