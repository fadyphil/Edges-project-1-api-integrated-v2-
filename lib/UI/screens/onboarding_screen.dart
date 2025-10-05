import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project_1/UI/sub_screens/onboarding_page1.dart';
import 'package:mini_project_1/UI/sub_screens/onboarding_page3.dart';
import 'package:mini_project_1/UI/sub_screens/onboording_page2.dart';
import 'package:mini_project_1/blocs/user/user_cubit.dart';
import 'package:mini_project_1/cache/cache_service.dart';
import 'package:mini_project_1/data/models/enums.dart';
import 'package:mini_project_1/routes/app_router.dart'; 



@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // State for the third page
  UserCookingLevel? _selectedLevel;
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _onLevelSelected(UserCookingLevel level) {
    setState(() {
      _selectedLevel = level;
    });
  }
  
  void _onButtonPressed() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }  else {
      // --- VALIDATION ---
      // Ensure a name is entered and a level is selected.
      if (_nameController.text.trim().isEmpty  || _selectedLevel == null) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text('Please enter your name and select a cooking level.'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
        return; // Stop the function if validation fails
      }

      // --- HANDLE SUBMISSION ---
      final name = _nameController.text.trim();
      final level = _selectedLevel;

      // Now this will work because the cubit is provided in main.dart
      context.read<UserCubit>().changename(name);
      CacheService().setUserName(name);
      context.read<UserCubit>().changelevel(level!);
      CacheService().setUserLevel(level);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
          'Enjoy your cooking journey, $name!'
        ),
        backgroundColor:  Colors.green,
        )
      );

      CacheService().setOnboardingComplete(true);

      context.router.replace(const MainRoute());
      

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // This container creates the background pattern
        decoration: const BoxDecoration(
          image: DecorationImage(
            
            opacity: 0.02,
            image: AssetImage('assets/images/background.png'),
            repeat: ImageRepeat.repeat,

          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    const OnboardingPage1(),
                    const OnboardingPage2(),
                    // Pass state and callbacks to the third page
                    OnboardingPage3(
                      nameController: _nameController,
                      selectedLevel: _selectedLevel,
                      onLevelSelected: _onLevelSelected,
                    ),
                  ],
                ),
              ),
              PageIndicator(currentPage: _currentPage,),
              BottomButton(
                currentPage: _currentPage,
                onPressed: _onButtonPressed,),
            ],
          ),
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required int currentPage,
  }) : _currentPage = currentPage;

  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 8.0,
          width: _currentPage == index ? 24.0 : 8.0,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required int currentPage, 
    this.onPressed,
  }) : _currentPage = currentPage;

  final int _currentPage;
  final VoidCallback? onPressed;


  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == 2;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: 500),
        child: ElevatedButton(
          onPressed: onPressed,
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                padding: WidgetStateProperty.all(const EdgeInsets.all(16)),
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(isLastPage ? "Let's Go!" : "Tell Me More"),
              const SizedBox(width: 8),
              Icon(isLastPage ? Icons.rocket_launch_outlined : Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }
}