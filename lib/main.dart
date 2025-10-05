import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project_1/blocs/explore/explore_cubit.dart';
import 'package:mini_project_1/blocs/favourited/favourited_cubit.dart';
import 'package:mini_project_1/blocs/historyy/history_cubit.dart';
import 'package:mini_project_1/blocs/user/user_cubit.dart';
import 'package:mini_project_1/cache/cache_service.dart';
import 'package:mini_project_1/data/api/api_service.dart';
import 'package:mini_project_1/data/repos/api_recipe_repo.dart';
import 'package:mini_project_1/routes/app_router.dart';
import 'package:mini_project_1/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  final _cacheService = CacheService();
  final _apiService = ApiService();

   MyApp({
    super.key,
    });

  final router = AppRouter();


  @override
  Widget build(BuildContext context) {
    final recipeRepository = ApiRecipeRepository(apiService: _apiService);
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => UserCubit(cacheService: _cacheService)),
      BlocProvider(create: (_) => FavouritedCubit()),
      BlocProvider(create: (_) => ExploreCubit(recipeRepository: recipeRepository)..loadRecipes()),
      BlocProvider(create: (_)=>HistoryCubit())
      
    ], 
    child: MaterialApp.router(
      title: 'Recipe App',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      routerConfig: router.config(),
    )
    );
  }
}


