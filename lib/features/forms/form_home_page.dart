import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:brainapp/core/constants/constants.dart';
import 'package:brainapp/features/forms/assessment_focus.dart';

class _FormData {
  final String title;
  final String tag;
  final String description;
  final int thumbHeight;
  final Color gradientStart;
  final Color gradientEnd;
  final IconData icon;
  final Widget destination;

  const _FormData({
    required this.title,
    required this.tag,
    required this.description,
    required this.thumbHeight,
    required this.gradientStart,
    required this.gradientEnd,
    required this.icon,
    required this.destination,
  });
}

final List<_FormData> _allForms = [
  // _FormData(
  //   title: 'Focus Scan',
  //   tag: 'CLINICAL',
  //   description: 'Assess attention sustainability and cognitive stamina.',
  //   thumbHeight: 170,
  //   gradientStart: const Color(0xFF1A1A3A),
  //   gradientEnd: const Color(0xFF2E2E6A),
  //   icon: Icons.track_changes_rounded,
  //   destination: const AssessmentFocusScreen(),
  // ),
  // _FormData(
  //   title: 'Rest Quality',
  //   tag: 'SLEEP',
  //   description: 'Analyze sleep hygiene and recovery patterns.',
  //   thumbHeight: 140,
  //   gradientStart: const Color(0xFF1A2535),
  //   gradientEnd: const Color(0xFF1E3A50),
  //   icon: Icons.bedtime_outlined,
  //   destination:,
  // ),
  // _FormData(
  //   title: 'Executive Function',
  //   tag: 'NEURAL',
  //   description: 'Measure planning ability and mental flexibility.',
  //   thumbHeight: 155,
  //   gradientStart: const Color(0xFF2A1A3A),
  //   gradientEnd: const Color(0xFF4A2A6A),
  //   icon: Icons.psychology_outlined,
  //  // destination:
  // ),
  // _FormData(
  //   title: 'Emotional Pulse',
  //   tag: 'MENTAL',
  //   description: 'Quick check-in on your current emotional state.',
  //   thumbHeight: 165,
  //   gradientStart: const Color(0xFF1A1A2E),
  //   gradientEnd: const Color(0xFF3A2A55),
  //   icon: Icons.self_improvement_outlined,
  //   //destination: const EmotionalPulseScreen(),
  // ),
  // _FormData(
  //   title: 'Peak Energy',
  //   tag: 'BIOMETRIC',
  //   description: 'Identify your circadian rhythm peaks and energy flow.',
  //   thumbHeight: 145,
  //   gradientStart: const Color(0xFF1A2A1A),
  //   gradientEnd: const Color(0xFF2A3E2A),
  //   icon: Icons.bolt_rounded,
  //   //destination: const PeakEnergyScreen(),
  // ),
];

class FormHomePage extends StatelessWidget {
  const FormHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 20, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Evaluations',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Assessment Library',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Understand your mind through guided forms',
                    style: TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                itemCount: _allForms.length,
                itemBuilder: (context, i) => _FormCard(data: _allForms[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormCard extends StatelessWidget {
  final _FormData data;
  const _FormCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => data.destination),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: data.thumbHeight.toDouble(),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [data.gradientStart, data.gradientEnd],
                    ),
                  ),
                ),
                Container(
                  height: data.thumbHeight.toDouble(),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.05),
                        Colors.black.withValues(alpha: 0.35),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      data.tag,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withValues(alpha: 0.2),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.5),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        data.icon,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    data.description,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 11,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
