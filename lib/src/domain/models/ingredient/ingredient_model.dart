import 'package:decoder/src/data/util/constants.dart';

class Ingredient {
  late int id;
  late String name;
  late String description;
  late bool recommendedForDiabetics;
  late bool recommendedForHypertensives;
  late String diabeticsReasons;
  late String hypertensiveReasons;

  Ingredient();

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      ingredientColumnName: name,
      ingredientColumnDescription: description,
      ingredientColumnRecommendedForDiabetics:
          recommendedForDiabetics == true ? 1 : 0,
      ingredientColumnRecommendeForHypertensive:
          recommendedForHypertensives == true ? 1 : 0,
      ingredientColumnDiabeticsReasons: diabeticsReasons,
      ingredientColumnHypertensiveReasons: hypertensiveReasons
    };
    map[ingredientColumnId] == 1;
    return map;
  }

  Ingredient.fromMap(Map<String, Object?> map) {
    id = int.parse(map[ingredientColumnId].toString());
    name = map[ingredientColumnName].toString();
    description = map[ingredientColumnDescription].toString();
    recommendedForDiabetics =
        map[ingredientColumnRecommendedForDiabetics].toString() == "1"
            ? true
            : false;
    recommendedForHypertensives =
        map[ingredientColumnRecommendeForHypertensive].toString() == "1"
            ? true
            : false;
    diabeticsReasons = map[ingredientColumnDiabeticsReasons].toString();
    hypertensiveReasons = map[ingredientColumnHypertensiveReasons].toString();
  }
}
