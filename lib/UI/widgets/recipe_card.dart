import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_project_1/UI/widgets/info_row_builder.dart';
import 'package:mini_project_1/UI/widgets/tag_row_builder.dart';
import 'package:mini_project_1/data/models/models.dart';
import 'package:mini_project_1/blocs/favourited/favourited_cubit.dart';
import 'package:mini_project_1/routes/app_router.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final String heroprefix;
  const RecipeCard({
    super.key,
    required this.recipe, 
    this.heroprefix ='explore',
  });

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () {
        context.router.push(
          RecipeDetailsRoute(recipe: recipe,heroprefix: heroprefix),
        );
      },
      child: Card(
        
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 5,
        child: Row(
          
          children: [
      
            Hero(
              tag: '${heroprefix}recipe_image_${recipe.id}',
              child: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors:  [
                      Theme.of(context).colorScheme.onSurface,
                      Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
                    ] ,
                    stops: const [0.02,0.2,1],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    )
                ),
                child: Image.network(
                  recipe.imagePath, 
                  width: 100, 
                  height: 100, 
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.error,
                      size: 40,
                      color: Colors.red,
                      );
                  },
                  ),
                 
                ),
            ),
           
      
      
            // --- Main Content (Name, Tags, Info) ---
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                
                  crossAxisAlignment: CrossAxisAlignment.start,
                          
                  children: [
                    Hero(
                      tag: '${heroprefix}recipe_name_${recipe.id}',
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(
                          recipe.name,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Dynamically build the tags
                    Hero(
                      tag: '${heroprefix}recipe_tags_${recipe.id}',
                      child: TagRowBuilder(recipe: recipe)
                      ),
                    const SizedBox(height: 18),
                    InfoRowBuilder(recipe: recipe),
                  ],
                ),
              ),
            ),
          
      
      
            // --- Favorite Button ---
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 35,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    
                children: [

                  Hero(
                    tag: '${heroprefix}recipe_favorite_${recipe.id}',
                    child: Material(
                      type: MaterialType.transparency,
                      child: FavouriteButton(recipe: recipe))
                    ),
                
                  Hero(
                    tag: '${heroprefix}recipe_type_${recipe.id}',
                    child: Container(
                      
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: recipe.mealType.name=='meat'? 
                        const Color(0xFFD76261).withValues(alpha: 0.1):
                        const Color(0xFF4ABC96).withValues(alpha:  0.1)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: SvgPicture.asset(
                         'assets/images/${recipe.mealType.name}_base.svg',
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class FavouriteButton extends StatelessWidget {
  const FavouriteButton({
    super.key, 
    required this.recipe
    });

  final Recipe recipe;
  

  @override
  Widget build(BuildContext context) {
    final isFavorited = context.watch<FavouritedCubit>().state.favouritedRecipes.contains(recipe);

    return InkWell(
            onTap: () {
              context.read<FavouritedCubit>().toggleFavourite(recipe);
                },
            child: Container(
                    padding: const EdgeInsets.all(4),
                    //  margin: EdgeInsets.only(bottom: 15),
                     decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: 0.2),
                        width: 1,
                        style: BorderStyle.solid,
                      )
                   
                     ),
                     child:  Center(
                      child: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border_rounded,
                        color: isFavorited ? Colors.redAccent : Colors.white70,
                        size: 16,
                      ),
                     )
                   ),
                 ) ;
  }
}