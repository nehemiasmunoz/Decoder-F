import 'package:decoder/src/domain/models/enums/enums.dart';
import 'package:decoder/src/domain/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserForm extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  User newUser = User.withParameters("", 0, Diabetes.none, Hypertension.none);
  GlobalKey<FormState> get formKey => _formKey;

  void fillUser(User user) {
    newUser.name = user.name;
    newUser.age = user.age;
    newUser.diabetesType = user.diabetesType;
    newUser.hypertensionType = user.hypertensionType;
    // notifyListeners();
  }

  void setDiabetes(Diabetes newValue) {
    newUser.diabetesType = newValue;
    notifyListeners();
  }

  void setHypertension(Hypertension newValue) {
    newUser.hypertensionType = newValue;
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
    return newUser;
  }
}
