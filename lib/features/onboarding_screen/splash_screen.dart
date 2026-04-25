import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:brainflow/features/onboarding_screen/on_boarding_screen.dart';
import 'package:brainflow/core/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _breathController;
  late AnimationController _sparkleController;
  late Animation<double> _breathAnim;
  late Animation<double> _dotAnim;
  late Animation<double> _sparkleAnim;
  bool _isInhale = true;

  @override
  void initState() {
    super.initState();

    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..addStatusListener((status) {
        if (!mounted) return;
        if (status == AnimationStatus.completed) {
          setState(() => _isInhale = false);
          _breathController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          setState(() => _isInhale = true);
          _breathController.forward();
        }
      });
      

    _breathAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _breathController, curve: Curves.easeInOut),
    );

    _dotAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _breathController, curve: Curves.easeInOut),
    );

    _sparkleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _sparkleAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _sparkleController, curve: Curves.easeInOut),
    );

    _breathController.forward();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _breathController.dispose();
    _sparkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSplash,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  // App icon with sparkle
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.primaryLighter,
                              AppColors.primary,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryMuted.withValues(alpha: 0.4),
                              blurRadius: 40,
                              spreadRadius: 8,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: _BrainIcon(),
                        ),
                      ),

                      // Sparkle top-right of icon
                      Positioned(
                        top: -10,
                        right: -10,
                        child: AnimatedBuilder(
                          animation: _sparkleAnim,
                          builder: (context, _) => Opacity(
                            opacity: _sparkleAnim.value,
                            child: const Text(
                              '✦',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 36),

                  // Brain Flow title
                  const Text(
                    'Brain Flow',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Tagline
                  Text(
                    'FOCUS.  REST.  THRIVE.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.45),
                      fontSize: 12,
                      letterSpacing: 4.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Breathing circle animation
                  AnimatedBuilder(
                    animation: _breathController,
                    builder: (context, _) {
                      return SizedBox(
                        width: 80,
                        height: 80,
                        child: CustomPaint(
                          painter: _BreathPainter(
                            progress: _breathAnim.value,
                            dotProgress: _dotAnim.value,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Inhale/Exhale text
                  Text(
                    _isInhale ? 'INHALE.  EXHALE.' : 'EXHALE.  INHALE.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.35),
                      fontSize: 11,
                      letterSpacing: 4.0,
                      fontWeight: FontWeight.w400,
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

class _BreathPainter extends CustomPainter {
  final double progress;
  final double dotProgress;

  _BreathPainter({required this.progress, required this.dotProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;
    final currentRadius = maxRadius * progress;

    // Outer glow
    final glowPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06 * progress)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, currentRadius + 8, glowPaint);

    // Main circle outline
    final circlePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, currentRadius, circlePaint);

    // Moving dot on the circle
    final angle = -pi / 2 + (2 * pi * dotProgress);
    final dotX = center.dx + currentRadius * cos(angle);
    final dotY = center.dy + currentRadius * sin(angle);

    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(dotX, dotY), 4.0, dotPaint);

    // Dot glow
    final dotGlowPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(dotX, dotY), 8.0, dotGlowPaint);
  }

  @override
  bool shouldRepaint(_BreathPainter old) =>
      old.progress != progress || old.dotProgress != dotProgress;
}

class _BrainIcon extends StatelessWidget {
  const _BrainIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(60, 60),
      painter: _BrainPainter(),
    );
  }
}

class _BrainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.surfaceOverlay
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Left hemisphere
    final leftPath = Path();
    leftPath.moveTo(cx, cy - 2);
    leftPath.cubicTo(
      cx - 4, cy - 18,
      cx - 22, cy - 20,
      cx - 22, cy - 6,
    );
    leftPath.cubicTo(
      cx - 22, cy + 8,
      cx - 12, cy + 14,
      cx - 4, cy + 16,
    );
    leftPath.lineTo(cx, cy + 16);

    // Left inner detail
    leftPath.moveTo(cx - 8, cy - 4);
    leftPath.cubicTo(
      cx - 14, cy - 8,
      cx - 18, cy - 2,
      cx - 12, cy + 4,
    );

    leftPath.moveTo(cx - 4, cy + 4);
    leftPath.cubicTo(
      cx - 10, cy + 6,
      cx - 14, cy + 10,
      cx - 8, cy + 14,
    );

    // Right hemisphere
    leftPath.moveTo(cx, cy - 2);
    leftPath.cubicTo(
      cx + 4, cy - 18,
      cx + 22, cy - 20,
      cx + 22, cy - 6,
    );
    leftPath.cubicTo(
      cx + 22, cy + 8,
      cx + 12, cy + 14,
      cx + 4, cy + 16,
    );
    leftPath.lineTo(cx, cy + 16);

    // Right inner detail
    leftPath.moveTo(cx + 8, cy - 4);
    leftPath.cubicTo(
      cx + 14, cy - 8,
      cx + 18, cy - 2,
      cx + 12, cy + 4,
    );

    leftPath.moveTo(cx + 4, cy + 4);
    leftPath.cubicTo(
      cx + 10, cy + 6,
      cx + 14, cy + 10,
      cx + 8, cy + 14,
    );

    // Center divider line
    leftPath.moveTo(cx, cy - 2);
    leftPath.lineTo(cx, cy + 16);

    canvas.drawPath(leftPath, paint);

    // Bottom stem
    final stemPaint = Paint()
      ..color = AppColors.surfaceOverlay
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(cx - 6, cy + 16),
      Offset(cx + 6, cy + 16),
      stemPaint,
    );
  }

  @override
  bool shouldRepaint(_BrainPainter old) => false;
}
