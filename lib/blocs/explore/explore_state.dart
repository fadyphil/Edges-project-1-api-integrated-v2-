import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mini_project_1/data/models/models.dart'; // <-- Replace with your project name

part 'explore_state.freezed.dart';


@freezed
abstract class ExploreState with _$ExploreState {
  // A private constructor is needed by freezed to add our custom getters.
  const ExploreState._();

  /// The state before the local data has been loaded into the cubit.
  /// The UI can use this to know it shouldn't render the main content yet.
  const factory ExploreState.initial() = _Initial;
  const factory ExploreState.loading()= _Loading;

  /// The primary state when all recipe data has been successfully loaded.
  /// This state contains all the information the UI needs to display the Explore screen.
  const factory ExploreState.loaded({
    /// The master list of all recipes from the data source.
    required List<Recipe> allRecipes,
    
    /// The current text in the search bar. Defaults to empty.
    @Default('') String searchQuery,
    
    /// The current view mode (list or grid). Defaults to list.
    @Default(ExploreViewType.list) ExploreViewType viewType,

    @Default({}) final Set<String> selectedTags,
    required final Set<String> allTags,
    
  }) = _Loaded;

  const factory ExploreState.error(String message)= _Error;

  

  // --- Inferred State Getter ---
  
  /// Calculates and returns the "Today's Challenge" recipe.
  /// This is an inferred property, calculated on the fly.
  /// It returns null if the state is not `loaded` or if there are no recipes.
   Recipe? get todaysChallenge {
    // `when` is the safest way to handle all states explicitly.
    return when(
      // --- FIX #1: The initial state has no recipes, so return null. ---
      initial: () => null,
      loading: () => null,
      loaded: (allRecipes, _, __, ___, ____) {
        // Guard clause for an empty recipe list to prevent crashes.
        if (allRecipes.isEmpty) {
          return null;
        }
        
        // This logic ensures the challenge is the same for the whole day.
        final dayOfYear = DateTime.now().day;
        final challengeIndex = dayOfYear % allRecipes.length;
        return allRecipes[challengeIndex];
      },
      error: (message) => null,
    );
  }


   List<Recipe> get filteredRecipes {
    return when(
      initial: () => [],
      loading: () => [],
      loaded: (allRecipes, searchQuery, _, selectedTags,_) {
        // Start with a copy of all recipes
        List<Recipe> filtered = List.from(allRecipes);

        // 1. Filter by search query
        if (searchQuery.isNotEmpty) {
          filtered = filtered.where((recipe) {
            return recipe.name.toLowerCase().contains(searchQuery.toLowerCase());
          }).toList();
        }

        // 2. Filter by selected tags
        if (selectedTags.isNotEmpty) {
          filtered = filtered.where((recipe) {
            // A recipe is kept if its tags contain ALL of the selected tags.
            return selectedTags.every((tag) => recipe.tags.contains(tag));
          }).toList();
        }

        return filtered;
      },
      error: (message) => [],
    );
  }

  ExploreViewType get theViewType {
    return  maybeWhen(
      loaded: (_,_,viewType,_,_) => viewType,
      orElse: ()=> ExploreViewType.list,
    );
  }
}