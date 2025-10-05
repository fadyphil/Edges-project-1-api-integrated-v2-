// lib/blocs/history/history_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project_1/blocs/historyy/history_state.dart';
import 'package:mini_project_1/data/models/recipe_challenge_model.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(const HistoryState());

  void addChallengeToHistory(RecipeChallenge challenge) {
    // Add the new challenge to the beginning of the list
    final updatedList = [challenge, ...state.challenges];
    emit(state.copyWith(challenges: updatedList));
  }
}