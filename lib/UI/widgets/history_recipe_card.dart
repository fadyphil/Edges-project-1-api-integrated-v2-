// lib/ui/widgets/history_card.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_project_1/data/models/recipe_challenge_model.dart';

String _formatDuration(Duration duration) {
  if (duration.isNegative) {
    return "-${_formatDuration(duration.abs())}";
  }
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  if (duration.inHours > 0) {
    return "${duration.inHours}:$minutes:$seconds";
  }
  return "$minutes:$seconds";
}

class HistoryCard extends StatelessWidget {
  final RecipeChallenge challenge;
  const HistoryCard({super.key, required this.challenge});

  @override
  Widget build(BuildContext context) {
    final timeDifference = challenge.timeTaken - challenge.expectedTime;
    final wasFaster = timeDifference.inSeconds <= 0;

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Image with Performance Chip ---
          Stack(
            children: [
              Image.network(
                challenge.recipe.imagePath,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              // Gradient overlay for better text readability
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                    ),
                  ),
                ),
              ),
              // The distinct performance "chip"
              Positioned(
                top: 12,
                right: 12,
                child: _PerformanceChip(
                  timeDifference: timeDifference,
                  wasFaster: wasFaster,
                ),
              ),
            ],
          ),
          // --- Text Content ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  challenge.recipe.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                _InfoRow(
                  icon: Icons.timer_outlined,
                  label: 'Your Time',
                  value: _formatDuration(challenge.timeTaken),
                ),
                const SizedBox(height: 8),
                _InfoRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'Completed',
                  value: DateFormat('MMMM d, yyyy').format(challenge.dateCompleted),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// A small private widget for the performance chip
class _PerformanceChip extends StatelessWidget {
  final Duration timeDifference;
  final bool wasFaster;

  const _PerformanceChip({required this.timeDifference, required this.wasFaster});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (wasFaster ? Colors.green : Colors.orange).withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(
                wasFaster ? Icons.trending_up : Icons.trending_down,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '${_formatDuration(timeDifference.abs())} ${wasFaster ? "Faster" : "Slower"}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// A small private widget for the info rows
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey.shade400, size: 16),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade400),
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}