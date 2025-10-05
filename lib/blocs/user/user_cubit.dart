import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project_1/blocs/user/user_state.dart';
import 'package:mini_project_1/cache/cache_service.dart';
import 'package:mini_project_1/data/models/enums.dart';

import '../../data/models/user_model.dart';

class UserCubit extends Cubit<UserState>{
  final CacheService _cacheService ;
 
  UserCubit({required CacheService cacheService})
      : _cacheService = cacheService,
        super(
          const UserState(user: User(name: 'Guest', level: UserCookingLevel.beginner)),
        ) {
    loadUser();
  }

  void loadUser() async {
    final name = await _cacheService.getUserName();
    final level = await _cacheService.getUserLevel();
    emit(
      state.copyWith(
        user: state.user.copyWith(
          name: name ?? state.user.name,
          level: level ?? state.user.level,
        ),
      )
    );
  }




  void changelevel(UserCookingLevel newlevel){
    emit(state.copyWith(user: state.user.copyWith(level: newlevel)));
  }
  double getUsersFactor ()=>timeFactor[state.user.level]!;

  void changename (String newname){
    emit(state.copyWith(user: state.user.copyWith(name: newname)));
    }

}