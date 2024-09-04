import 'package:decoder/util/constants.dart';

class Ingredient {
  int id = 1;
  String name = "";
  String description = "";
  bool recommendedForMe = false;
  String diabeticsReasons = "";
  String hypertensiveReasons = "";

  Ingredient();

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      ingredientColumnName: name,
      ingredientColumnDescription: description,
      ingredientColumnRecommendedForMe: recommendedForMe == true ? 1 : 0,
      ingredientColumnDiabeticsReasons: diabeticsReasons,
      ingredientColumnHypertensiveReasons: hypertensiveReasons
    };
    return map;
  }

  Ingredient.toObject(Map<String, Object?> map) {
    description = map[ingredientColumnDescription].toString();
    recommendedForMe =
        bool.parse(map[ingredientColumnRecommendedForMe].toString());
    diabeticsReasons = map[ingredientColumnDiabeticsReasons].toString();
    hypertensiveReasons = map[ingredientColumnHypertensiveReasons].toString();
  }

  Ingredient.fromDBMap(Map<String, Object?> map) {
    id = int.parse(map[ingredientColumnId].toString());
    name = map[ingredientColumnName].toString();
    description = map[ingredientColumnDescription].toString();
    recommendedForMe =
        map[ingredientColumnRecommendedForMe] == 1 ? true : false;
    diabeticsReasons = map[ingredientColumnDiabeticsReasons].toString();
    hypertensiveReasons = map[ingredientColumnHypertensiveReasons].toString();
  }
}
