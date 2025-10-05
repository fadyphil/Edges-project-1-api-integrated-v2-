// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeDto _$RecipeDtoFromJson(Map<String, dynamic> json) => RecipeDto(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  image: json['image'] as String?,
  readyInMinutes: (json['readyInMinutes'] as num).toInt(),
  summary: json['summary'] as String?,
  tags: (json['dishTypes'] as List<dynamic>).map((e) => e as String).toList(),
  vegetarian: json['vegetarian'] as bool,
  extendedIngredients: (json['extendedIngredients'] as List<dynamic>)
      .map((e) => IngredientDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  analyzedInstructions: (json['analyzedInstructions'] as List<dynamic>)
      .map((e) => InstructionDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RecipeDtoToJson(RecipeDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'image': instance.image,
  'readyInMinutes': instance.readyInMinutes,
  'summary': instance.summary,
  'dishTypes': instance.tags,
  'vegetarian': instance.vegetarian,
  'extendedIngredients': instance.extendedIngredients
      .map((e) => e.toJson())
      .toList(),
  'analyzedInstructions': instance.analyzedInstructions
      .map((e) => e.toJson())
      .toList(),
};
