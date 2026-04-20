import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

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
      if (status == AnimationStatus.completed) {
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
    double maxTop = size!.height - 70;
    double minLeft = 20;
    double maxLeft = size!.width - 70;

    if (maxLeft < minLeft) maxLeft = minLeft;
    if (maxTop < minTop) maxTop = minTop;

    nextLeft = minLeft + random.nextDouble() * (maxLeft - minLeft);
    nextTop = minTop + random.nextDouble() * (maxTop - minTop);
  }

  void startTimer() {
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
    setState(() => showBall = true);

    await Future.delayed(const Duration(seconds: 1));

    startTimer();
    moveBall();
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
    return Scaffold(
      backgroundColor: const Color(0xFF0D0B1E),
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
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF1C1A34),
                        ),
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
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
                        color: const Color(0xFF16142A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _formattedTime,
                        style: const TextStyle(
                          color: Color(0xFFB8A8E8),
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
                              color: const Color(0xFFCFC5F0),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFB8A8E8)
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

                  // Start button
                  if (showStart)
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Follow the Dot',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
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
                                color: const Color(0xFFCFC5F0),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFB8A8E8)
                                        .withValues(alpha: 0.3),
                                    blurRadius: 24,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.play_circle_outline_rounded,
                                    color: Color(0xFF1A1040),
                                    size: 22,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'START SESSION',
                                    style: TextStyle(
                                      color: Color(0xFF1A1040),
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
                        'READY',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
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
                        'GO',
                        style: TextStyle(
                          color: const Color(0xFFCFC5F0),
                          fontSize: 56,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 8.0,
                          shadows: [
                            Shadow(
                              color: const Color(0xFFB8A8E8)
                                  .withValues(alpha: 0.6),
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
