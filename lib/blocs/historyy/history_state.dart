// lib/blocs/history/history_state.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mini_project_1/data/models/recipe_challenge_model.dart';

part 'history_state.freezed.dart';


@freezed
abstract class HistoryState with _$HistoryState {
  const factory HistoryState({
    // The state will just hold a list of our new challenge objects
    @Default([]) List<RecipeChallenge> challenges,
  }) = _HistoryState;
}