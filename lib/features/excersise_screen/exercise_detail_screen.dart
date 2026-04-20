import 'package:flutter/material.dart';

class ExerciseDetailData {
  final String title;
  final String tag;
  final String duration;
  final String description;
  final List<String> highlights;
  final Color gradientStart;
  final Color gradientEnd;
  final Widget destination;

  const ExerciseDetailData({
    required this.title,
    required this.tag,
    required this.duration,
    required this.description,
    required this.highlights,
    required this.gradientStart,
    required this.gradientEnd,
    required this.destination,
  });
}

class ExerciseDetailScreen extends StatelessWidget {
  final ExerciseDetailData data;

  const ExerciseDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0B1E),
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
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFD0C8F0),
                          ),
                          child: const Center(child: _BrainIcon()),
                        ),
                        Positioned(
                          top: -4,
                          right: -4,
                          child: Text(
                            '✦',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
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
                    borderRadius: BorderRadius.circular(28),
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
                              Colors.black.withValues(alpha: 0.05),
                              Colors.black.withValues(alpha: 0.4),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 14,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.45),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            data.tag,
                            style: const TextStyle(
                              color: Colors.white,
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
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 10),

                // Meta row
                Row(
                  children: [
                    Icon(Icons.access_time_rounded,
                        size: 14,
                        color: Colors.white.withValues(alpha: 0.4)),
                    const SizedBox(width: 5),
                    Text(
                      data.duration,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.4),
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
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                    Text(
                      'EXERCISE SESSION',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.4),
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
                    color: Colors.white.withValues(alpha: 0.55),
                    fontSize: 15,
                    height: 1.65,
                  ),
                ),

                const SizedBox(height: 28),

                // Session Highlights
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF16142A),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SESSION HIGHLIGHTS',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.35),
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
                                  color: Color(0xFFB8A8E8),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                h,
                                style: const TextStyle(
                                  color: Colors.white,
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
                      color: const Color(0xFFCFC5F0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_circle_outline_rounded,
                            color: Color(0xFF1A1040), size: 22),
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

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BrainIcon extends StatelessWidget {
  const _BrainIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: const Size(28, 28), painter: _BrainPainter());
  }
}

class _BrainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A3B8C)
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
