import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:brainapp/features/games_screen/game_detail_screen.dart';
import 'package:brainapp/features/games_screen/follow_dot_screen.dart';
import 'package:brainapp/features/games_screen/flipping_card_screen.dart';
import 'package:brainapp/core/constants/constants.dart';

final List<GameData> allGames = [
  GameData(
    title: 'Follow the Dot',
    tag: 'FOCUS',
    duration: '5 - 20 M',
    thumbHeight: 170,
    description:
        'Enhance your sustained attention by tracking a rhythmic moving point through a shifting landscape.',
    highlights: [
      'Saccadic eye training',
      'Peripheral awareness',
      'Patience building',
    ],
    gradientStart: AppColors.gameBrownStart,
    gradientEnd: AppColors.gameBrownEnd,
    destination: const FollowDotScreen(),
  ),
  GameData(
    title: 'Flipping Card',
    tag: 'MEMORY',
    duration: '5 - 10 M',
    thumbHeight: 125,
    description:
        'A memory-matching experience designed to strengthen short-term recall and visual processing speed.',
    highlights: ['Pattern memorization', 'Recall accuracy', 'Cognitive speed'],
    gradientStart: AppColors.gameForestStart,
    gradientEnd: AppColors.gameForestEnd,
    destination: const FlippingCardScreen(),
  ),
];

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

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
                  'Cognitive Games',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Train your brain while having fun',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              itemCount: allGames.length,
              itemBuilder: (context, i) => _GameCard(data: allGames[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _GameCard extends StatelessWidget {
  final GameData data;
  const _GameCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => GameDetailScreen(data: data)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image-style banner
            Stack(
              children: [
                Container(
                  height: data.thumbHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [data.gradientStart, data.gradientEnd],
                    ),
                  ),
                ),
                // Subtle vignette overlay
                Container(
                  height: data.thumbHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.05),
                        Colors.black.withValues(alpha: 0.35),
                      ],
                    ),
                  ),
                ),
                // Tag badge
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      data.tag,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                // Center gamepad icon
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.15),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.videogame_asset_outlined,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Info
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.bolt_rounded,
                        size: 12,
                        color: Colors.white.withValues(alpha: 0.4),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        data.duration,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
