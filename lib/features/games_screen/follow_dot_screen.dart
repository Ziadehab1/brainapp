import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:brainflow/core/constants/constants.dart';
import 'package:brainflow/core/l10n/app_localizations.dart';

class FollowDotScreen extends StatefulWidget {
  const FollowDotScreen({super.key});

  @override
  State<FollowDotScreen> createState() => _FollowDotScreenState();
}

class _FollowDotScreenState extends State<FollowDotScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> leftAnim;
  late Animation<double> topAnim;

  final random = Random();

  double currentLeft = 0;
  double currentTop = 0;
  double nextLeft = 0;
  double nextTop = 0;

  bool showStart = true;
  bool showReady = false;
  bool showGo = false;
  bool showBall = false;
  bool _gameActive = false;

  int timer = 0;
  Timer? timerRef;

  Size? size;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && _gameActive) {
        currentLeft = nextLeft;
        currentTop = nextTop;
        moveBall();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mediaQuery = MediaQuery.of(context);
      final padding = mediaQuery.padding;
      size = Size(
        mediaQuery.size.width - padding.left - padding.right,
        mediaQuery.size.height - padding.top - padding.bottom,
      );

      currentLeft = size!.width / 2 - 25;
      currentTop = size!.height / 2 - 25;
      setState(() {});
    });
  }

  void generateNext() {
    double minTop = 80;
    double maxTop = size!.height - 130;
    double minLeft = 20;
    double maxLeft = size!.width - 70;

    if (maxLeft < minLeft) maxLeft = minLeft;
    if (maxTop < minTop) maxTop = minTop;

    nextLeft = minLeft + random.nextDouble() * (maxLeft - minLeft);
    nextTop = minTop + random.nextDouble() * (maxTop - minTop);
  }

  void startTimerTick() {
    timerRef = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => timer++);
    });
  }

  void moveBall() {
    generateNext();

    leftAnim = Tween<double>(begin: currentLeft, end: nextLeft).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
    topAnim = Tween<double>(begin: currentTop, end: nextTop).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    controller.forward(from: 0);
  }

  Future<void> startSequence() async {
    setState(() => showStart = false);
    setState(() => showReady = true);

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      showReady = false;
      showGo = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() => showGo = false);

    leftAnim = AlwaysStoppedAnimation(currentLeft);
    topAnim = AlwaysStoppedAnimation(currentTop);
    setState(() {
      showBall = true;
      _gameActive = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    startTimerTick();
    moveBall();
  }

  void _stopGame() {
    timerRef?.cancel();
    controller.stop();
    setState(() {
      _gameActive = false;
      showBall = false;
    });
    Future.delayed(const Duration(milliseconds: 250), _showRatingSheet);
  }

  void _resetGame() {
    setState(() {
      showStart = true;
      showReady = false;
      showGo = false;
      showBall = false;
      _gameActive = false;
      timer = 0;
    });
  }

  void _showRatingSheet() {
    if (!mounted) return;
    final l = context.l10n;
    double rating = 3;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
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
              const Text(
                '✦',
                style: TextStyle(color: AppColors.primaryLight, fontSize: 30),
              ),
              const SizedBox(height: 10),
              Text(
                l.sessionComplete,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _formattedTime,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 24),
              Divider(color: AppColors.textGhost, height: 1),
              const SizedBox(height: 20),
              Text(
                l.rateSession,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l.rateGameSub,
                style: TextStyle(color: AppColors.textFaint, fontSize: 13),
              ),
              const SizedBox(height: 18),
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 6),
                itemBuilder: (context, _) => const Icon(
                  Icons.star_rounded,
                  color: AppColors.primary,
                ),
                onRatingUpdate: (val) => setSheetState(() => rating = val),
              ),
              const SizedBox(height: 28),
              // Play Again
              _GameSheetButton(
                label: l.playAgain,
                primary: true,
                onTap: () {
                  Navigator.pop(ctx);
                  _resetGame();
                },
              ),
              const SizedBox(height: 12),
              // Exit
              GestureDetector(
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.of(context)
                      .popUntil((route) => route.isFirst);
                },
                child: Text(
                  l.exitGame,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get _formattedTime {
    final m = timer ~/ 60;
    final s = timer % 60;
    return m > 0
        ? '$m:${s.toString().padLeft(2, '0')}'
        : '${s.toString().padLeft(2, '0')}s';
  }

  @override
  void dispose() {
    controller.dispose();
    timerRef?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: size == null
          ? const SizedBox()
          : SafeArea(
              child: Stack(
                children: [
                  // Back button
                  Positioned(
                    top: 12,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context)
                          .popUntil((route) => route.isFirst),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: const BoxDecoration(
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
                  ),

                  // Timer
                  Positioned(
                    top: 16,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceDark,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _formattedTime,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                  // Ball
                  if (showBall)
                    AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                        return Positioned(
                          left: leftAnim.value,
                          top: topAnim.value,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary
                                      .withValues(alpha: 0.5),
                                  blurRadius: 20,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                  // Stop button (visible while game is active)
                  if (_gameActive)
                    Positioned(
                      bottom: 28,
                      left: 48,
                      right: 48,
                      child: GestureDetector(
                        onTap: _stopGame,
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceDark,
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.4),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.stop_rounded,
                                color: AppColors.primary,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                l.stopSession,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  // Start button
                  if (showStart)
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            l.followTheDot,
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2.0,
                            ),
                          ),
                          const SizedBox(height: 28),
                          GestureDetector(
                            onTap: startSequence,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 48, vertical: 18),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary
                                        .withValues(alpha: 0.3),
                                    blurRadius: 24,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
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
                        ],
                      ),
                    ),

                  // Ready text
                  if (showReady)
                    Center(
                      child: Text(
                        l.ready,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 6.0,
                        ),
                      ),
                    ),

                  // Go text
                  if (showGo)
                    Center(
                      child: Text(
                        l.go,
                        style: TextStyle(
                          color: AppColors.primaryLight,
                          fontSize: 56,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 8.0,
                          shadows: [
                            Shadow(
                              color: AppColors.primary.withValues(alpha: 0.6),
                              blurRadius: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}

// ─── Shared sheet button ──────────────────────────────────────────────────────

class _GameSheetButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool primary;

  const _GameSheetButton({
    required this.label,
    required this.onTap,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: primary ? AppColors.primaryLight : AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(26),
          border: primary
              ? null
              : Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  width: 1.5,
                ),
          boxShadow: primary
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: primary ? AppColors.surfaceDeep : AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
