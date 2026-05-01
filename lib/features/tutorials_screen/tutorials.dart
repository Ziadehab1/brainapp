import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:brainflow/features/custom_widgets/video_player.dart';
import 'package:brainflow/features/custom_widgets/audio_player.dart';
import 'package:brainflow/core/constants/constants.dart';

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
      title: 'Understanding Your Rhythm',
      tag: 'COGNITIVE',
      type: _Filter.video,
      duration: '8:45',
      thumbHeight: 190,
      gradientStart: AppColors.tutorialPurpleStart,
      gradientEnd: AppColors.tutorialPurpleEnd,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    ),
    _Tutorial(
      title: 'Sleep Hygiene 101',
      tag: 'REST',
      type: _Filter.audio,
      duration: '12:20',
      thumbHeight: 130,
      gradientStart: AppColors.tutorialGreenStart,
      gradientEnd: AppColors.tutorialGreenEnd,
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    ),
    _Tutorial(
      title: 'Dopamine & You',
      tag: 'FOCUS',
      type: _Filter.video,
      duration: '6:30',
      thumbHeight: 140,
      gradientStart: AppColors.tutorialRedStart,
      gradientEnd: AppColors.tutorialRedEnd,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    ),
    _Tutorial(
      title: 'Breathing for Clarity',
      tag: 'REST',
      type: _Filter.audio,
      duration: '9:10',
      thumbHeight: 200,
      gradientStart: AppColors.tutorialBlueStart,
      gradientEnd: AppColors.tutorialBlueEnd,
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    ),
    _Tutorial(
      title: 'Building Better Habits',
      tag: 'COGNITIVE',
      type: _Filter.video,
      duration: '14:05',
      thumbHeight: 155,
      gradientStart: AppColors.tutorialVioletStart,
      gradientEnd: AppColors.tutorialVioletEnd,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    ),
    _Tutorial(
      title: 'Evening Wind-Down',
      tag: 'REST',
      type: _Filter.audio,
      duration: '10:00',
      thumbHeight: 170,
      gradientStart: AppColors.tutorialNavyStart,
      gradientEnd: AppColors.tutorialNavyEnd,
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    ),
    _Tutorial(
      title: 'Morning Brain Activation',
      tag: 'FOCUS',
      type: _Filter.video,
      duration: '5:15',
      thumbHeight: 125,
      gradientStart: AppColors.tutorialLimeStart,
      gradientEnd: AppColors.tutorialLimeEnd,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    ),
    _Tutorial(
      title: 'Deep Focus Soundscape',
      tag: 'COGNITIVE',
      type: _Filter.audio,
      duration: '20:00',
      thumbHeight: 180,
      gradientStart: AppColors.tutorialIndigoStart,
      gradientEnd: AppColors.tutorialIndigoEnd,
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
    ),
  ];

  List<_Tutorial> get _filtered => _active == _Filter.all
      ? _all
      : _all.where((t) => t.type == _active).toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
            child: Row(
              children: [
                const Text(
                  'Latest Tutorials',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                _FilterChip(
                  label: 'ALL',
                  isActive: _active == _Filter.all,
                  onTap: () => setState(() => _active = _Filter.all),
                ),
                const SizedBox(width: 6),
                _FilterChip(
                  label: 'VIDEO',
                  isActive: _active == _Filter.video,
                  onTap: () => setState(() => _active = _Filter.video),
                ),
                const SizedBox(width: 6),
                _FilterChip(
                  label: 'AUDIO',
                  isActive: _active == _Filter.audio,
                  onTap: () => setState(() => _active = _Filter.audio),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Staggered grid
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
  final String tag;
  final _Filter type;
  final String duration;
  final double thumbHeight;
  final Color gradientStart;
  final Color gradientEnd;
  final String? videoUrl;
  final String? audioUrl;

  const _Tutorial({
    required this.title,
    required this.tag,
    required this.type,
    required this.duration,
    required this.thumbHeight,
    required this.gradientStart,
    required this.gradientEnd,
    this.videoUrl,
    this.audioUrl,
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
            color: isActive
                ? AppColors.primary
                : AppColors.textDim,
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

  bool get _isVideo => tutorial.type == _Filter.video;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isVideo &&
            tutorial.videoUrl != null &&
            tutorial.videoUrl!.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VideoScreen(videoUrl: tutorial.videoUrl!),
            ),
          );
        } else if (!_isVideo &&
            tutorial.audioUrl != null &&
            tutorial.audioUrl!.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AudioScreen(
                audioUrl: tutorial.audioUrl!,
                title: tutorial.title,
                tag: tutorial.tag,
                gradientStart: tutorial.gradientStart,
                gradientEnd: tutorial.gradientEnd,
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
            // Thumbnail — height varies per card (staggered effect)
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
                      tutorial.tag,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                // Center play / wave icon
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
                      child: Icon(
                        _isVideo
                            ? Icons.play_arrow_rounded
                            : Icons.graphic_eq_rounded,
                        color: AppColors.textPrimary,
                        size: 22,
                      ),
                    ),
                  ),
                ),
                // Duration badge
                Positioned(
                  bottom: 8,
                  right: 10,
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 11,
                        color: AppColors.textStrong,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        tutorial.duration,
                        style: TextStyle(
                          color: AppColors.textStrong,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Info
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tutorial.title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _isVideo ? 'VIDEO COURSE' : 'AUDIO COURSE',
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
