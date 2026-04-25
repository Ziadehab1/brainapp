import 'package:flutter/material.dart';
import 'package:brainflow/features/home_screen/home_screen.dart';
import 'package:brainflow/core/constants/constants.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = const [
    _OnboardingData(
      icon: Icons.bolt,
      title: 'Embrace Your Mind',
      subtitle:
          'Designed for the unique rhythms of ADHD. We help you work with your brain, not against it.',
    ),

    _OnboardingData(
      icon: Icons.adjust,
      title: 'Find Your Focus',
      subtitle:
          'Gentle nudges and science-backed techniques to anchor your attention when it wanders.',
    ),
    _OnboardingData(
      icon: Icons.star_outline_rounded,
      title: 'Rest Deeply',
      subtitle:
          "Switch off the evening buzz with routines that calm the 'always-on' mind for better sleep.",
    ),
  ];

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundOnboarding,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _pages.length,
                itemBuilder: (context, index) =>
                    _OnboardingPage(data: _pages[index]),
              ),
            ),
            _PageIndicator(
              count: _pages.length,
              current: _currentPage,
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: _ContinueButton(
                label: _currentPage == _pages.length - 1
                    ? 'Get Started'
                    : 'Continue',
                onTap: _next,
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

class _OnboardingData {
  final IconData icon;
  final String title;
  final String subtitle;

  const _OnboardingData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class _OnboardingPage extends StatelessWidget {
  final _OnboardingData data;

  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Brain circle icon with sparkle
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryLighter,
                  ),
                  child: const Center(child: _SmallBrainIcon()),
                ),
                Positioned(
                  top: -4,
                  right: -4,
                  child: Text(
                    '✦',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Feature icon card
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.surfaceOnboarding,
              ),
              child: Icon(data.icon, color: AppColors.primary, size: 34),
            ),

            const SizedBox(height: 40),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                data.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                data.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 15,
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final int count;
  final int current;

  const _PageIndicator({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 28 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isActive
                ? AppColors.primary
                : Colors.white.withValues(alpha: 0.25),
          ),
        );
      }),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _ContinueButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.primaryLight,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.surfaceDeep,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward,
              color: AppColors.surfaceDeep,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallBrainIcon extends StatelessWidget {
  const _SmallBrainIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(44, 44),
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
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    final path = Path();

    // Left hemisphere
    path.moveTo(cx, cy - 1);
    path.cubicTo(cx - 3, cy - 13, cx - 16, cy - 14, cx - 16, cy - 4);
    path.cubicTo(cx - 16, cy + 6, cx - 9, cy + 10, cx - 3, cy + 11);
    path.lineTo(cx, cy + 11);

    // Left inner
    path.moveTo(cx - 6, cy - 3);
    path.cubicTo(cx - 10, cy - 6, cx - 13, cy - 1, cx - 9, cy + 3);
    path.moveTo(cx - 3, cy + 3);
    path.cubicTo(cx - 7, cy + 5, cx - 10, cy + 7, cx - 6, cy + 10);

    // Right hemisphere
    path.moveTo(cx, cy - 1);
    path.cubicTo(cx + 3, cy - 13, cx + 16, cy - 14, cx + 16, cy - 4);
    path.cubicTo(cx + 16, cy + 6, cx + 9, cy + 10, cx + 3, cy + 11);
    path.lineTo(cx, cy + 11);

    // Right inner
    path.moveTo(cx + 6, cy - 3);
    path.cubicTo(cx + 10, cy - 6, cx + 13, cy - 1, cx + 9, cy + 3);
    path.moveTo(cx + 3, cy + 3);
    path.cubicTo(cx + 7, cy + 5, cx + 10, cy + 7, cx + 6, cy + 10);

    // Center divider
    path.moveTo(cx, cy - 1);
    path.lineTo(cx, cy + 11);

    // Bottom bar
    path.moveTo(cx - 4, cy + 11);
    path.lineTo(cx + 4, cy + 11);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BrainPainter old) => false;
}
