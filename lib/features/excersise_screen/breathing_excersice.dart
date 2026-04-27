import 'dart:async';
import 'package:flutter/material.dart';
import 'package:brainflow/core/constants/constants.dart';

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

  int countdown = 60;
  int innerCount = 1;
  bool isBreathingIn = true;

  Timer? mainTimer;
  Timer? switchTimer;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
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

  void startBreathing() {
    if (started) return;

    setState(() {
      showReady = false;
      started = true;
    });

    textController.reset();
    textController.forward();
    controller.repeat(reverse: true);

    mainTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() => countdown--);
      } else {
        timer.cancel();
        controller.stop();
        switchTimer?.cancel();
        setState(() {});
      }
    });

    switchTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown == 0) return;
      if (innerCount == 4) {
        innerCount = 1;
        isBreathingIn = !isBreathingIn;
        textController.reset();
        textController.forward();
      } else {
        innerCount++;
      }
      setState(() {});
    });
  }

  void reset() {
    setState(() {
      countdown = 60;
      innerCount = 1;
      isBreathingIn = true;
      started = false;
      showReady = true;
    });

    textController.reset();
    textController.forward();

    Future.delayed(const Duration(milliseconds: 1200), () {
      startBreathing();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    textController.dispose();
    mainTimer?.cancel();
    switchTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

            // // Screen label
            // Positioned(
            //   top: 20,
            //   left: 0,
            //   right: 0,
            //   child: Center(
            //     child: Text(
            //       'BREATH RESET',
            //       style: TextStyle(
            //         color: AppColors.textFaint,
            //         fontSize: 11,
            //         fontWeight: FontWeight.w700,
            //         letterSpacing: 2.5,
            //       ),
            //     ),
            //   ),
            // ),
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

                      // Animated lavender inner circle
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
                                color: AppColors.primary.withValues(
                                  alpha: 0.35,
                                ),
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

                  // Breathe In / Out text
                  FadeTransition(
                    opacity: fadeAnim,
                    child: SlideTransition(
                      position: slideAnim,
                      child: Text(
                        showReady
                            ? 'Ready'
                            : (countdown == 0
                                  ? ''
                                  : (isBreathingIn
                                        ? 'Breathe In'
                                        : 'Breathe Out')),
                        style: const TextStyle(
                          fontSize: 24,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 52),

                  // Repeat button when session ends
                  if (countdown == 0)
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
                                  color: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Text(
                              'REPEAT',
                              style: TextStyle(
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
