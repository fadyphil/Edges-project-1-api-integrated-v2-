import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_1/UI/widgets/info_row_builder.dart';
import 'package:mini_project_1/UI/widgets/tag_row_builder.dart';
import 'package:mini_project_1/data/models/models.dart';
import 'package:mini_project_1/routes/app_router.dart';

class TodayChallengeCard extends StatelessWidget {
  final Recipe recipe;
  const TodayChallengeCard({super.key, required this.recipe});

  


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18),),
      clipBehavior: Clip.antiAlias, // Important for rounding the image corners
      elevation: 8,
      child: Stack(
        // The Stack widget is the key to layering elements
        
        
        children: [
          // --- LAYER 1: The Background Image ---
          // It fills the entire card.
          
          Positioned(
            right: 0,
            child: DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.onSurface,
                    Theme.of(context).colorScheme.onSurface.withValues(alpha: .9),
                    Theme.of(context).colorScheme.onSurface.withValues(alpha:0 )
                  ],
                  stops: const [0.1, 0.3, 1],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              ),
              child: Image.network(
                recipe.imagePath,
                height: 225,
                width: 290,
                fit: BoxFit.cover, // Ensures the image covers the whole area
              ),
            ),
          ),
      
        
      
          // --- LAYER 3: The Content ---
          // This is the Column containing all the text and the button.
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            
              children: [
                // "Today's Challenge" Title
                Row(
                  children: [
                    const Icon(Icons.workspace_premium_outlined,size: 14,),
                    const SizedBox(width: 4),
                     Text(
                      'Today\'s Challenge',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
      
                // Recipe Name
                Text(
                  recipe.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Color(0xFFDB7A2B)),
                ),
                const SizedBox(height: 4),
      
                // Tags
                TagRowBuilder(recipe: recipe),
                const SizedBox(height: 14),
      
                // Info (Time and Steps)
                InfoRowBuilder(recipe: recipe),
                const SizedBox(height: 35),
      
                // Start Button
                ElevatedButton(
                  onPressed: () {
                    context.router.push(
                      RecipeDetailsRoute(recipe: recipe, heroprefix: 'challenge')
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDB7A2B),
                    padding: const EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Start Challenge',
                    style: TextStyle(
                      color: Colors.white,
                     
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Nunito'
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper methods for building UI parts ---
}

