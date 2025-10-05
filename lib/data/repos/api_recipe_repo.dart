// lib/data/repos/recipe_repo.dart

import '../api/api_service.dart';
import '../mapping/recipe_mapper.dart';
import '../models/models.dart';

// This is the interface your Cubit will use
abstract class IRecipeRepository {
  Future<List<Recipe>> fetchAllRecipes();
}

// This is the real implementation that uses the API
class ApiRecipeRepository implements IRecipeRepository {
  final ApiService _apiService;

  // We pass in the ApiService so it knows how to get data
  ApiRecipeRepository({
    required ApiService apiService
    }) : _apiService = apiService;

  @override
  Future<List<Recipe>> fetchAllRecipes() async {
    // 1. Get the raw DTOs from the internet
    final recipeDtos = await _apiService.getRandomRecipes();

    // 2. Use the mapper to convert the list of DTOs into a list of our app's Recipe models
    final recipes = recipeDtos.map((dto) => RecipeMapper.fromDto(dto)).toList();

    // 3. Return the clean, ready-to-use Recipe models
    return recipes;
  }
}