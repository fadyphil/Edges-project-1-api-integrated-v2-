import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project_1/UI/sub_screens/overview_subscreen.dart';
import 'package:mini_project_1/UI/sub_screens/steps_subscreen.dart';
import 'package:mini_project_1/UI/widgets/tag_row_builder.dart';
import 'package:mini_project_1/blocs/explore/explore_cubit.dart';
import 'package:mini_project_1/blocs/favourited/favourited_cubit.dart';
import 'package:mini_project_1/blocs/favourited/favourited_state.dart';
import 'package:mini_project_1/blocs/recipe_details/recipe_details_cubit.dart';
import 'package:mini_project_1/blocs/recipe_details/recipe_details_state.dart';
import 'package:mini_project_1/data/models/enums.dart';
import 'package:mini_project_1/data/models/recipe_model.dart';
import 'package:mini_project_1/routes/app_router.dart';

@RoutePage()
class RecipeDetailsScreen extends StatelessWidget {
  final Recipe recipe;
  final String heroprefix;
  const RecipeDetailsScreen({
    super.key, 
    required this.recipe, 
    this.heroprefix  ='explore',
    });

  @override
  Widget build(BuildContext context) {

    return BlocProvider(

      create: (context) => RecipeDetailsCubit(recipe: recipe),

      child: SafeArea(
        
        child: Scaffold(

          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: StartButton(recipe:recipe),
          ),

          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,


          // backgroundColor: const Color(0xFF0E1118),
          body: BlocBuilder<RecipeDetailsCubit, RecipeDetailsState>(

            builder: (context, state) {
              return state.when(

                (currentRecipe, currentTab) => CustomScrollView(
                  
                  slivers: [
                    CustomSliverAppBar(recipe: currentRecipe, heroprefix: heroprefix),
                    StaticContent(recipe: currentRecipe, selectedTab: currentTab),
                    
                    // --- THE FIX IS HERE ---
                    
                   TabContent(
                    recipe: recipe, 
                    currentTab: currentTab, 
                    currentRecipe: currentRecipe
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class StaticContent extends StatelessWidget {
  const StaticContent({
    super.key,
    required this.recipe,
    required this.selectedTab,
  });

  final Recipe recipe;
  final RecipeTab selectedTab;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        
            SvgPicture.asset('assets/images/separator.svg'),
            const SizedBox(height: 16),
            TabSelector(selectedTab: selectedTab),
          ],
        ),
      ),
    );
  }
}

class TabSelector extends StatelessWidget {
  const TabSelector({
    super.key,
    required this.selectedTab,
  });

  final RecipeTab selectedTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF181B21),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2B2E33)),
      ),
      child: Row(
        children: [
          TabButton(title: "Overview", tab: RecipeTab.overview, selectedTab: selectedTab),
          TabButton(title: "Steps", tab: RecipeTab.steps, selectedTab: selectedTab),
        ],
      ),
    );
  }
}

class TabButton extends StatelessWidget {

  const TabButton({
    super.key,
    required this.title,
    required this.tab,
    required this.selectedTab,
  });

  final String title;
  final RecipeTab tab;
  final RecipeTab selectedTab;

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedTab == tab;
    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<RecipeDetailsCubit>().toggleTab(tab),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF2B2E33) : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
      ),
    );
  }
}

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    required this.recipe,
    required this.heroprefix,
  });
  final String heroprefix;
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final Color tintColor ;
    if(recipe.mealType.name=='meat'){
      tintColor=const Color(0xFFD76261).withValues(alpha: 0.1);
    }else{
      tintColor  = const Color(0xFF4ABC96).withValues(alpha: 0.1);
    }
    return SliverAppBar(
    
      expandedHeight: MediaQuery.of(context).size.height * 0.4,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.4), 
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16,0,16,0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: '${heroprefix}recipe_name_${recipe.id}',
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(
                          recipe.name, 
                          style: Theme.of(context).textTheme.displayLarge
                          ),
                      ),
                    ),
                      const SizedBox(height: 8),
                  Hero(
                    tag: '${heroprefix}recipe_tags_${recipe.id}',
                    child: TagRowBuilder(recipe: recipe)
                    )
                  ],
                ),
              ),
              Hero(
                tag: '${heroprefix}recipe_type_${recipe.id}',
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: tintColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset('assets/images/${recipe.mealType.name.toLowerCase()}_base.svg',
                  width: 24,
                  height: 24
                  )),
              )
            ],
          ),
        )
      ),
      stretch: true,
      backgroundColor: const Color(0xFF0E1118),
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(

        stretchModes: const [StretchMode.zoomBackground],
        background:  Hero(
          tag: '${heroprefix}recipe_image_${recipe.id}',
          child: DecoratedBox(
            
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                      const Color(0xFF0E1118),
                      const Color(0xFF0E1118).withValues(alpha: 0.7),
                      Colors.transparent,
                      const Color(0xFF0E1118).withValues(alpha: 0.9),
                    ],
                    stops: const [0, 0.3, 0.6,1],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  )
              ),
              child: Image.network(recipe.imagePath, fit: BoxFit.cover),
               
              ),
        ),
      ),
      title: SafeArea(

        child: Wrap(

          children:[ 

            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              BlurredCircleIcon(icon: Icons.arrow_back, onPressed: () => context.router.pop(), iconcolor: Colors.white,),

              Hero(
                tag: '${heroprefix}recipe_favorite_${recipe.id}',
                child: Material(
                  type: MaterialType.transparency,
                  child: FavouriteIcon(recipe: recipe))
                )
              ],
            ),
          ]
        ),
      ),
      titleSpacing: 16.0,
    );
  }
}

class BlurredCircleIcon extends StatelessWidget {
  const BlurredCircleIcon({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.iconcolor,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color iconcolor;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onPressed,
      
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10,),
          
          child: Container(
          padding: const EdgeInsets.all(8),
          // backgroundColor: const Color(0xFF2B2E33).withOpacity(0.1),
          decoration: BoxDecoration(
            color: const Color(0xFF2B2E33).withValues(alpha:  0.1),
            borderRadius: BorderRadius.circular(12),
            
          ),
          child:
              Icon(icon, color: iconcolor )
          
          ),
        ),
      ));
  }
}

class FavouriteIcon extends StatelessWidget {

  const FavouriteIcon({
    super.key, 
    required this.recipe
    });

  final Recipe recipe;


  @override
  Widget build(BuildContext context) {
     final filterRecipe=  context.watch<ExploreCubit>().state.filteredRecipes.firstWhere((element) => element.id==recipe.id);
    return BlocSelector<FavouritedCubit, FavouritedState, bool>(
      selector: (state) => state.favouritedRecipes.contains(recipe),
      builder: (contet, isFavourited){
        return BlurredCircleIcon(
            onPressed: () {
             
              final favRec= recipe;
              print('the hashcode from all recipes : ${filterRecipe.hashCode}');
              print('the hashcode from the toggle bitton : ${favRec.hashCode}');
              context.read<FavouritedCubit>().toggleFavourite(recipe);
              final allfavedrec=context.read<FavouritedCubit>().state.favouritedRecipes;
              print(favRec.runtimeType==filterRecipe.runtimeType?'equal':'not equal');
              print(allfavedrec);
            },
            icon: Icons.favorite,
            iconcolor: isFavourited?Colors.red:Colors.white
          );
      }
      );
  }
}

class TabContent extends StatelessWidget {
  const TabContent({
    super.key,
    required this.recipe,
    required this.currentTab,
    required this.currentRecipe,
  });

  final Recipe recipe;
  final RecipeTab currentTab;
  final Recipe currentRecipe;

  @override
  Widget build(BuildContext context) {
  if (currentTab == RecipeTab.overview) {
    return OverViewSubScreen(recipe: recipe
        );
  } else {
    // The Steps tab already has a single parent sliver (SliverPadding).
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      sliver: SliverMainAxisGroup(
        slivers: [
          TimeLineAndStepsSlivers(recipe: recipe),
        ],
      ),
    );
  }
}
}

class StartButton extends StatelessWidget {

  const StartButton({
    super.key, 
    required this.recipe
    });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
 return GestureDetector(
    onTap: () {
      context.router.push(
        StepTimerRoute(recipe: recipe)
      );
    },
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(14)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Start ', style: GoogleFonts.nunito(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600,),),
          Icon(Icons.play_arrow_rounded , color: Colors.white,size: 24,)
          ],
        ),
      )
    );
  }
}