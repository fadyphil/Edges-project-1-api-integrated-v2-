// lib/data/models/recipe_challenge_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mini_project_1/data/models/recipe_model.dart';

part 'recipe_challenge_model.freezed.dart';

@freezed
abstract class RecipeChallenge with _$RecipeChallenge {
  const factory RecipeChallenge({
    required Recipe recipe,
    required Duration timeTaken,
    required Duration expectedTime,
    required DateTime dateCompleted,
  }) = _RecipeChallenge;
}