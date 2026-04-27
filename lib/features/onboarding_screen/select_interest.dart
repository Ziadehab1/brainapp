import 'package:flutter/material.dart';
import 'package:brainflow/core/constants/constants.dart';
import 'package:brainflow/core/l10n/app_localizations.dart';
import 'package:brainflow/features/home_screen/home_screen.dart';

class Interest {
  final String name;
  final String emoji;

  const Interest({required this.name, required this.emoji});
}

class InterestSelectionScreen extends StatefulWidget {
  const InterestSelectionScreen({super.key});

  @override
  State<InterestSelectionScreen> createState() =>
      _InterestSelectionScreenState();
}

class _InterestSelectionScreenState extends State<InterestSelectionScreen> {
  static const _interests = [
    Interest(name: 'Fashion', emoji: '👚'),
    Interest(name: 'Beauty', emoji: '💄'),
    Interest(name: 'Technology', emoji: '💻'),
    Interest(name: 'Food', emoji: '🍔'),
    Interest(name: 'Health', emoji: '💊'),
    Interest(name: 'Adventure', emoji: '🪁'),
    Interest(name: 'Gaming', emoji: '🎮'),
    Interest(name: 'Home & Decor', emoji: '🛋️'),
    Interest(name: 'Crafts', emoji: '✂️'),
    Interest(name: 'Music', emoji: '🎸'),
    Interest(name: 'Pets & Animals', emoji: '🐕'),
    Interest(name: 'Art', emoji: '🎨'),
    Interest(name: 'Automotive', emoji: '🚗'),
  ];

  static const int _maxSelections = 3;

  final Set<String> _selected = {};
  bool _isLoading = false;

  void _toggle(String name) {
    setState(() {
      if (_selected.contains(name)) {
        _selected.remove(name);
      } else if (_selected.length < _maxSelections) {
        _selected.add(name);
      }
    });
  }

  Future<void> _saveAndContinue() async {
    if (_selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.selectAtLeastOne),
          backgroundColor: AppColors.surface,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(milliseconds: 300));

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (_) => false,
      );
    }
  }

  String _interestName(BuildContext context, String key) {
    final l = context.l10n;
    switch (key) {
      case 'Fashion': return l.interestFashion;
      case 'Beauty': return l.interestBeauty;
      case 'Technology': return l.interestTech;
      case 'Food': return l.interestFood;
      case 'Health': return l.interestHealth;
      case 'Adventure': return l.interestAdventure;
      case 'Gaming': return l.interestGaming;
      case 'Home & Decor': return l.interestHomeDecor;
      case 'Crafts': return l.interestCrafts;
      case 'Music': return l.interestMusic;
      case 'Pets & Animals': return l.interestPets;
      case 'Art': return l.interestArt;
      case 'Automotive': return l.interestAutomotive;
      default: return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.backgroundOnboarding,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.selectInterests,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    l.pickUpTo3,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textMuted,
                      height: 1.5,
                    ),
                  ),
                  const Spacer(),
                  _SelectionBadge(
                      count: _selected.length, max: _maxSelections),
                ],
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.8,
                  ),
                  itemCount: _interests.length,
                  itemBuilder: (context, index) {
                    final interest = _interests[index];
                    final isSelected = _selected.contains(interest.name);
                    final isMaxed = _selected.length >= _maxSelections;
                    return _InterestChip(
                      interest: interest,
                      displayName: _interestName(context, interest.name),
                      isSelected: isSelected,
                      isDisabled: isMaxed && !isSelected,
                      onTap: () => _toggle(interest.name),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              _ContinueButton(
                isLoading: _isLoading,
                onTap: _saveAndContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionBadge extends StatelessWidget {
  final int count;
  final int max;

  const _SelectionBadge({required this.count, required this.max});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: count > 0 ? AppColors.primaryDeep : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: count > 0
              ? AppColors.primary.withValues(alpha: 0.4)
              : AppColors.borderGhost,
        ),
      ),
      child: Text(
        '$count / $max',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: count > 0
              ? AppColors.primary
              : AppColors.textDim,
        ),
      ),
    );
  }
}

class _InterestChip extends StatelessWidget {
  final Interest interest;
  final String displayName;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback onTap;

  const _InterestChip({
    required this.interest,
    required this.displayName,
    required this.isSelected,
    required this.isDisabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.04 : 1.0,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryDeep
                : isDisabled
                    ? AppColors.surfaceDark
                    : AppColors.surface,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary.withValues(alpha: 0.6)
                  : AppColors.borderGhost,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(fontSize: isSelected ? 20 : 18),
                child: Text(interest.emoji),
              ),
              const SizedBox(width: 8),
              Text(
                displayName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? AppColors.primaryLight
                      : isDisabled
                          ? AppColors.textDisabled
                          : AppColors.textStrong,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;

  const _ContinueButton({required this.isLoading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.primaryLight,
        ),
        child: isLoading
            ? const Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.surfaceDeep,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.l10n.continueBtn,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.surfaceDeep,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
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
