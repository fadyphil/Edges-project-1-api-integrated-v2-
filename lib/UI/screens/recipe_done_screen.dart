// lib/UI/screens/recipe_done_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project_1/blocs/historyy/history_cubit.dart';
import 'package:mini_project_1/blocs/user/user_cubit.dart';
import 'package:mini_project_1/data/models/enums.dart';
import 'package:mini_project_1/data/models/recipe_challenge_model.dart';
import 'package:mini_project_1/data/models/recipe_model.dart';
import 'package:mini_project_1/routes/app_router.dart';

@RoutePage()
class RecipeDoneScreen extends StatefulWidget {
  final Recipe recipe;
  final double timeTaken; // in seconds

  const RecipeDoneScreen({
    super.key,
    required this.recipe,
    required this.timeTaken,
  });

  @override
  State<RecipeDoneScreen> createState() => _RecipeDoneScreenState();
}

class _RecipeDoneScreenState extends State<RecipeDoneScreen> {
  // We calculate all the necessary analytics data once and store it.
  late Duration _actualTime;
  late Map<UserCookingLevel, Duration> _expectedTimes;
  late Duration _userExpectedTime;
  late Duration _timeDifference;
  late String _performanceMessage;

  @override
  void initState() {
    super.initState();
    _calculateAnalytics();
  }

  /// Calculates all performance metrics based on the recipe's base time
  /// and the user's cooking level.
  void _calculateAnalytics() {
    final userLevel = context.read<UserCubit>().state.user.level;
    _actualTime = Duration(seconds: widget.timeTaken.toInt());

    // Calculate expected time for each cooking level using the global timeFactor map
    _expectedTimes = {
      for (var level in UserCookingLevel.values)
        level: Duration(
          seconds: (widget.recipe.totalBaseTimeInSeconds * timeFactor[level]!)
              .round(),
        )
    };

    _userExpectedTime = _expectedTimes[userLevel]!;
    _timeDifference = _actualTime - _userExpectedTime;

    // Create a dynamic performance message
    if (_timeDifference.inSeconds <= -60) {
      _performanceMessage =
          "Chef-level speed! You were ${_formatDuration(_timeDifference.abs())} faster than your expected time.";
    } else if (_timeDifference.inSeconds <= 0) {
      _performanceMessage =
          "Incredible pace! You beat your expected time by ${_formatDuration(_timeDifference.abs())}.";
    } else {
      _performanceMessage =
          "Great job finishing the recipe! Practice is the key to improving your speed.";
    }
  }

  /// Formats a Duration into a "mm:ss" string.
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  void _saveChallengeToHistory() {
  final challenge = RecipeChallenge(
    recipe: widget.recipe,
    timeTaken: _actualTime,
    expectedTime: _userExpectedTime,
    dateCompleted: DateTime.now(), // Use the current date and time
  );
  context.read<HistoryCubit>().addChallengeToHistory(challenge);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cooking Summary',  style: TextStyle(color: Colors.white),),
        centerTitle: true,
        automaticallyImplyLeading: false, // Remove back arrow
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSummaryHeader(),
            const SizedBox(height: 24),
            _buildPerformanceComparisonCard(),
            const SizedBox(height: 32),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryHeader() {
    return Column(
      children: [
        Text(
          widget.recipe.name,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Your Time',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.grey.shade400),
        ),
        Text(
          _formatDuration(_actualTime),
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            _performanceMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceComparisonCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF181B21),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2B2E33)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Performance Breakdown",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          // Dynamically generate a performance bar for each cooking level
          ...UserCookingLevel.values.map((level) => _buildPerformanceBar(
                level: level,
                expected: _expectedTimes[level]!,
                actual: _actualTime,
              )),
        ],
      ),
    );
  }

  Widget _buildPerformanceBar({
    required UserCookingLevel level,
    required Duration expected,
    required Duration actual,
  }) {
    final isCurrentUserLevel = context.read<UserCubit>().state.user.level == level;
    final isFaster = actual <= expected;
    // Ensure ratio is never 0 to avoid division by zero if a step has 0 time.
    final ratio = expected.inSeconds > 0 ? actual.inSeconds / expected.inSeconds : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // Capitalize the enum name
                level.name[0].toUpperCase() + level.name.substring(1),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight:
                          isCurrentUserLevel ? FontWeight.bold : FontWeight.normal,
                      color: isCurrentUserLevel
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white,
                    ),
              ),
              Text(
                '${_formatDuration(actual)} / ${_formatDuration(expected)}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey.shade400),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                // Expected time bar (background)
                Container(
                  height: 12,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B2E33),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                // Actual time bar (foreground)
                Container(
                  height: 12,
                  // Clamp the width to prevent overflow if the user is much slower
                  width: (constraints.maxWidth * ratio).clamp(0, constraints.maxWidth),
                  decoration: BoxDecoration(
                    color: isFaster
                        ? Colors.green.shade400
                        : Colors.orange.shade400,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: () {
            // This navigation flow clears the cooking screens and lands the user on their History page.
            _saveChallengeToHistory();
            context.router.popUntilRoot();
            context.router.navigate(const HistoryRoute());
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("View History"),
              SizedBox(width: 8),
              Icon(Icons.history, size: 20),
            ],
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: () {
            // Simply pops this summary screen to go back to the recipe details.
            context.router.pop();
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Cook Again"),
              SizedBox(width: 8),
              Icon(Icons.replay_outlined, size: 20),
            ],
          ),
        ),
      ],
    );
  }
 
}