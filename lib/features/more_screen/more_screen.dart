import 'package:flutter/material.dart';
import 'package:brainflow/core/constants/constants.dart';
import 'package:brainflow/core/l10n/app_localizations.dart';
import 'package:brainflow/core/l10n/locale_controller.dart';
import 'package:brainflow/features/forms/form_home_page.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  void _showLanguageSheet(BuildContext context) {
    final l = context.l10n;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: AppColors.sheetHandle,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l.chooseLanguage,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            _LangOption(
              label: 'العربية',
              isSelected: LocaleController.isArabic,
              onTap: () {
                LocaleController.set(const Locale('ar'));
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 10),
            _LangOption(
              label: 'English',
              isSelected: !LocaleController.isArabic,
              onTap: () {
                LocaleController.set(const Locale('en'));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          24, 0, 24,
          MediaQuery.of(context).padding.bottom + 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Row(
              children: [
                Container(
                  width: 64, height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.surfaceMedium,
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      width: 2,
                    ),
                  ),
                  child: const Icon(Icons.person_outline_rounded,
                      color: AppColors.primary, size: 32),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Emanuel',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        )),
                    Text(l.brainFlowMember,
                        style: TextStyle(color: AppColors.textDim, fontSize: 13)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FormHomePage()),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3), width: 1),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withValues(alpha: 0.2),
                      ),
                      child: const Icon(Icons.list_alt_rounded,
                          color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 14),
                    Text(l.fillForms,
                        style: const TextStyle(
                          color: AppColors.primaryLight,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: AppColors.primary.withValues(alpha: 0.6), size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            _SectionLabel(l.sectionAccount),
            const SizedBox(height: 10),
            _MoreTile(icon: Icons.person_outline_rounded,    label: l.tileProfile),
            _MoreTile(icon: Icons.notifications_outlined,    label: l.tileNotifications),
            _MoreTile(icon: Icons.lock_outline_rounded,      label: l.tilePrivacy),
            const SizedBox(height: 24),
            _SectionLabel(l.sectionPrefs),
            const SizedBox(height: 10),
            _MoreTile(icon: Icons.dark_mode_outlined,        label: l.tileAppearance),
            _MoreTile(
              icon: Icons.language_rounded,
              label: l.tileLanguage,
              onTap: () => _showLanguageSheet(context),
            ),
            _MoreTile(icon: Icons.accessibility_new_rounded, label: l.tileAccessibility),
            const SizedBox(height: 24),
            _SectionLabel(l.sectionSupport),
            const SizedBox(height: 10),
            _MoreTile(icon: Icons.help_outline_rounded,  label: l.tileHelpFaq),
            _MoreTile(icon: Icons.star_border_rounded,   label: l.tileRateApp),
            _MoreTile(
              icon: Icons.logout_rounded,
              label: l.tileSignOut,
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _LangOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LangOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryDeep : AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.5)
                : AppColors.borderGhost,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Text(label,
                style: TextStyle(
                  color: isSelected ? AppColors.primaryLight : AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                )),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_rounded,
                  color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: AppColors.textFaint,
          fontSize: 11,
          letterSpacing: 1.8,
          fontWeight: FontWeight.w600,
        ));
  }
}

class _MoreTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDestructive;
  final VoidCallback? onTap;

  const _MoreTile({
    required this.icon,
    required this.label,
    this.isDestructive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.textPrimary;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        leading: Icon(icon,
            color: isDestructive ? color : AppColors.primary, size: 22),
        title: Text(label,
            style: TextStyle(
              color: color, fontSize: 15, fontWeight: FontWeight.w500,
            )),
        trailing: isDestructive
            ? null
            : Icon(Icons.chevron_right_rounded,
                color: AppColors.textDisabled, size: 20),
        onTap: onTap ?? () {},
      ),
    );
  }
}
