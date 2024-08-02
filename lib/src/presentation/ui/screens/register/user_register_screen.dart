import 'package:decoder/src/data/provider/user/form/user_form.dart';
import 'package:decoder/src/domain/models/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final UserForm form = Provider.of<UserForm>(context);
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
                  placeholder: 'Name',
                  validator: (val) => form.validateName(val),
                ),
                CustomTextField(
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
                DropdownMenu(
                  expandedInsets: EdgeInsets.zero,
                  hintText: form.newUser.diabetesType.toString(),
                  onSelected: (value) => form.newUser.diabetesType =
                      Diabetes.getDiabetesTypeByName(value!),
                  label: const Text("Diabetes Type"),
                  dropdownMenuEntries: diabetesList.map((e) {
                    return DropdownMenuEntry(value: e.name, label: e.type);
                  }).toList(),
                ),
                CustomCheckbox(
                    title: "Hypertension",
                    isChecked: form.newUser.hasHypertension,
                    onChanged: (val) =>
                        Provider.of<UserForm>(context, listen: false)
                            .toggleHypertension()),
                DropdownMenu(
                  expandedInsets: EdgeInsets.zero,
                  hintText: form.newUser.hypertensionType.toString(),
                  onSelected: (value) => form.newUser.hypertensionType =
                      Hypertension.getHypertensionTypeByName(value!),
                  label: const Text(" Hypertension Type"),
                  dropdownMenuEntries: hypertensionList.map((e) {
                    return DropdownMenuEntry(value: e.name, label: e.type);
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    form.validateForm();
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
    return ListTile(
      title: Text(title),
      trailing: Checkbox(
        value: isChecked,
        onChanged: (val) => onChanged(val),
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
  });
  final TextInputType keyboard;
  final Function onChanged;
  final Function validator;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      decoration: InputDecoration(hintText: placeholder),
      maxLines: 1,
      onChanged: (value) => onChanged(value),
      maxLength: 20,
      validator: (val) => validator(val),
    );
  }
}
