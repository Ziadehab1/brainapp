import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:brainflow/features/excersise_screen/breathing_excersice.dart';
import 'package:brainflow/features/excersise_screen/emotions_diary.dart';
import 'package:brainflow/features/excersise_screen/exercise_detail_screen.dart';
import 'package:brainflow/core/constants/constants.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});

  static final List<_ExerciseItem> _exercises = [
    _ExerciseItem(
      title: 'Breathing',
      duration: '1 MIN',
      description:
          'Guided box breathing to stabilize the nervous system and clear mental fog.',
      highlights: [
        'Vagus nerve stimulation',
        'Stress reduction',
        'CO2 tolerance',
      ],
      icon: Icons.air_rounded,
      thumbHeight: 155,
      gradientStart: AppColors.exerciseTealStart,
      gradientEnd: AppColors.exerciseTealEnd,
      destination: const BreathingExerciseScreen(),
    ),
    _ExerciseItem(
      title: 'Emotions Diary',
      duration: '5 - 20 MIN',
      description:
          'Track and reflect on your emotions to build self-awareness over time.',
      highlights: [
        'Emotional awareness',
        'Pattern recognition',
        'Mood tracking',
      ],
      icon: Icons.favorite_border_rounded,
      thumbHeight: 185,
      gradientStart: AppColors.exercisePinkStart,
      gradientEnd: AppColors.exercisePinkEnd,
      destination: const EmotionsDiaryScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Exercise',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Move your body, sharpen your mind',
                  style: TextStyle(color: AppColors.textDim, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              itemCount: _exercises.length,
              itemBuilder: (context, i) => _ExerciseCard(item: _exercises[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseItem {
  final String title;
  final String duration;
  final String description;
  final List<String> highlights;
  final IconData icon;
  final double thumbHeight;
  final Color gradientStart;
  final Color gradientEnd;
  final Widget? destination;

  const _ExerciseItem({
    required this.title,
    required this.duration,
    required this.description,
    required this.highlights,
    required this.icon,
    required this.thumbHeight,
    required this.gradientStart,
    required this.gradientEnd,
    this.destination,
  });
}

class _ExerciseCard extends StatelessWidget {
  final _ExerciseItem item;
  const _ExerciseCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.destination != null
          ? () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ExerciseDetailScreen(
                    data: ExerciseDetailData(
                      title: item.title,
                      tag: 'EXERCISE',
                      duration: item.duration,
                      description: item.description,
                      highlights: item.highlights,
                      gradientStart: item.gradientStart,
                      gradientEnd: item.gradientEnd,
                      destination: item.destination!,
                    ),
                  ),
                ),
              )
          : null,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(18),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: item.thumbHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [item.gradientStart, item.gradientEnd],
                    ),
                  ),
                ),
                Container(
                  height: item.thumbHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.shadowVeryLight, AppColors.shadowStrong],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.overlayMedium,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item.duration,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.textGhost,
                        border: Border.all(
                          color: AppColors.textDim,
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.air_rounded,
                        color: AppColors.textPrimary,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.description,
                    style: TextStyle(
                      color: AppColors.textDim,
                      fontSize: 11,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
