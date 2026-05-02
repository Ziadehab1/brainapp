import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:brainflow/core/constants/constants.dart';
import 'package:brainflow/core/l10n/app_localizations.dart';

enum _BreathPhase { breatheIn, hold, breatheOut }

class BreathingExerciseScreen extends StatefulWidget {
  const BreathingExerciseScreen({super.key});

  @override
  State<BreathingExerciseScreen> createState() =>
      _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController textController;
  late Animation<double> fadeAnim;
  late Animation<Offset> slideAnim;

  bool showReady = true;
  bool started = false;
  bool sessionRated = false;

  int countdown = 60;
  int innerCount = 1;
  _BreathPhase phase = _BreathPhase.breatheIn;

  Timer? mainTimer;

  static const _durations = {
    _BreathPhase.breatheIn: 7,
    _BreathPhase.hold: 4,
    _BreathPhase.breatheOut: 8,
  };

  int get _phaseDuration => _durations[phase]!;

  _BreathPhase get _nextPhase {
    switch (phase) {
      case _BreathPhase.breatheIn:
        return _BreathPhase.hold;
      case _BreathPhase.hold:
        return _BreathPhase.breatheOut;
      case _BreathPhase.breatheOut:
        return _BreathPhase.breatheIn;
    }
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    );

    textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    fadeAnim = Tween<double>(begin: 0, end: 1).animate(textController);
    slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.20),
      end: Offset.zero,
    ).animate(textController);

    textController.forward();

    Future.delayed(const Duration(milliseconds: 1200), () {
      startBreathing();
    });
  }

  void _startPhase(_BreathPhase p) {
    phase = p;
    innerCount = 1;
    textController.reset();
    textController.forward();

    switch (p) {
      case _BreathPhase.breatheIn:
        controller.duration = const Duration(seconds: 7);
        controller.forward(from: 0.0);
        break;
      case _BreathPhase.hold:
        // Circle stays expanded — visual cue for holding breath
        controller.stop();
        break;
      case _BreathPhase.breatheOut:
        controller.duration = const Duration(seconds: 8);
        controller.reverse(from: 1.0);
        break;
    }
  }

  void startBreathing() {
    if (started) return;

    setState(() {
      showReady = false;
      started = true;
    });

    _startPhase(_BreathPhase.breatheIn);

    mainTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown <= 0) {
        timer.cancel();
        controller.stop();
        setState(() {});
        Future.delayed(const Duration(milliseconds: 400), _showRatingSheet);
        return;
      }

      if (innerCount >= _phaseDuration) {
        _startPhase(_nextPhase);
      } else {
        innerCount++;
      }

      countdown--;
      setState(() {});
    });
  }

  void reset() {
    mainTimer?.cancel();
    controller.stop();

    setState(() {
      countdown = 60;
      innerCount = 1;
      phase = _BreathPhase.breatheIn;
      started = false;
      showReady = true;
      sessionRated = false;
    });

    textController.reset();
    textController.forward();

    Future.delayed(const Duration(milliseconds: 1200), () {
      startBreathing();
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
      builder: (_) => StatefulBuilder(
        builder: (ctx, setSheetState) => Container(
          padding: const EdgeInsets.fromLTRB(28, 28, 28, 40),
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
              Text(
                l.rateSession,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l.rateSessionSub,
                style: TextStyle(
                  color: AppColors.textFaint,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 28),
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (_, __) => Icon(
                  Icons.star_rounded,
                  color: AppColors.primary,
                ),
                onRatingUpdate: (val) => setSheetState(() => rating = val),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(ctx);
                    setState(() => sessionRated = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l.thankYou),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      l.submitRating,
                      style: const TextStyle(
                        color: AppColors.surfaceDeep,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
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
  void dispose() {
    controller.dispose();
    textController.dispose();
    mainTimer?.cancel();
    super.dispose();
  }

  String _phaseLabel(AppLocalizations l) {
    if (showReady) return l.breatheReady;
    if (countdown == 0) return '';
    switch (phase) {
      case _BreathPhase.breatheIn:
        return l.breatheIn;
      case _BreathPhase.hold:
        return l.breatheHold;
      case _BreathPhase.breatheOut:
        return l.breatheOut;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Back button
            Positioned(
              top: 12,
              left: 16,
              child: GestureDetector(
                onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
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

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Countdown
                  Text(
                    '$countdown',
                    style: const TextStyle(
                      fontSize: 42,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 44),

                  // Breathing circle
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Subtle outer ring
                      Container(
                        width: 270,
                        height: 270,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            width: 1.5,
                          ),
                        ),
                      ),

                      // Dark static circle
                      Container(
                        width: 240,
                        height: 240,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.surface,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              blurRadius: 30,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                      ),

                      // Animated lavender inner circle — stops during hold
                      ScaleTransition(
                        scale: controller,
                        child: Container(
                          width: 175,
                          height: 175,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.primaryLighter.withValues(alpha: 0.9),
                                AppColors.primary.withValues(alpha: 0.4),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.35),
                                blurRadius: 24,
                                spreadRadius: 6,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Inner count
                      Text(
                        showReady ? '' : '$innerCount',
                        style: const TextStyle(
                          fontSize: 52,
                          color: AppColors.surfaceDeep,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 36),

                  // Phase label
                  FadeTransition(
                    opacity: fadeAnim,
                    child: SlideTransition(
                      position: slideAnim,
                      child: Text(
                        _phaseLabel(l),
                        style: const TextStyle(
                          fontSize: 24,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 52),

                  // Repeat button — only shown after rating is submitted
                  if (countdown == 0 && sessionRated)
                    FadeTransition(
                      opacity: fadeAnim,
                      child: SlideTransition(
                        position: slideAnim,
                        child: GestureDetector(
                          onTap: reset,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 52,
                              vertical: 18,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.3),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Text(
                              l.breatheRepeat,
                              style: const TextStyle(
                                color: AppColors.surfaceDeep,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
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
