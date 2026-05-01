import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:brainflow/features/custom_widgets/video_player.dart';
import 'package:brainflow/core/constants/constants.dart';
import 'package:brainflow/core/l10n/app_localizations.dart';

enum _Filter { all, video, audio }

class TutorialsScreen extends StatefulWidget {
  const TutorialsScreen({super.key});

  @override
  State<TutorialsScreen> createState() => _TutorialsScreenState();
}

class _TutorialsScreenState extends State<TutorialsScreen> {
  _Filter _active = _Filter.all;

  static const List<_Tutorial> _all = [
    _Tutorial(
      title: 'Brain',
      arabicTitle: 'الدماغ',
      tag: 'COGNITIVE',
      type: _Filter.video,
      thumbHeight: 190,
      gradientStart: AppColors.tutorialPurpleStart,
      gradientEnd: AppColors.tutorialPurpleEnd,
      videoUrl: 'assets/tutorials/brain.mp4',
      isAsset: true,
    ),
    _Tutorial(
      title: 'Purification of Mindfulness',
      arabicTitle: 'تنقية اليقظة الذهنية',
      tag: 'REST',
      type: _Filter.video,
      thumbHeight: 155,
      gradientStart: AppColors.tutorialGreenStart,
      gradientEnd: AppColors.tutorialGreenEnd,
      videoUrl: 'assets/tutorials/Purification_of_mindfulness.mp4',
      isAsset: true,
    ),
    _Tutorial(
      title: '5 Senses Exercise',
      arabicTitle: 'تمرين الحواس الخمس',
      tag: 'FOCUS',
      type: _Filter.video,
      thumbHeight: 140,
      gradientStart: AppColors.tutorialRedStart,
      gradientEnd: AppColors.tutorialRedEnd,
      videoUrl: 'assets/tutorials/5Senses_exercise.mp4',
      isAsset: true,
    ),
    _Tutorial(
      title: 'Hearing Problems',
      arabicTitle: 'مشاكل السمع',
      tag: 'REST',
      type: _Filter.video,
      thumbHeight: 170,
      gradientStart: AppColors.tutorialBlueStart,
      gradientEnd: AppColors.tutorialBlueEnd,
      videoUrl: 'assets/tutorials/hearing_problems.mp4',
      isAsset: true,
    ),
    _Tutorial(
      title: 'Spacing Repetition',
      arabicTitle: 'التكرار المتباعد',
      tag: 'COGNITIVE',
      type: _Filter.video,
      thumbHeight: 125,
      gradientStart: AppColors.tutorialVioletStart,
      gradientEnd: AppColors.tutorialVioletEnd,
      videoUrl: 'assets/tutorials/spacing_repetition.mp4',
      isAsset: true,
    ),
    _Tutorial(
      title: 'Mind Maps',
      arabicTitle: 'خرائط الذهن',
      tag: 'FOCUS',
      type: _Filter.video,
      thumbHeight: 200,
      gradientStart: AppColors.tutorialNavyStart,
      gradientEnd: AppColors.tutorialNavyEnd,
      videoUrl: 'assets/tutorials/MInd Maps.mp4',
      isAsset: true,
    ),
  ];

  List<_Tutorial> get _filtered => _active == _Filter.all
      ? _all
      : _all.where((t) => t.type == _active).toList();

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
            child: Row(
              children: [
                Text(
                  l.latestTutorials,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                _FilterChip(
                  label: l.filterAll,
                  isActive: _active == _Filter.all,
                  onTap: () => setState(() => _active = _Filter.all),
                ),
                const SizedBox(width: 6),
                _FilterChip(
                  label: l.filterVideo,
                  isActive: _active == _Filter.video,
                  onTap: () => setState(() => _active = _Filter.video),
                ),
                const SizedBox(width: 6),
                _FilterChip(
                  label: l.filterAudio,
                  isActive: _active == _Filter.audio,
                  onTap: () => setState(() => _active = _Filter.audio),
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
              itemCount: _filtered.length,
              itemBuilder: (context, i) =>
                  _TutorialCard(tutorial: _filtered[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tutorial {
  final String title;
  final String arabicTitle;
  final String tag;
  final _Filter type;
  final double thumbHeight;
  final Color gradientStart;
  final Color gradientEnd;
  final String? videoUrl;
  final bool isAsset;

  const _Tutorial({
    required this.title,
    required this.arabicTitle,
    required this.tag,
    required this.type,
    required this.thumbHeight,
    required this.gradientStart,
    required this.gradientEnd,
    this.videoUrl,
    this.isAsset = false,
  });
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.surfaceMedium : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive
                ? AppColors.primary.withValues(alpha: 0.4)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? AppColors.primary : AppColors.textDim,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }
}

class _TutorialCard extends StatelessWidget {
  final _Tutorial tutorial;

  const _TutorialCard({required this.tutorial});

  String _localizedTag(AppLocalizations l) {
    switch (tutorial.tag) {
      case 'COGNITIVE':
        return l.tagCognitive;
      case 'REST':
        return l.tagRest;
      case 'FOCUS':
        return l.tagFocus;
      default:
        return tutorial.tag;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final displayTitle =
        isArabic ? tutorial.arabicTitle : tutorial.title;

    return GestureDetector(
      onTap: () {
        if (tutorial.videoUrl != null && tutorial.videoUrl!.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VideoScreen(
                videoUrl: tutorial.videoUrl!,
                isAsset: tutorial.isAsset,
              ),
            ),
          );
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: tutorial.thumbHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [tutorial.gradientStart, tutorial.gradientEnd],
                    ),
                  ),
                ),
                Container(
                  height: tutorial.thumbHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.shadowSubtle,
                        AppColors.overlayMedium,
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
                      color: AppColors.overlayHeavy,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _localizedTag(l),
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                // Play icon
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.textGhost,
                        border: Border.all(
                          color: AppColors.textMuted,
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: AppColors.textPrimary,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Info
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
              child: Column(
                crossAxisAlignment: isArabic
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    displayTitle,
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    l.videoCourse,
                    style: TextStyle(
                      color: AppColors.textFaint,
                      fontSize: 10,
                      letterSpacing: 1.4,
                      fontWeight: FontWeight.w600,
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
