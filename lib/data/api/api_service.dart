// lib/data/api/api_service.dart

import 'package:dio/dio.dart';
import '../dtos/recipe_dto.dart';

class ApiService {
  final Dio _dio;
  
  // IMPORTANT: For a real app, never store API keys in your code.
  // But for this project, this is okay.
  static const String _apiKey = '6942fe8e1b6d434a93a780ec825b1331';

  ApiService() : _dio = Dio(
    BaseOptions(
    baseUrl: 'https://api.spoonacular.com',
    queryParameters: {'apiKey': _apiKey},
  ));

  // This function fetches a list of random recipes
  Future<List<RecipeDto>> getRandomRecipes() async {
    try {
      // We ask for 20 random recipes from the API
      final response = await _dio.get('/recipes/random?number=20');

      // The recipes are inside a list called 'recipes' in the JSON
      final recipeListJson = response.data['recipes'] as List;

      // We use our DTO's fromJson constructor to decode each recipe in the list
      return recipeListJson.map((json) => RecipeDto.fromJson(json)).toList();

    } catch (e) {
      // If anything goes wrong, we print the error and re-throw it
      print('Error fetching recipes: $e');
      throw Exception('Failed to load recipes from the API');
    }
  }
}