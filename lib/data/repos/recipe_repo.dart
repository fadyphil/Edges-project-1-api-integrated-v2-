// lib/data/repositories/recipe_repository.dart
import 'package:mini_project_1/data/models/models.dart';

// -------------------
// 1. The Interface (The Contract) - Now Synchronous
// -------------------
/// Defines the contract for fetching recipe data.
// abstract class IRecipeRepository {
//   /// Fetches the complete list of all available recipes synchronously.
//   List<Recipe> fetchAllRecipes();
// }

// -------------------
// 2. The Concrete Implementation (The Dummy Data Source) - Now Synchronous
// -------------------
/// This is a dummy implementation that returns a hardcoded list of recipes instantly.
class RecipeRepository {
  @override
  List<Recipe> fetchAllRecipes() {
    // No Future, no async, no delay. It returns the data immediately.
    return _dummyRecipes;
  }

  // A private list containing our sample recipe data.
  static final List<Recipe> _dummyRecipes = [
    // --- Recipe 1: Chicken Alfredo (Existing) ---
    Recipe(
      id: 'chicken-alfredo',
      name: 'Chicken Alfredo',
      description: 'A creamy and classic pasta dish that is a favorite for all ages. Simple to make and endlessly satisfying.',
      imagePath: 'assets/images/chickenAlfredo.jpeg',
      tags: ['Chicken', 'Pasta', 'Creamy'],
      mealType: MealBase.meat,
      difficulty: RecipeDifficulty.intermediate,
      acceptanceMarginInSeconds: 300, // 5 minutes
      nutrition: const Nutrition(calories: 820, protein: 46, carbs: 54),
      ingredients: [
        const Ingredient(name: 'Fettuccine Pasta', quantity: 250, unit: MeasurementUnit.gram),
        const Ingredient(name: 'Chicken Breast', quantity: 500, unit: MeasurementUnit.gram),
        const Ingredient(name: 'Heavy Cream', quantity: 1, unit: MeasurementUnit.cup),
        const Ingredient(name: 'Parmesan Cheese', quantity: 0.5, unit: MeasurementUnit.cup),
        const Ingredient(name: 'Garlic', quantity: 2, unit: MeasurementUnit.clove),
      ],
      steps: [
        const Step(title: 'Boil Pasta', description: 'Cook fettuccine according to package directions.', baseTimeInSeconds: 600, type: StepType.cooking),
        const Step(title: 'Prep Chicken', description: 'Cut chicken breast into bite-sized pieces and season with salt and pepper.', baseTimeInSeconds: 300, type: StepType.prep),
        const Step(title: 'Cook Chicken', description: 'In a large skillet, cook chicken pieces until golden brown and cooked through.', baseTimeInSeconds: 480, type: StepType.cooking),
        const Step(title: 'Make Sauce', description: 'Sauté minced garlic, then add heavy cream and bring to a simmer. Stir in Parmesan cheese until melted.', baseTimeInSeconds: 420, type: StepType.cooking),
        const Step(title: 'Combine', description: 'Add the cooked pasta and chicken to the sauce. Toss to combine and serve immediately.', baseTimeInSeconds: 120, type: StepType.cooking),
      ],
    ),

    // --- Recipe 2: Veggie Fried Rice (Existing) ---
    Recipe(
      id: 'veggie-fried-rice',
      name: 'Veggie Fried Rice',
      description: 'A quick and easy fried rice recipe packed with vegetables. Perfect for a weeknight meal using leftover rice.',
      imagePath: 'assets/images/veggiFriedRice.jpg',
      tags: ['Rice', 'Vegetable', 'Quick'],
      mealType: MealBase.veggi,
      difficulty: RecipeDifficulty.beginner,
      acceptanceMarginInSeconds: 180, // 3 minutes
      nutrition: const Nutrition(calories: 450, protein: 15, carbs: 75),
      ingredients: [
        const Ingredient(name: 'Cooked Rice', quantity: 3, unit: MeasurementUnit.cup),
        const Ingredient(name: 'Soy Sauce', quantity: 3, unit: MeasurementUnit.tablespoon),
        const Ingredient(name: 'Mixed Vegetables (frozen)', quantity: 1.5, unit: MeasurementUnit.cup),
        const Ingredient(name: 'Sesame Oil', quantity: 1, unit: MeasurementUnit.teaspoon),
        const Ingredient(name: 'Eggs', quantity: 2, unit: MeasurementUnit.piece),
      ],
      steps: [
        const Step(title: 'Scramble Eggs', description: 'In a large wok or skillet, scramble the eggs and set aside.', baseTimeInSeconds: 180, type: StepType.cooking , note: 'Whisk eggs thoroughly before cooking for a fluffier texture.'),
        const Step(title: 'Sauté Vegetables', description: 'Add vegetables to the wok and stir-fry until tender-crisp.', baseTimeInSeconds: 300, type: StepType.cooking),
        const Step(title: 'Combine and Fry', description: 'Add the rice, soy sauce, and sesame oil. Stir-fry for 3-5 minutes until heated through.', baseTimeInSeconds: 300, type: StepType.cooking),
        const Step(title: 'Finish', description: 'Stir in the scrambled eggs and serve hot.', baseTimeInSeconds: 60, type: StepType.cooking),
      ],
    ),

    // --- Recipe 3: Classic Beef Tacos ---
    Recipe(
      id: 'classic-beef-tacos',
      name: 'Classic Beef Tacos',
      description: 'A fun, customizable, and always delicious meal for the whole family. Perfect for taco night!',
      imagePath: 'assets/images/beef_tacos.jpg',
      tags: ['Beef', 'Mexican', 'Family'],
      mealType: MealBase.meat,
      difficulty: RecipeDifficulty.beginner,
      acceptanceMarginInSeconds: 240, // 4 minutes
      nutrition: const Nutrition(calories: 550, protein: 30, carbs: 35),
      ingredients: [
        const Ingredient(name: 'Ground Beef', quantity: 500, unit: MeasurementUnit.gram),
        const Ingredient(name: 'Taco Seasoning', quantity: 1, unit: MeasurementUnit.piece),
        const Ingredient(name: 'Hard Taco Shells', quantity: 8, unit: MeasurementUnit.piece),
        const Ingredient(name: 'Lettuce, shredded', quantity: 1, unit: MeasurementUnit.cup),
        const Ingredient(name: 'Tomatoes, diced', quantity: 1, unit: MeasurementUnit.cup),
        const Ingredient(name: 'Cheddar Cheese, shredded', quantity: 1, unit: MeasurementUnit.cup),
      ],
      steps: [
        const Step(title: 'Prep Toppings', description: 'Wash and chop the lettuce and tomatoes. Set aside in bowls.', baseTimeInSeconds: 420, type: StepType.prep, note: 'Prepping toppings first makes assembly quick and easy.'),
        const Step(title: 'Cook Beef', description: 'In a skillet, cook ground beef over medium-high heat until browned. Drain excess fat.', baseTimeInSeconds: 480, type: StepType.cooking),
        const Step(title: 'Season Meat', description: 'Stir in taco seasoning and water (as per package instructions). Simmer for 5 minutes.', baseTimeInSeconds: 300, type: StepType.cooking),
        const Step(title: 'Assemble Tacos', description: 'Warm taco shells. Fill with seasoned beef and your favorite toppings.', baseTimeInSeconds: 180, type: StepType.prep),
      ],
    ),
    
    // --- Recipe 4: Fluffy Buttermilk Pancakes ---
    Recipe(
      id: 'fluffy-pancakes',
      name: 'Fluffy Pancakes',
      description: 'The ultimate weekend breakfast. These pancakes are light, fluffy, and delicious with your favorite toppings.',
      imagePath: 'assets/images/Fluffy-Pancakes.jpg',
      tags: ['Breakfast', 'Sweet', 'Vegetarian'],
      mealType: MealBase.veggi,
      difficulty: RecipeDifficulty.beginner,
      acceptanceMarginInSeconds: 120, // 2 minutes
      nutrition: const Nutrition(calories: 380, protein: 12, carbs: 60),
      ingredients: [
        const Ingredient(name: 'All-Purpose Flour', quantity: 1.5, unit: MeasurementUnit.cup),
        const Ingredient(name: 'Baking Powder', quantity: 2, unit: MeasurementUnit.teaspoon),
        const Ingredient(name: 'Sugar', quantity: 2, unit: MeasurementUnit.tablespoon),
        const Ingredient(name: 'Salt', quantity: 0.5, unit: MeasurementUnit.teaspoon),
        const Ingredient(name: 'Buttermilk', quantity: 1.25, unit: MeasurementUnit.cup),
        const Ingredient(name: 'Egg', quantity: 1, unit: MeasurementUnit.piece),
        const Ingredient(name: 'Melted Butter', quantity: 2, unit: MeasurementUnit.tablespoon),
      ],
      steps: [
        const Step(title: 'Mix Dry Ingredients', description: 'In a large bowl, whisk together flour, baking powder, sugar, and salt.', baseTimeInSeconds: 120, type: StepType.prep),
        const Step(title: 'Mix Wet Ingredients', description: 'In a separate bowl, whisk together buttermilk, egg, and melted butter.', baseTimeInSeconds: 180, type: StepType.prep, note: 'Do not overmix the batter! A few lumps are okay.'),
        const Step(title: 'Combine Batter', description: 'Pour the wet ingredients into the dry ingredients and stir until just combined.', baseTimeInSeconds: 60, type: StepType.prep),
        const Step(title: 'Cook Pancakes', description: 'Heat a lightly oiled griddle. Pour 1/4 cup of batter for each pancake. Cook until bubbles appear, then flip and cook until golden brown.', baseTimeInSeconds: 480, type: StepType.cooking),
      ],
    ),

    // --- Recipe 5: Caprese Salad ---
    Recipe(
      id: 'caprese-salad',
      name: 'Caprese Salad',
      description: 'A simple and elegant Italian salad, showcasing the flavors of fresh tomatoes, mozzarella, and basil.',
      imagePath: 'assets/images/caprese-salad.jpg',
      tags: ['Salad', 'Italian', 'No-Cook'],
      mealType: MealBase.veggi,
      difficulty: RecipeDifficulty.beginner,
      acceptanceMarginInSeconds: 300, // 5 minutes
      nutrition: const Nutrition(calories: 250, protein: 15, carbs: 8),
      ingredients: [
        const Ingredient(name: 'Tomatoes', quantity: 3, unit: MeasurementUnit.piece),
        const Ingredient(name: 'Fresh Mozzarella', quantity: 225, unit: MeasurementUnit.gram),
        const Ingredient(name: 'Fresh Basil Leaves', quantity: 0.5, unit: MeasurementUnit.cup),
        const Ingredient(name: 'Extra Virgin Olive Oil', quantity: 2, unit: MeasurementUnit.tablespoon),
        const Ingredient(name: 'Balsamic Glaze', quantity: 1, unit: MeasurementUnit.tablespoon),
      ],
      steps: [
        const Step(title: 'Slice Ingredients', description: 'Slice the tomatoes and mozzarella into 1/4-inch thick rounds.', baseTimeInSeconds: 300, type: StepType.prep),
        const Step(title: 'Arrange Salad', description: 'On a platter, alternate slices of tomato, mozzarella, and fresh basil leaves.', baseTimeInSeconds: 180, type: StepType.prep),
        const Step(title: 'Dress and Serve', description: 'Drizzle with olive oil and balsamic glaze. Season with salt and pepper to taste.', baseTimeInSeconds: 60, type: StepType.prep, note: 'Use the best quality ingredients you can find, as the flavors are very simple.'),
      ],
    ),
    
    // --- Recipe 6: Spicy Thai Green Curry ---
    Recipe(
      id: 'thai-green-curry',
      name: 'Spicy Thai Green Curry',
      description: 'A vibrant and aromatic curry that is surprisingly easy to make at home. Adjust the spice to your liking!',
      imagePath: 'assets/images/thaicurry.jpg',
      tags: ['Spicy', 'Thai', 'Vegan'],
      mealType: MealBase.veggi,
      difficulty: RecipeDifficulty.advanced,
      acceptanceMarginInSeconds: 420, // 7 minutes
      nutrition: const Nutrition(calories: 600, protein: 20, carbs: 45),
      ingredients: [
        const Ingredient(name: 'Coconut Milk', quantity: 400, unit: MeasurementUnit.milliliter),
        const Ingredient(name: 'Green Curry Paste', quantity: 3, unit: MeasurementUnit.tablespoon),
        const Ingredient(name: 'Firm Tofu', quantity: 400, unit: MeasurementUnit.gram),
        const Ingredient(name: 'Bell Pepper', quantity: 1, unit: MeasurementUnit.piece),
        const Ingredient(name: 'Zucchini', quantity: 1, unit: MeasurementUnit.piece),
        const Ingredient(name: 'Jasmine Rice, for serving', quantity: 2, unit: MeasurementUnit.cup),
      ],
      steps: [
        const Step(title: 'Prep Ingredients', description: 'Press and cube the tofu. Slice the bell pepper and zucchini.', baseTimeInSeconds: 600, type: StepType.prep),
        const Step(title: 'Fry Curry Paste', description: 'In a pot, heat a little oil and fry the green curry paste for 1 minute until fragrant.', baseTimeInSeconds: 120, type: StepType.cooking, note: 'Frying the paste is crucial to release its aromas.'),
        const Step(title: 'Build the Curry', description: 'Add the coconut milk and bring to a simmer. Add the tofu and vegetables.', baseTimeInSeconds: 300, type: StepType.cooking),
        const Step(title: 'Simmer', description: 'Let the curry simmer for 10-15 minutes, or until the vegetables are tender.', baseTimeInSeconds: 900, type: StepType.cooking),
        const Step(title: 'Serve', description: 'Serve the hot curry over steamed jasmine rice.', baseTimeInSeconds: 60, type: StepType.prep),
      ],
    ),

    // --- Recipe 7: One-Pan Lemon Herb Chicken ---
    Recipe(
      id: 'one-pan-chicken',
      name: 'One-Pan Lemon Herb Chicken',
      description: 'An incredibly flavorful and easy weeknight dinner with minimal cleanup. The chicken and potatoes roast together to perfection.',
      imagePath: 'assets/images/one_pan_chicken.jpg',
      tags: ['Chicken', 'Easy', 'One-Pan'],
      mealType: MealBase.meat,
      difficulty: RecipeDifficulty.intermediate,
      acceptanceMarginInSeconds: 300, // 5 minutes
      nutrition: const Nutrition(calories: 750, protein: 50, carbs: 40),
      ingredients: [
        const Ingredient(name: 'Chicken Thighs (bone-in, skin-on)', quantity: 4, unit: MeasurementUnit.piece),
        const Ingredient(name: 'Baby Potatoes', quantity: 700, unit: MeasurementUnit.gram),
        const Ingredient(name: 'Lemon', quantity: 1, unit: MeasurementUnit.piece),
        const Ingredient(name: 'Garlic', quantity: 4, unit: MeasurementUnit.clove),
        const Ingredient(name: 'Rosemary (fresh)', quantity: 2, unit: MeasurementUnit.piece),
      ],
      steps: [
        const Step(title: 'Preheat & Prep', description: 'Preheat oven to 400°F (200°C). Halve the potatoes and slice the lemon.', baseTimeInSeconds: 420, type: StepType.prep),
        const Step(title: 'Season', description: 'On a large sheet pan, toss potatoes, garlic, and rosemary with olive oil, salt, and pepper.', baseTimeInSeconds: 180, type: StepType.prep),
        const Step(title: 'Arrange Pan', description: 'Pat chicken thighs dry and place them among the potatoes. Season the chicken.', baseTimeInSeconds: 120, type: StepType.prep, note: 'Ensure the chicken skin is dry for a crispy result.'),
        const Step(title: 'Roast', description: 'Roast for 40-45 minutes, until chicken is cooked through and potatoes are tender.', baseTimeInSeconds: 2700, type: StepType.cooking),
      ],
    ),

    // --- Recipe 8: Fudgy Chocolate Brownies ---
    Recipe(
      id: 'fudgy-brownies',
      name: 'Fudgy Chocolate Brownies',
      description: 'The ultimate decadent treat. These brownies are rich, chewy, and packed with intense chocolate flavor.',
      imagePath: 'assets/images/brownies.jpg',
      tags: ['Dessert', 'Chocolate', 'Baking'],
      mealType: MealBase.veggi,
      difficulty: RecipeDifficulty.intermediate,
      acceptanceMarginInSeconds: 180, // 3 minutes for baking
      nutrition: const Nutrition(calories: 350, protein: 4, carbs: 45),
      ingredients: [
        const Ingredient(name: 'Unsalted Butter', quantity: 0.5, unit: MeasurementUnit.cup),
        const Ingredient(name: 'Granulated Sugar', quantity: 1, unit: MeasurementUnit.cup),
        const Ingredient(name: 'Eggs', quantity: 2, unit: MeasurementUnit.piece),
        const Ingredient(name: 'Vanilla Extract', quantity: 1, unit: MeasurementUnit.teaspoon),
        const Ingredient(name: 'All-Purpose Flour', quantity: 0.5, unit: MeasurementUnit.cup),
        const Ingredient(name: 'Cocoa Powder', quantity: 0.33, unit: MeasurementUnit.cup),
        const Ingredient(name: 'Chocolate Chips', quantity: 1, unit: MeasurementUnit.cup),
      ],
      steps: [
        const Step(title: 'Melt Butter & Sugar', description: 'Preheat oven to 350°F (175°C). In a saucepan, melt butter. Remove from heat and stir in sugar.', baseTimeInSeconds: 300, type: StepType.cooking),
        const Step(title: 'Add Wet Ingredients', description: 'Add eggs and vanilla extract to the butter/sugar mixture and whisk well.', baseTimeInSeconds: 180, type: StepType.prep),
        const Step(title: 'Combine Dry Ingredients', description: 'In a separate bowl, whisk together flour and cocoa powder. Fold into the wet mixture until just combined.', baseTimeInSeconds: 240, type: StepType.prep, note: 'Do not overmix once the flour is added.'),
        const Step(title: 'Add Chocolate & Bake', description: 'Stir in chocolate chips. Pour batter into a greased 8x8 inch pan. Bake for 25-30 minutes.', baseTimeInSeconds: 1800, type: StepType.cooking),
        const Step(title: 'Cool', description: 'Let the brownies cool completely in the pan before cutting.', baseTimeInSeconds: 1, type: StepType.prep),
      ],
    ),

    // --- Recipe 9: Classic Tomato Soup ---
    Recipe(
      id: 'classic-tomato-soup',
      name: 'Classic Tomato Soup',
      description: 'A creamy and comforting tomato soup that is perfect for a chilly day. Serve with a grilled cheese sandwich for the ultimate comfort meal.',
      imagePath: 'assets/images/tomato_soup.jpeg',
      tags: ['Soup', 'Vegetarian', 'Comfort Food'],
      mealType: MealBase.veggi,
      difficulty: RecipeDifficulty.intermediate,
      acceptanceMarginInSeconds: 600, // 10 minutes
      nutrition: const Nutrition(calories: 300, protein: 8, carbs: 30),
      ingredients: [
        const Ingredient(name: 'Canned Whole Tomatoes', quantity: 800, unit: MeasurementUnit.gram),
        const Ingredient(name: 'Onion', quantity: 1, unit: MeasurementUnit.piece),
        const Ingredient(name: 'Garlic', quantity: 3, unit: MeasurementUnit.clove),
        const Ingredient(name: 'Vegetable Broth', quantity: 2, unit: MeasurementUnit.cup),
        const Ingredient(name: 'Heavy Cream', quantity: 0.5, unit: MeasurementUnit.cup),
      ],
      steps: [
        const Step(title: 'Sauté Aromatics', description: 'In a large pot, sauté chopped onion and minced garlic in olive oil until soft.', baseTimeInSeconds: 420, type: StepType.cooking),
        const Step(title: 'Add Tomatoes & Broth', description: 'Add the canned tomatoes (with their juice) and vegetable broth. Break up tomatoes with a spoon.', baseTimeInSeconds: 180, type: StepType.cooking),
        const Step(title: 'Simmer Soup', description: 'Bring the soup to a boil, then reduce heat and simmer for 20 minutes to let flavors meld.', baseTimeInSeconds: 1200, type: StepType.cooking),
        const Step(title: 'Blend Soup', description: 'Use an immersion blender to blend the soup until smooth. Alternatively, blend in batches in a regular blender.', baseTimeInSeconds: 300, type: StepType.prep, note: 'Be careful when blending hot liquids!'),
        const Step(title: 'Finish with Cream', description: 'Stir in the heavy cream and season with salt and pepper to taste. Heat through but do not boil.', baseTimeInSeconds: 120, type: StepType.cooking),
      ],
    ),
  ];
}