import 'package:brainflow/core/constants/constants.dart';
import 'package:brainflow/core/l10n/app_localizations.dart';
import 'package:brainflow/features/forms/Form_asseesments/I_notice_activity.dart';
import 'package:brainflow/features/forms/Form_asseesments/meditation_attention_assessment.dart';
import 'package:brainflow/features/forms/Form_asseesments/Mental_distraction%20_assessment.dart';
import 'package:brainflow/features/forms/Form_asseesments/assessment_focus.dart';
import 'package:brainflow/features/forms/Form_asseesments/help_on_focus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


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

class FormHomePage extends StatelessWidget {
  const FormHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final List<_FormData> allForms = [
      _FormData(
        title: l.focusAssessment,
        tag: l.tagClinical,
        description: l.focusAssessDesc,
        thumbHeight: 170,
        gradientStart: AppColors.formNavyStart,
        gradientEnd: AppColors.formNavyEnd,
        icon: Icons.track_changes_rounded,
        destination: const AssessmentFocusScreen(),
      ),
      _FormData(
        title: l.mentalDistractionTitle,
        tag: l.tagMentalDistraction,
        description: l.mentalDistractionDesc,
        thumbHeight: 140,
        gradientStart: AppColors.formBlueStart,
        gradientEnd: AppColors.formBlueEnd,
        icon: Icons.bedtime_outlined,
        destination: const MentalDistractionAssessmentScreen(),
      ),
      _FormData(
        title: l.helpOnFocusTitle,
        tag: l.tagFocus,
        description: l.helpOnFocusDesc,
        thumbHeight: 155,
        gradientStart: AppColors.formVioletStart,
        gradientEnd: AppColors.formVioletEnd,
        icon: Icons.psychology_outlined,
        destination: const HelpOnFocusScreen(),
      ),
      _FormData(
        title: l.inaFormTitle,
        tag: l.inaFormTag,
        description: l.inaFormDesc,
        thumbHeight: 145,
        gradientStart: AppColors.formTealStart,
        gradientEnd: AppColors.formTealEnd,
        icon: Icons.self_improvement_outlined,
        destination: const INoticeActivityScreen(),
      ),
      _FormData(
        title: l.maaFormTitle,
        tag: l.maaFormTag,
        description: l.maaFormDesc,
        thumbHeight: 160,
        gradientStart: AppColors.formIndigoStart,
        gradientEnd: AppColors.formIndigoEnd,
        icon: Icons.spa_outlined,
        destination: const MeditationAttentionAssessmentScreen(),
      ),
    ];

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
                      color: AppColors.textPrimary,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    l.evaluations,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.assessmentLibrary,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l.assessmentSubtitle,
                    style: TextStyle(color: AppColors.cancelText, fontSize: 13),
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
                itemCount: allForms.length,
                itemBuilder: (context, i) => _FormCard(data: allForms[i]),
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
                      colors: [AppColors.shadowVeryLight, AppColors.shadowLight],
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
                      color: AppColors.overlayMedium,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      data.tag,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
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
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    data.description,
                    style: TextStyle(color: AppColors.textDim, fontSize: 11),
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
