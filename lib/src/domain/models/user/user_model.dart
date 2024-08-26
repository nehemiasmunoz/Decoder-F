import 'package:decoder/src/data/util/constants.dart';
import 'package:decoder/src/domain/models/enums/enums.dart';

class User {
  int id = 1;
  String name = "";
  int age = 19;
  Diabetes diabetesType = Diabetes.none;
  Hypertension hypertensionType = Hypertension.none;

  User();
  User.withParameters(
      this.name, this.age, this.diabetesType, this.hypertensionType);

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      userColumnName: name,
      userColumnAge: age,
      userColumnDiabetesType: diabetesType.name,
      userColumnHypertensionType: hypertensionType.name
    };
    map[userColumnId] = id;
    return map;
  }

  User.fromMap(Map<String, Object?> map) {
    id = int.parse(map[userColumnId].toString());
    name = map[userColumnName].toString();
    age = int.parse(map[userColumnAge].toString());
    diabetesType =
        Diabetes.getDiabetesTypeByName(map[userColumnDiabetesType].toString());
    hypertensionType = Hypertension.getHypertensionTypeByName(
        map[userColumnHypertensionType].toString());
  }
}
