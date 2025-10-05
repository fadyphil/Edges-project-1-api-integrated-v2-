// lib/ui/screens/splash_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_1/cache/cache_service.dart';
import 'package:mini_project_1/routes/app_router.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _decideNextRoute();
  }

  Future<void> _decideNextRoute() async {
    // We need an instance of our service to do the check
    final cacheService = CacheService();
    final onboardingComplete = await cacheService.isOnboardingComplete();

    // Ensure the widget is still mounted before navigating
    if (mounted) {
      if (onboardingComplete) {
        // If complete, replace the splash screen with the main app screen
        AutoRouter.of(context).replace(const MainRoute());
      } else {
        // Otherwise, replace it with the onboarding screen
        AutoRouter.of(context).replace(const OnboardingRoute());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // While we're deciding, just show a loading spinner
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}