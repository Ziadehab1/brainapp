import 'package:flutter/material.dart';
import 'package:brainflow/core/constants/constants.dart';
import 'package:brainflow/core/l10n/app_localizations.dart';

class GameData {
  final String title;
  final String tag;
  final String duration;
  final String description;
  final List<String> highlights;
  final Color gradientStart;
  final Color gradientEnd;
  final double thumbHeight;
  final Widget destination;

  const GameData({
    required this.title,
    required this.tag,
    required this.duration,
    required this.description,
    required this.highlights,
    required this.gradientStart,
    required this.gradientEnd,
    required this.thumbHeight,
    required this.destination,
  });
}

class GameDetailScreen extends StatelessWidget {
  final GameData data;

  const GameDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Top bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.surface,
                        ),
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.textPrimary,
                          size: 20,
                        ),
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryLighter,
                          ),
                          child: const Center(child: _BrainIconSmall()),
                        ),
                        Positioned(
                          top: -4,
                          right: -4,
                          child: Text(
                            '✦',
                            style: TextStyle(
                              color: AppColors.textStrong,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Banner
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [data.gradientStart, data.gradientEnd],
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.shadowVeryLight,
                              AppColors.shadowMedium,
                            ],
                          ),
                        ),
                      ),
                      // Tag badge
                      Positioned(
                        bottom: 14,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.shadowStrong,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            data.tag,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Title
                Text(
                  data.title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 10),

                // Meta row
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: AppColors.textDim,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      data.duration,
                      style: TextStyle(
                        color: AppColors.textDim,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.textHint,
                        ),
                      ),
                    ),
                    Text(
                      l.gameSession,
                      style: TextStyle(
                        color: AppColors.textDim,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Description
                Text(
                  data.description,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 15,
                    height: 1.65,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 28),

                // Session Highlights
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDark,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.sessionHighlights,
                        style: TextStyle(
                          color: AppColors.textFaint,
                          fontSize: 11,
                          letterSpacing: 1.8,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 14),
                      ...data.highlights.map(
                        (h) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                h,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Start Session button
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => data.destination),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 58,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.play_circle_outline_rounded,
                          color: AppColors.surfaceDeep,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          l.startSession,
                          style: const TextStyle(
                            color: AppColors.surfaceDeep,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BrainIconSmall extends StatelessWidget {
  const _BrainIconSmall();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(28, 28),
      painter: _BrainPainter(),
    );
  }
}

class _BrainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryDeep
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    final path = Path();
    path.moveTo(cx, cy - 1);
    path.cubicTo(cx - 2, cy - 8, cx - 10, cy - 9, cx - 10, cy - 3);
    path.cubicTo(cx - 10, cy + 4, cx - 6, cy + 7, cx - 2, cy + 7);
    path.lineTo(cx, cy + 7);
    path.moveTo(cx - 4, cy - 2);
    path.cubicTo(cx - 6, cy - 4, cx - 8, cy - 1, cx - 6, cy + 2);
    path.moveTo(cx - 2, cy + 2);
    path.cubicTo(cx - 4, cy + 3, cx - 6, cy + 5, cx - 4, cy + 7);
    path.moveTo(cx, cy - 1);
    path.cubicTo(cx + 2, cy - 8, cx + 10, cy - 9, cx + 10, cy - 3);
    path.cubicTo(cx + 10, cy + 4, cx + 6, cy + 7, cx + 2, cy + 7);
    path.lineTo(cx, cy + 7);
    path.moveTo(cx + 4, cy - 2);
    path.cubicTo(cx + 6, cy - 4, cx + 8, cy - 1, cx + 6, cy + 2);
    path.moveTo(cx + 2, cy + 2);
    path.cubicTo(cx + 4, cy + 3, cx + 6, cy + 5, cx + 4, cy + 7);
    path.moveTo(cx, cy - 1);
    path.lineTo(cx, cy + 7);
    path.moveTo(cx - 2, cy + 7);
    path.lineTo(cx + 2, cy + 7);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BrainPainter old) => false;
}
