import 'package:mini_project_1/data/dtos/ingredient_dto.dart';
import 'package:mini_project_1/data/models/enums.dart';
import 'package:mini_project_1/data/models/ingredient_model.dart';

class IngredientMapper {
  static Ingredient fromDto(IngredientDto dto) {
    return Ingredient(
      name: dto.name,
      quantity: dto.amount,
      unit: _mapUnit(dto.unit.toLowerCase()), // Convert the API's string to our enum
    );
  }

  // This helper turns the API's text for a unit into our app's enum
  static MeasurementUnit _mapUnit(String unitString) {
    if (unitString.contains('cup')) return MeasurementUnit.cup;
    if (unitString.contains('tbsp') || unitString.contains('tablespoon')) return MeasurementUnit.tablespoon;
    if (unitString.contains('tsp') || unitString.contains('teaspoon')) return MeasurementUnit.teaspoon;
    if (unitString.contains('clove')) return MeasurementUnit.clove;
    // Add more cases here as needed
    return MeasurementUnit.piece; // A safe default
  }
}