import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project_1/UI/widgets/random_picker.dart';
import 'package:mini_project_1/UI/widgets/recipe_card.dart';
import 'package:mini_project_1/UI/widgets/recipe_grid_card.dart';
import 'package:mini_project_1/UI/widgets/searchbarandviews.dart';
import 'package:mini_project_1/UI/widgets/today_challenge_card.dart';
import 'package:mini_project_1/blocs/explore/explore_cubit.dart';
import 'package:mini_project_1/blocs/explore/explore_state.dart';
import 'package:mini_project_1/blocs/user/user_cubit.dart';
import 'package:mini_project_1/cache/cache_service.dart';
import 'package:mini_project_1/data/models/models.dart';


@RoutePage()
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      body: BlocBuilder<ExploreCubit, ExploreState>(
        buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text(message)),
            loaded: (_, __, ___, ____, _____) {
              final username = context.watch<UserCubit>().state.user.name;
              
              // THE CORE CHANGE: We now use CustomScrollView instead of Column.
              return SafeArea(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 800,
                    ),
                    child: CustomScrollView(
                      slivers: [
                        // --- SLIVERS FOR STATIC-LIKE CONTENT ---
                        // We wrap single "box" widgets in SliverToBoxAdapter to use them in a sliver list.
                        
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: GreetingSentence(
                              greeting: _getTimeForGreeting, 
                              username: username
                              ),
                          ),
                        ),
                    
                        // Selector for Today's Challenge Card
                        SliverToBoxAdapter(
                          child: BlocSelector<ExploreCubit, ExploreState, Recipe?>(
                            selector: (state) => state.todaysChallenge,
                            builder: (context, recipe) {
                           
                              return recipe != null
                                  ? TodayChallengeCard(recipe: recipe)
                                  : const SizedBox.shrink();
                            },
                          ),
                        ),
                    
                        const SliverToBoxAdapter(child: RandomPicker()),
                        const  SliverToBoxAdapter(
                          child: LabelSeparator(label: 'Recipes')
                          ),
                    
                        // Selector for the Search and Filter Bar
                       const SliverToBoxAdapter(
                          child:SearchAndFilterBar()
                        ),
                    
                        // --- THE HIGHLY-PERFORMANT SLIVER LIST ---
                        // This selector now returns a SliverList or SliverGrid directly.
                        BlocBuilder<ExploreCubit, ExploreState>(
                          buildWhen: (previous, current) {
                            return previous.filteredRecipes != current.filteredRecipes
                            || previous.theViewType!=current.theViewType;
                          },
                          builder: (context,state){
                            return state.theViewType==ExploreViewType.grid?
                            GridSliverRecipes(allRecipes: state.filteredRecipes):
                            ListSliverRecipes(allRecipes: state.filteredRecipes) ;
                          }
                          )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String get _getTimeForGreeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Morning';
    if (hour < 17) return 'Afternoon';
    return 'Evening';
  }
}

class ListSliverRecipes extends StatelessWidget {
  const ListSliverRecipes({
    super.key,
    required this.allRecipes,
  });
  final List<Recipe> allRecipes;

  @override
  Widget build(BuildContext context) {
    if (allRecipes.isEmpty) {
      return const SliverFillRemaining( // A sliver that fills the remaining space
        child: Center(child: Text("No recipes found.",)),
      );
    }
    // SliverList is the sliver equivalent of ListView.builder and is LAZY.
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final recipe = allRecipes[index];
          return RecipeCard(recipe: recipe);
        },
        childCount: allRecipes.length,
      ),
    );
  }
}

// class GreetingSentence extends StatelessWidget {
//   const GreetingSentence({
//     super.key,
//     required this.greeting,
//     required this.username,
//   });

//   final String greeting;
//   final String username;

//   @override
//   Widget build(BuildContext context) {
//   // Get the styles from the theme once to make the code cleaner
//   final headlineStyle = Theme.of(context).textTheme.headlineSmall;
//   final primaryColor = Theme.of(context).colorScheme.primary;

//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center, // Better vertical alignment
//         children: [
//           // --- THE FIX: Replace the inner Row with RichText ---
//           // RichText is perfect for a single line of text with multiple styles.
//           // It handles wrapping and overflow correctly as one element.
//           Expanded(
//             child: RichText(
//               text: TextSpan(
//                 // Default style for the entire sentence
//                 style: headlineStyle?.copyWith(fontWeight: FontWeight.normal),
//                 children: <TextSpan>[
//                   TextSpan(text: 'Good $greeting, '),
//                   TextSpan(
//                     text: '$username!',
//                     // Specific style for the username
//                     style: headlineStyle?.copyWith(color: primaryColor),
//                   ),
//                 ],
//               ),
//               maxLines: 2, // Allow it to wrap to a second line if needed
//               overflow: TextOverflow.ellipsis, // Add ellipsis if it's still too long
//             ),
//           ),
//           // --- END OF FIX ---

//         const SizedBox(width: 8), // Add some spacing for safety
//         const LevelDropDown()
//         ],
//       ),
//       Text(
//         'Ready to cook something amazing?',
//         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//               fontWeight: FontWeight.normal,
//               color: const Color(0xFF888481),
//             ),
//       ),
//     ],
//   );
// }
// }

class LevelDropDown extends StatelessWidget {
  const LevelDropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentUserLevel = context.watch<UserCubit>().state.user.level;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF181B21),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: const Color(0xFF2B2E33)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<UserCookingLevel>(
          isDense: true,
          iconSize: 16,
          value: currentUserLevel,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
          dropdownColor: const Color(0xFF181B21),
          style: GoogleFonts.nunito(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
          onChanged: (UserCookingLevel? newLevel) {
            if (newLevel != null) {
              context.read<UserCubit>().changelevel(newLevel);
              CacheService().setUserLevel(newLevel);
            }
          },
          selectedItemBuilder: (BuildContext context) {
            return UserCookingLevel.values.map((level) {
              return Row(children: [
                GetIconForLevel(level: level),
                const SizedBox(width: 2),
                Text(level.name[0] + level.name.substring(1), style: const TextStyle(color: Colors.white, fontSize: 16)),
              ]);
            }).toList();
          },
          items: UserCookingLevel.values.map((level) {
            return DropdownMenuItem<UserCookingLevel>(
              value: level,
              child: Row(children: [
                GetIconForLevel(level: level),
                const SizedBox(width: 8),
                Text(level.name[0].toUpperCase() + level.name.substring(1), style: const TextStyle(color: Colors.white, fontSize: 16)),
              ]),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class GetIconForLevel extends StatelessWidget {
  const GetIconForLevel({
    super.key,
    required this.level,
  });

  final UserCookingLevel level;

  @override
  Widget build(BuildContext context) {
    switch (level) {
      case UserCookingLevel.chef: return const Icon(Icons.whatshot_outlined, color: Colors.orange, size: 14);
      case UserCookingLevel.intermediate: return const Icon(Icons.local_dining, color: Colors.lightGreenAccent, size: 14);
      case UserCookingLevel.beginner: return const Icon(Icons.egg_alt_outlined, color: Colors.lightBlueAccent, size: 14);
    }
  }
}

class LabelSeparator extends StatelessWidget {
  const LabelSeparator({
    super.key,
    required this.label,
  });
  final String label;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}

class GridSliverRecipes extends StatelessWidget {
   const GridSliverRecipes({
    super.key,
    required this.allRecipes,
    });

   final List<Recipe> allRecipes;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 310,
        crossAxisSpacing:0,
        mainAxisSpacing: 4,
        mainAxisExtent: 220
        ), 
      itemCount: allRecipes.length,
      itemBuilder: (BuildContext context, int index) { 
        return RecipeGridCard(recipe: allRecipes[index]);
      },
   );
  }
}

// In ExploreScreen.dart

class GreetingSentence extends StatefulWidget { // <-- CHANGED
  const GreetingSentence({
    super.key,
    required this.greeting,
    required this.username,
  });

  final String greeting;
  final String username;

  @override
  State<GreetingSentence> createState() => _GreetingSentenceState(); // <-- ADDED
}

class _GreetingSentenceState extends State<GreetingSentence> { // <-- ADDED
  late TapGestureRecognizer _tapRecognizer; // To make the name tappable

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        // When the name is tapped, we call the function to show our dialog
        _showEditNameDialog(context, widget.username);
      };
  }

  @override
  void dispose() {
    // It's crucial to dispose of the recognizer to prevent memory leaks
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final headlineStyle = Theme.of(context).textTheme.headlineSmall;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: headlineStyle?.copyWith(fontWeight: FontWeight.normal),
                  children: <TextSpan>[
                    TextSpan(text: 'Good ${widget.greeting}, '), // <-- Use widget.greeting
                    TextSpan(
                      text: '${widget.username}!', // <-- Use widget.username
                      style: headlineStyle?.copyWith(
                        color: primaryColor,
                        decoration: TextDecoration.underline, // Add underline to show it's clickable
                      ),
                      recognizer: _tapRecognizer, // <-- THIS MAKES THE TEXT TAPPABLE
                    ),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            const LevelDropDown()
          ],
        ),
        Text(
          'Ready to cook something amazing?',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.normal,
                color: const Color(0xFF888481),
              ),
        ),
      ],
    );
  }
}

// In ExploreScreen.dart, but outside any class

// A private helper widget to manage the TextField's state inside the dialog
class _EditNameDialogContent extends StatefulWidget {
  final String currentName;
  const _EditNameDialogContent({required this.currentName});

  @override
  State<_EditNameDialogContent> createState() => _EditNameDialogContentState();
}

class _EditNameDialogContentState extends State<_EditNameDialogContent> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change Your Name'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Enter your new name'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Just close the dialog
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        FilledButton( // Use a more prominent button for the confirm action
          onPressed: () {
            // If the name isn't empty, update it
            if (_controller.text.isNotEmpty) {
              context.read<UserCubit>().changename(_controller.text);
              CacheService().setUserName(_controller.text);
            }
            // Close the dialog
            Navigator.of(context).pop();
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}

// This is the function we call to show the dialog
void _showEditNameDialog(BuildContext context, String currentName) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      // We use our new stateful widget here to correctly manage the controller
      return _EditNameDialogContent(currentName: currentName);
    },
  );
}