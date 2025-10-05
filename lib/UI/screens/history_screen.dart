// lib/ui/screens/history_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project_1/UI/widgets/history_recipe_card.dart';
import 'package:mini_project_1/blocs/historyy/history_cubit.dart';
import 'package:mini_project_1/blocs/historyy/history_state.dart';

@RoutePage()
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History',
        style: TextStyle(
          color: Colors.white,
        ), ),
        centerTitle: true,
      ),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state.challenges.isEmpty) {
            // Show a nice message if history is empty
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history_toggle_off, size: 60, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No challenges completed yet.',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Finish a recipe to see it here!',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          // If there are challenges, display them in a list
          return ListView.builder(
            itemCount: state.challenges.length,
            itemBuilder: (context, index) {
              final challenge = state.challenges[index];
              return HistoryCard(challenge: challenge);
            },
          );
        },
      ),
    );
  }
}