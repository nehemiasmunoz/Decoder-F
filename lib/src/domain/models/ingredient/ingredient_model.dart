import 'package:decoder/src/data/util/constants.dart';

class Ingredient {
  int id = 1;
  String name = "";
  String description = "";
  bool recommendedForDiabetics = false;
  bool recommendedForHypertensives = false;
  String diabeticsReasons = "";
  String hypertensiveReasons = "";

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
    return map;
  }

  Ingredient.fromGeminiMap(Map<String, Object?> map) {
    description = map[ingredientColumnDescription].toString();
    recommendedForDiabetics =
        map[ingredientColumnRecommendedForDiabetics] == 1 ? true : false;
    recommendedForHypertensives =
        map[ingredientColumnRecommendeForHypertensive] == 1 ? true : false;
    diabeticsReasons = map[ingredientColumnDiabeticsReasons].toString();
    hypertensiveReasons = map[ingredientColumnHypertensiveReasons].toString();
  }

  Ingredient.fromDBMap(Map<String, Object?> map) {
    id = int.parse(map[ingredientColumnId].toString());
    name = map[ingredientColumnName].toString();
    description = map[ingredientColumnDescription].toString();
    recommendedForDiabetics =
        map[ingredientColumnRecommendedForDiabetics] == 1 ? true : false;
    recommendedForHypertensives =
        map[ingredientColumnRecommendeForHypertensive] == 1 ? true : false;
    diabeticsReasons = map[ingredientColumnDiabeticsReasons].toString();
    hypertensiveReasons = map[ingredientColumnHypertensiveReasons].toString();
  }
}
