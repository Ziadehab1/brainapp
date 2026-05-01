import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:brainflow/features/excersise_screen/exercise_screen.dart';
import 'package:brainflow/features/games_screen/games_screen.dart';
import 'package:brainflow/features/tutorials_screen/tutorials.dart';
import 'package:brainflow/features/more_screen/more_screen.dart';
import 'package:brainflow/core/constants/constants.dart';
import 'package:brainflow/core/l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  final bool showFocusRatingAfterDelay;

  const HomeScreen({super.key, this.showFocusRatingAfterDelay = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  Timer? _ratingTimer;
  bool _ratingShown = false;

  final List<Widget> _pages = [
    const ExerciseScreen(),
    const GamesScreen(),
    const TutorialsScreen(),
    const MoreScreen(),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.showFocusRatingAfterDelay) {
      _ratingTimer = Timer(
        const Duration(minutes: 1),
        _showFocusRatingSheet,
      );
    }
  }

  @override
  void dispose() {
    _ratingTimer?.cancel();
    super.dispose();
  }

  void _showFocusRatingSheet() {
    if (!mounted || _ratingShown) return;
    _ratingShown = true;

    final l = context.l10n;
    double rating = 5;
    final double itemSize =
        (MediaQuery.of(context).size.width - 64) / 10;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setSheetState) => Container(
          padding: EdgeInsets.fromLTRB(
            28, 20, 28,
            MediaQuery.of(ctx).padding.bottom + 28,
          ),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textFaint.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),

              // Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primaryDeep.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.psychology_outlined,
                  color: AppColors.primaryLight,
                  size: 28,
                ),
              ),
              const SizedBox(height: 14),

              // Title
              Text(
                l.rateFocusTitle,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                l.rateFocusSub,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textFaint,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),

              // Scale labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '1',
                    style: TextStyle(
                      color: AppColors.textDim,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '10',
                    style: TextStyle(
                      color: AppColors.textDim,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // 1–10 rating bar
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                maxRating: 10,
                itemCount: 10,
                allowHalfRating: false,
                itemSize: itemSize,
                itemPadding: EdgeInsets.zero,
                itemBuilder: (context, _) => const Icon(
                  Icons.star_rounded,
                  color: AppColors.primary,
                ),
                onRatingUpdate: (val) =>
                    setSheetState(() => rating = val),
              ),
              const SizedBox(height: 8),

              // Live value indicator
              Text(
                '${rating.toInt()} / 10',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 24),

              // Submit button
              GestureDetector(
                onTap: () => Navigator.pop(ctx),
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 16,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      l.submitRating,
                      style: const TextStyle(
                        color: AppColors.surfaceDeep,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(child: _pages[_selectedIndex]),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _BottomNav(
              selectedIndex: _selectedIndex,
              onTap: (i) => setState(() => _selectedIndex = i),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowMedium,
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.show_chart_rounded,
                label: l.navExercise,
                isSelected: selectedIndex == 0,
                onTap: () => onTap(0),
              ),
              _NavItem(
                icon: Icons.videogame_asset_outlined,
                label: l.navGames,
                isSelected: selectedIndex == 1,
                onTap: () => onTap(1),
              ),
              _NavItem(
                icon: Icons.play_circle_outline_rounded,
                label: l.navTutorials,
                isSelected: selectedIndex == 2,
                onTap: () => onTap(2),
              ),
              _NavItem(
                icon: Icons.more_horiz_rounded,
                label: l.navMore,
                isSelected: selectedIndex == 3,
                onTap: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? AppColors.primary : AppColors.textFaint,
              shadows: isSelected
                  ? const [
                      Shadow(color: AppColors.primary, blurRadius: 10),
                      Shadow(color: AppColors.primary, blurRadius: 22),
                    ]
                  : null,
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textFaint,
                fontSize: 8,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
