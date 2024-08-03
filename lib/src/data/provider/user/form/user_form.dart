import 'package:decoder/src/domain/models/enums/enums.dart';
import 'package:decoder/src/domain/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserForm extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  User newUser = User.withParameters(
      "", 0, false, false, Diabetes.none, Hypertension.none);
  GlobalKey<FormState> get formKey => _formKey;

  void toggleDiabetes() {
    newUser.toggleHasDiabetes();
    notifyListeners();
  }

  void toggleHypertension() {
    newUser.toggleHasHypertension();
    notifyListeners();
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
      return "Please enter a valid name";
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
      return "Please enter a valid age";
    }
  }

  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  User getUserData() {
    print("lala");
    print(newUser);
    return newUser;
  }
}
