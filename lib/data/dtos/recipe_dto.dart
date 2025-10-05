// lib/data/dtos/recipe_dto.dart

import 'package:json_annotation/json_annotation.dart';
import 'package:mini_project_1/data/dtos/ingredient_dto.dart';
import 'package:mini_project_1/data/dtos/step_dto.dart';

part 'recipe_dto.g.dart';




// --- DTOs for Nested Steps/Instructions ---



// --- The Main, Upgraded Recipe DTO ---
@JsonSerializable(explicitToJson: true)
class RecipeDto {
  final int id;
  final String title;
  final String? image;
  final int readyInMinutes;
  final String? summary; // For our description field

  @JsonKey(name: 'dishTypes') // The JSON calls it 'dishTypes', we'll call it 'tags'
  final List<String> tags;

  final bool vegetarian;

  final List<IngredientDto> extendedIngredients;

  // The API puts the steps inside a list called 'analyzedInstructions'
  final List<InstructionDto> analyzedInstructions;

  RecipeDto({
    required this.id,
    required this.title,
    this.image,
    required this.readyInMinutes,
    this.summary,
    required this.tags,
    required this.vegetarian,
    required this.extendedIngredients,
    required this.analyzedInstructions,
  });

  factory RecipeDto.fromJson(Map<String, dynamic> json) => _$RecipeDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeDtoToJson(this);
}