import 'package:mini_project_1/data/models/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {

  static const String _OnBoardingCompleteKey = 'onboarding_complete';
  static const String _userNameKey = 'user_name';
  static const String _userLevelKey = 'user_level';
  
  Future<void> setOnboardingComplete(bool isComplete) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_OnBoardingCompleteKey, isComplete);
  }


  Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_OnBoardingCompleteKey) ?? false;
  }


  Future<void> setUserName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, userName);
  }


  Future<String?> getUserName () async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey) ;
  }

  Future<void> setUserLevel(UserCookingLevel userLevel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userLevelKey, userLevel.name);
  }

  Future<UserCookingLevel?> getUserLevel() async {
    final prefs = await SharedPreferences.getInstance();
    final levelName = prefs.getString(_userLevelKey);
    if (levelName != null) {
      return UserCookingLevel.values.firstWhere(
        (level) => level.name == levelName,
        orElse: () => UserCookingLevel.beginner,
      );
    }
    return null;
  }


}