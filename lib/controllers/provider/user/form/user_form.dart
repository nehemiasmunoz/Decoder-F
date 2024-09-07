import 'package:decoder/models/enums/enums.dart';
import 'package:decoder/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserForm extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlAge = TextEditingController();
  Diabetes diabetesType = Diabetes.none;
  Hypertension hypertensionType = Hypertension.none;

  GlobalKey<FormState> get formKey => _formKey;

  void setDiabetes(Diabetes newValue) {
    diabetesType = newValue;
    notifyListeners();
  }

  void setHypertension(Hypertension newValue) {
    hypertensionType = newValue;
    notifyListeners();
  }

  validateName(String? val) {
    if (val != null && val.isNotEmpty) {
      return null;
    } else {
      return "Ingresa un nombre valido";
    }
  }

  validateAge(String? val) {
    int age = 0;
    if (val != null) {
      try {
        age = int.tryParse(val)!;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      if (age > 0 && age < 130) {
        return null;
      }
      return "Ingresa una edad valida";
    }
  }

  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  User getUserData() {
    return User.withParameters(
      ctrlName.text,
      int.parse(ctrlAge.text),
      diabetesType,
      hypertensionType,
    );
  }

  void resetForm() {
    ctrlAge.clear();
    ctrlName.clear();
    diabetesType = Diabetes.none;
    hypertensionType = Hypertension.none;
    notifyListeners();
  }
}
