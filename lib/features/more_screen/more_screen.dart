import 'package:flutter/material.dart';
import 'package:brainapp/core/constants/constants.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            // Profile header
            Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.surfaceMedium,
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.primary,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Emanuel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Brain Flow Member',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            _SectionLabel('ACCOUNT'),
            const SizedBox(height: 10),
            _MoreTile(icon: Icons.person_outline_rounded, label: 'Profile'),
            _MoreTile(icon: Icons.notifications_outlined, label: 'Notifications'),
            _MoreTile(icon: Icons.lock_outline_rounded, label: 'Privacy'),
            const SizedBox(height: 24),
            _SectionLabel('PREFERENCES'),
            const SizedBox(height: 10),
            _MoreTile(icon: Icons.dark_mode_outlined, label: 'Appearance'),
            _MoreTile(icon: Icons.language_rounded, label: 'Language'),
            _MoreTile(icon: Icons.accessibility_new_rounded, label: 'Accessibility'),
            const SizedBox(height: 24),
            _SectionLabel('SUPPORT'),
            const SizedBox(height: 10),
            _MoreTile(icon: Icons.help_outline_rounded, label: 'Help & FAQ'),
            _MoreTile(icon: Icons.star_border_rounded, label: 'Rate the App'),
            _MoreTile(
              icon: Icons.logout_rounded,
              label: 'Sign Out',
              isDestructive: true,
            ),
            const SizedBox(height: 24),
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
    return Text(
      text,
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.35),
        fontSize: 11,
        letterSpacing: 1.8,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _MoreTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDestructive;

  const _MoreTile({
    required this.icon,
    required this.label,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? AppColors.error
        : Colors.white;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        leading: Icon(icon, color: isDestructive ? color : AppColors.primary, size: 22),
        title: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: isDestructive
            ? null
            : Icon(Icons.chevron_right_rounded,
                color: Colors.white.withValues(alpha: 0.25), size: 20),
        onTap: () {},
      ),
    );
  }
}
