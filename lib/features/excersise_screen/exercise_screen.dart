import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:brainflow/features/excersise_screen/breathing_excersice.dart';
import 'package:brainflow/features/excersise_screen/emotions_diary.dart';
import 'package:brainflow/features/excersise_screen/exercise_detail_screen.dart';
import 'package:brainflow/features/excersise_screen/todo_list.dart';
import 'package:brainflow/core/constants/constants.dart';
import 'package:brainflow/core/l10n/app_localizations.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final List<_ExerciseItem> items = [
      _ExerciseItem(
        title: l.breathingTitle,
        duration: l.dur1Min,
        description: l.breathingDesc,
        highlights: [
          l.breathingH1,
          l.breathingH2,
          l.breathingH3,
        ],
        icon: Icons.air_rounded,
        thumbHeight: 155,
        gradientStart: AppColors.exerciseTealStart,
        gradientEnd: AppColors.exerciseTealEnd,
        destination: const BreathingExerciseScreen(),
      ),
      _ExerciseItem(
        title: l.emotionsDiaryTitle,
        duration: l.dur5to20Min,
        description: l.emotionsDiaryDesc,
        highlights: [
          l.emotionsH1,
          l.emotionsH2,
          l.emotionsH3,
        ],
        icon: Icons.favorite_border_rounded,
        thumbHeight: 185,
        gradientStart: AppColors.exercisePinkStart,
        gradientEnd: AppColors.exercisePinkEnd,
        destination: const EmotionsDiaryScreen(),
      ),
      _ExerciseItem(
        title: l.todosTitle,
        duration: l.tasksDuration,
        description: l.todosDesc,
        highlights: [l.todosH1, l.todosH2, l.todosH3],
        icon: Icons.checklist_rounded,
        thumbHeight: 140,
        gradientStart: AppColors.exercisePurpleStart,
        gradientEnd: AppColors.exercisePurpleEnd,
        destination: const TodoListScreen(),
      ),
    ];

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.exercise,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l.exerciseSubtitle,
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
              itemCount: items.length,
              itemBuilder: (context, i) => _ExerciseCard(item: items[i]),
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
  final Widget destination;

  const _ExerciseItem({
    required this.title,
    required this.duration,
    required this.description,
    required this.highlights,
    required this.icon,
    required this.thumbHeight,
    required this.gradientStart,
    required this.gradientEnd,
    required this.destination,
  });
}

class _ExerciseCard extends StatelessWidget {
  final _ExerciseItem item;
  const _ExerciseCard({required this.item});

  void _navigate(BuildContext context) {
    final l = context.l10n;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExerciseDetailScreen(
          data: ExerciseDetailData(
            title: item.title,
            tag: l.exercise,
            duration: item.duration,
            description: item.description,
            highlights: item.highlights,
            gradientStart: item.gradientStart,
            gradientEnd: item.gradientEnd,
            destination: item.destination,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigate(context),
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
                      colors: [
                        AppColors.shadowVeryLight,
                        AppColors.shadowStrong,
                      ],
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
                      child: Icon(
                        item.icon,
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
