// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [ExploreScreen]
class ExploreRoute extends PageRouteInfo<void> {
  const ExploreRoute({List<PageRouteInfo>? children})
    : super(ExploreRoute.name, initialChildren: children);

  static const String name = 'ExploreRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ExploreScreen();
    },
  );
}

/// generated route for
/// [FavouritesScreen]
class FavouritesRoute extends PageRouteInfo<void> {
  const FavouritesRoute({List<PageRouteInfo>? children})
    : super(FavouritesRoute.name, initialChildren: children);

  static const String name = 'FavouritesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavouritesScreen();
    },
  );
}

/// generated route for
/// [HistoryScreen]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
    : super(HistoryRoute.name, initialChildren: children);

  static const String name = 'HistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HistoryScreen();
    },
  );
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
}

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnboardingScreen();
    },
  );
}

/// generated route for
/// [RecipeDetailsScreen]
class RecipeDetailsRoute extends PageRouteInfo<RecipeDetailsRouteArgs> {
  RecipeDetailsRoute({
    Key? key,
    required Recipe recipe,
    String heroprefix = 'explore',
    List<PageRouteInfo>? children,
  }) : super(
         RecipeDetailsRoute.name,
         args: RecipeDetailsRouteArgs(
           key: key,
           recipe: recipe,
           heroprefix: heroprefix,
         ),
         initialChildren: children,
       );

  static const String name = 'RecipeDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RecipeDetailsRouteArgs>();
      return RecipeDetailsScreen(
        key: args.key,
        recipe: args.recipe,
        heroprefix: args.heroprefix,
      );
    },
  );
}

class RecipeDetailsRouteArgs {
  const RecipeDetailsRouteArgs({
    this.key,
    required this.recipe,
    this.heroprefix = 'explore',
  });

  final Key? key;

  final Recipe recipe;

  final String heroprefix;

  @override
  String toString() {
    return 'RecipeDetailsRouteArgs{key: $key, recipe: $recipe, heroprefix: $heroprefix}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RecipeDetailsRouteArgs) return false;
    return key == other.key &&
        recipe == other.recipe &&
        heroprefix == other.heroprefix;
  }

  @override
  int get hashCode => key.hashCode ^ recipe.hashCode ^ heroprefix.hashCode;
}

/// generated route for
/// [RecipeDoneScreen]
class RecipeDoneRoute extends PageRouteInfo<RecipeDoneRouteArgs> {
  RecipeDoneRoute({
    Key? key,
    required Recipe recipe,
    required double timeTaken,
    List<PageRouteInfo>? children,
  }) : super(
         RecipeDoneRoute.name,
         args: RecipeDoneRouteArgs(
           key: key,
           recipe: recipe,
           timeTaken: timeTaken,
         ),
         initialChildren: children,
       );

  static const String name = 'RecipeDoneRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RecipeDoneRouteArgs>();
      return RecipeDoneScreen(
        key: args.key,
        recipe: args.recipe,
        timeTaken: args.timeTaken,
      );
    },
  );
}

class RecipeDoneRouteArgs {
  const RecipeDoneRouteArgs({
    this.key,
    required this.recipe,
    required this.timeTaken,
  });

  final Key? key;

  final Recipe recipe;

  final double timeTaken;

  @override
  String toString() {
    return 'RecipeDoneRouteArgs{key: $key, recipe: $recipe, timeTaken: $timeTaken}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RecipeDoneRouteArgs) return false;
    return key == other.key &&
        recipe == other.recipe &&
        timeTaken == other.timeTaken;
  }

  @override
  int get hashCode => key.hashCode ^ recipe.hashCode ^ timeTaken.hashCode;
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen();
    },
  );
}

/// generated route for
/// [StepTimerScreen]
class StepTimerRoute extends PageRouteInfo<StepTimerRouteArgs> {
  StepTimerRoute({
    Key? key,
    required Recipe recipe,
    List<PageRouteInfo>? children,
  }) : super(
         StepTimerRoute.name,
         args: StepTimerRouteArgs(key: key, recipe: recipe),
         initialChildren: children,
       );

  static const String name = 'StepTimerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StepTimerRouteArgs>();
      return StepTimerScreen(key: args.key, recipe: args.recipe);
    },
  );
}

class StepTimerRouteArgs {
  const StepTimerRouteArgs({this.key, required this.recipe});

  final Key? key;

  final Recipe recipe;

  @override
  String toString() {
    return 'StepTimerRouteArgs{key: $key, recipe: $recipe}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! StepTimerRouteArgs) return false;
    return key == other.key && recipe == other.recipe;
  }

  @override
  int get hashCode => key.hashCode ^ recipe.hashCode;
}
