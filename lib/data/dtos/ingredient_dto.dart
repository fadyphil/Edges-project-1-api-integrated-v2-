
import 'package:json_annotation/json_annotation.dart';

part 'ingredient_dto.g.dart';

@JsonSerializable()
class IngredientDto {
  final String name;
  final double amount;
  final String unit;

  IngredientDto({required this.name, required this.amount, required this.unit});

  factory IngredientDto.fromJson(Map<String, dynamic> json) => _$IngredientDtoFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientDtoToJson(this);
}