import 'dart:math';
import 'package:html_unescape/html_unescape.dart';
import 'package:mini_project_1/data/dtos/recipe_dto.dart';
import 'package:mini_project_1/data/dtos/step_dto.dart';
import 'package:mini_project_1/data/mapping/ingredient_mapper.dart';
import 'package:mini_project_1/data/mapping/step_mapper.dart';
import '../models/models.dart';


// --- The Main, Upgraded Recipe Mapper ---
class RecipeMapper {

  static String _stripHtmlTags(String htmlText) {
    // This regular expression finds anything that looks like an HTML tag and replaces it with an empty string.
    final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }


  static Recipe fromDto(RecipeDto dto) {
    // The API summary has HTML tags like <b> in it. This will remove them.
    final unescape = HtmlUnescape();
    
    final unescapedtext = unescape.convert(dto.summary ?? 'No description provided.');
    final cleanDescription = _stripHtmlTags(unescapedtext);

    // The API sometimes provides an empty list, so we safely extract the steps.
    final instructionSteps = dto.analyzedInstructions.isNotEmpty
        ? dto.analyzedInstructions.first.steps
        : <StepDto>[];

    return Recipe(
      // --- Direct Mapping ---
      id: dto.id.toString(),
      name: dto.title,
      imagePath: dto.image ?? 'https://via.placeholder.com/400',
      description: cleanDescription,
      tags: dto.tags,

      // --- Logical Mapping ---
      mealType: dto.vegetarian ? MealBase.veggi : MealBase.meat,
      difficulty: _mapTimeToDifficulty(dto.readyInMinutes),

      // --- Mapping Nested Lists using our other Mappers ---
      ingredients: dto.extendedIngredients.map((ingDto) => IngredientMapper.fromDto(ingDto)).toList(),
      steps: instructionSteps.map((stepDto) => StepMapper.fromDto(stepDto)).toList(),

      // --- Placeholder / Default Data ---
      acceptanceMarginInSeconds: 60, // The API doesn't provide this, so we set a default.
      nutrition: Nutrition( // The API doesn't give a clean nutrition object, so we'll make one up for now.
        calories: 300 + Random().nextInt(400),
        protein: 15 + Random().nextInt(30),
        carbs: 20 + Random().nextInt(50),
      ),
    );
  }

  // A helper to infer our difficulty enum from the API's time value
  static RecipeDifficulty _mapTimeToDifficulty(int readyInMinutes) {
    if (readyInMinutes <= 20) return RecipeDifficulty.beginner;
    if (readyInMinutes <= 45) return RecipeDifficulty.intermediate;
    if (readyInMinutes <= 75) return RecipeDifficulty.advanced;
    return RecipeDifficulty.seasoned;
  }
}