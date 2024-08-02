import 'package:decoder/src/data/util/constants.dart';
import 'package:decoder/src/domain/models/enums/enums.dart';

class User {
  late int id;
  String name = "";
  int age = 19;
  bool hasDiabetes = false;
  bool hasHypertension = false;
  Diabetes diabetesType = Diabetes.none;
  Hypertension hypertensionType = Hypertension.none;

  void toggleHasDiabetes() {
    hasDiabetes = !hasDiabetes;
  }

  void toggleHasHypertension() {
    hasHypertension = !hasHypertension;
  }

  User();
  User.withParameters(this.name, this.age, this.hasDiabetes,
      this.hasHypertension, this.diabetesType, this.hypertensionType);

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      userColumnName: name,
      userColumnAge: age,
      userColumnHasDiabetes: hasDiabetes == true ? 1 : 0,
      userColumnHasHypertension: hasHypertension == true ? 1 : 0,
      userColumnDiabetesType: diabetesType.name,
      userColumnHypertensionType: hypertensionType.name
    };
    if (id != null) {
      map[userColumnId] = id;
    }
    return map;
  }

  User.fromMap(Map<String, Object?> map) {
    id = int.parse(map[userColumnId].toString());
    name = map[userColumnName].toString();
    age = int.parse(map[userColumnAge].toString());
    hasDiabetes = map[userColumnHasDiabetes].toString() == "1" ? true : false;
    hasHypertension =
        map[userColumnHasHypertension].toString() == "1" ? true : false;
    diabetesType =
        Diabetes.getDiabetesTypeByName(map[userColumnDiabetesType].toString());
    hypertensionType = Hypertension.getHypertensionTypeByName(
        map[userColumnHypertensionType].toString());
  }
}
