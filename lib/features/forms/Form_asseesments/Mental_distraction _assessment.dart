import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';

class MentalDistractionAssessmentScreen extends StatefulWidget {
  const MentalDistractionAssessmentScreen({super.key});

  @override
  State<MentalDistractionAssessmentScreen> createState() =>
      _MentalDistractionAssessmentScreenState();
}

class _MentalDistractionAssessmentScreenState
    extends State<MentalDistractionAssessmentScreen> {
  int _step = 0; // 0 = intro, 1–11 = questions, 12 = done

  // Q0 single-select rating
  String? _q0Rating;

  // Text controllers Q1–Q10
  final _q1 = TextEditingController();
  final _q2 = TextEditingController();
  final _q3 = TextEditingController();
  final _q4 = TextEditingController();
  final _q5 = TextEditingController();
  final _q6 = TextEditingController();
  final _q7 = TextEditingController();
  final _q8 = TextEditingController();
  final _q9 = TextEditingController();
  final _q10 = TextEditingController();


  @override
  void dispose() {
    _q1.dispose();
    _q2.dispose();
    _q3.dispose();
    _q4.dispose();
    _q5.dispose();
    _q6.dispose();
    _q7.dispose();
    _q8.dispose();
    _q9.dispose();
    _q10.dispose();
    super.dispose();
  }

  void _next() => setState(() => _step++);
  void _back() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    if (_step == 0) return _IntroPage(onStart: _next);
    if (_step == 12) return _CompletionPage(onFinish: () => Navigator.pop(context));
    return _QuestionShell(
      step: _step,
      total: 11,
      sessionLabel: 'DISTRACTION PULSE',
      onBack: _back,
      child: _buildQuestion(),
    );
  }

  Widget _buildQuestion() {
    switch (_step) {
      case 1:
        return _RatingQuestionPage(
          selected: _q0Rating,
          onSelect: (v) => setState(() => _q0Rating = v),
          onContinue: _next,
        );
      case 2:
        return _MDTextQuestionPage(
          badge: 'QUICK NOTE',
          number: 1,
          question: 'What things distract me?',
          placeholder: 'List your main distractions...',
          controller: _q1,
          onContinue: _next,
        );
      case 3:
        return _MDTextQuestionPage(
          badge: 'QUICK NOTE',
          number: 2,
          question: 'What times am I most distracted?',
          placeholder: 'Morning? Evening? After lunch?',
          controller: _q2,
          onContinue: _next,
        );
      case 4:
        return _MDTextQuestionPage(
          badge: 'QUICK NOTE',
          number: 3,
          question: 'Who are the people who distract me?',
          placeholder: 'Friends? Family? Colleagues?',
          controller: _q3,
          onContinue: _next,
        );
      case 5:
        return _MDTextQuestionPage(
          badge: 'QUICK NOTE',
          number: 4,
          question: 'What thoughts most often recur in my mind when I am distracted?',
          placeholder: 'Describe your recurring thoughts...',
          controller: _q4,
          onContinue: _next,
        );
      case 6:
        return _MDTextQuestionPage(
          badge: 'QUICK NOTE',
          number: 5,
          question: "What did I want to focus on but couldn't?",
          placeholder: 'What was your goal?',
          controller: _q5,
          onContinue: _next,
        );
      case 7:
        return _MDTextQuestionPage(
          badge: 'QUICK NOTE',
          number: 6,
          question: 'What feelings did I experience when I was distracted?',
          placeholder:
              'Example: anxiety, boredom, annoyance, tension, sudden excitement, fear, overthinking',
          controller: _q6,
          onContinue: _next,
        );
      case 8:
        return _MDTextQuestionPage(
          badge: 'QUICK NOTE',
          number: 7,
          question: 'What behavior did I exhibit because of the distraction?',
          placeholder:
              'Example: I picked up my phone, stopped studying, daydreamed, suddenly changed my task',
          controller: _q7,
          onContinue: _next,
        );
      case 9:
        return _MDTextQuestionPage(
          badge: 'QUICK NOTE',
          number: 8,
          question: 'What helped me refocus?',
          placeholder: 'How did you get back in the zone?',
          controller: _q8,
          onContinue: _next,
        );
      case 10:
        return _MDTextQuestionPage(
          badge: 'QUICK NOTE',
          number: 9,
          question: 'My plan to improve focus for the next day:',
          placeholder: 'What will you change tomorrow?',
          controller: _q9,
          onContinue: _next,
        );
      case 11:
        return _MDTextQuestionPage(
          badge: 'QUICK NOTE',
          number: 10,
          question: 'A sentence I write to encourage myself to focus:',
          placeholder: 'Write your power sentence...',
          controller: _q10,
          onContinue: _next,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

// ─── Intro Page ───────────────────────────────────────────────────────────────

class _IntroPage extends StatelessWidget {
  final VoidCallback onStart;
  const _IntroPage({required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.formBgStart, AppColors.background],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.25,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment(0, -0.3),
                            radius: 1.2,
                            colors: [AppColors.formAccent, AppColors.background],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: _MDBackButton(onTap: () => Navigator.pop(context)),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.track_changes,
                        color: AppColors.primary,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'MENTAL DISTRACTION\nASSESSMENT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Track and analyze mental distractions to\nbuild stronger concentration walls.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    const Spacer(),
                    _MDPrimaryButton(
                      label: 'START SESSION',
                      icon: Icons.bolt,
                      onTap: onStart,
                      active: true,
                    ),
                    const SizedBox(height: 28),
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

// ─── Question Shell ───────────────────────────────────────────────────────────

class _QuestionShell extends StatelessWidget {
  final int step;
  final int total;
  final String sessionLabel;
  final VoidCallback onBack;
  final Widget child;

  const _QuestionShell({
    required this.step,
    required this.total,
    required this.sessionLabel,
    required this.onBack,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Row(
                children: [
                  _MDBackButton(onTap: onBack),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        sessionLabel,
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.4,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '$step • $total',
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: step / total,
                  minHeight: 3,
                  backgroundColor: AppColors.borderGhost,
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

// ─── Rating Question Page (Q0) ────────────────────────────────────────────────

class _RatingQuestionPage extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onSelect;
  final VoidCallback onContinue;

  const _RatingQuestionPage({
    required this.selected,
    required this.onSelect,
    required this.onContinue,
  });

  static const _levels = [
    _RatingLevel('1', '😌', 'Very\nFocused',       AppColors.ratingFocused),
    _RatingLevel('2', '🙂', 'Minimal\nDistraction', AppColors.ratingMinimal),
    _RatingLevel('3', '😐', 'Moderate',             AppColors.ratingModerate),
    _RatingLevel('4', '😤', 'Many\nDistractions',   AppColors.ratingMany),
    _RatingLevel('5', '😵', 'Scattered',            AppColors.ratingScattered),
  ];

  @override
  Widget build(BuildContext context) {
    final sel = selected != null ? int.tryParse(selected!) : null;
    final hasSelection = selected != null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MDBadge(label: 'CHECK-IN'),
          const SizedBox(height: 16),
          const Text(
            '⭐ Rate your distraction level today:',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap a number from 1 (very focused) to 5 (totally scattered)',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 28),
          // 5 number tiles in a row
          Row(
            children: List.generate(_levels.length, (i) {
              final lvl = _levels[i];
              final isSel = sel == i + 1;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i < 4 ? 8 : 0),
                  child: GestureDetector(
                    onTap: () => onSelect(lvl.value),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 90,
                      decoration: BoxDecoration(
                        color: isSel
                            ? lvl.color.withValues(alpha: 0.75)
                            : AppColors.surfaceDark,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSel
                              ? lvl.color
                              : AppColors.divider,
                          width: 1.5,
                        ),
                        boxShadow: isSel
                            ? [
                                BoxShadow(
                                  color: lvl.color.withValues(alpha: 0.35),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                )
                              ]
                            : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            lvl.value,
                            style: TextStyle(
                              color: isSel
                                  ? Colors.white
                                  : AppColors.textMuted,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            lvl.emoji,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          // Labels row
          Row(
            children: List.generate(_levels.length, (i) {
              final lvl = _levels[i];
              final isSel = sel == i + 1;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i < 4 ? 8 : 0),
                  child: Text(
                    lvl.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSel
                          ? AppColors.textStrong
                          : AppColors.textFaint,
                      fontSize: 9,
                      fontWeight:
                          isSel ? FontWeight.w700 : FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ),
              );
            }),
          ),
          // Selected level description
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            child: hasSelection
                ? Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 14),
                      decoration: BoxDecoration(
                        color: _levels[sel! - 1]
                            .color
                            .withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _levels[sel - 1]
                              .color
                              .withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            _levels[sel - 1].emoji,
                            style: const TextStyle(fontSize: 22),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _levelDescription(sel),
                              style: TextStyle(
                                color: AppColors.textStrong,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const Spacer(),
          _MDPrimaryButton(
            label: 'CONTINUE',
            icon: Icons.chevron_right,
            onTap: hasSelection ? onContinue : null,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  static String _levelDescription(int level) {
    switch (level) {
      case 1:
        return 'Great! You were in the zone today. Let\'s find out what kept you focused.';
      case 2:
        return 'Pretty good. Minor distractions but you mostly stayed on track.';
      case 3:
        return 'A mixed day — some focus, some drift. Let\'s figure out what pulled you away.';
      case 4:
        return 'Distractions were frequent today. Identifying them is the first step to fixing it.';
      case 5:
        return 'Your mind was all over the place. That\'s okay — this assessment will help you understand why.';
      default:
        return '';
    }
  }
}

class _RatingLevel {
  final String value;
  final String emoji;
  final String label;
  final Color color;
  const _RatingLevel(this.value, this.emoji, this.label, this.color);
}

// ─── Text Question Page ───────────────────────────────────────────────────────

class _MDTextQuestionPage extends StatefulWidget {
  final String badge;
  final int number;
  final String question;
  final String placeholder;
  final TextEditingController controller;
  final VoidCallback onContinue;

  const _MDTextQuestionPage({
    required this.badge,
    required this.number,
    required this.question,
    required this.placeholder,
    required this.controller,
    required this.onContinue,
  });

  @override
  State<_MDTextQuestionPage> createState() => _MDTextQuestionPageState();
}

class _MDTextQuestionPageState extends State<_MDTextQuestionPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_rebuild);
  }

  @override
  void didUpdateWidget(_MDTextQuestionPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_rebuild);
      widget.controller.addListener(_rebuild);
    }
  }

  void _rebuild() => setState(() {});

  @override
  void dispose() {
    widget.controller.removeListener(_rebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasText = widget.controller.text.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MDBadge(label: widget.badge),
          const SizedBox(height: 16),
          Text(
            '⭐ ${widget.number}. ${widget.question}',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      style: const TextStyle(
                          color: AppColors.textPrimary, fontSize: 15),
                      decoration: InputDecoration(
                        hintText: widget.placeholder,
                        hintStyle: TextStyle(
                          color: AppColors.textDisabled,
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  Text(
                    '${widget.controller.text.length} CHARS',
                    style: TextStyle(
                      color: AppColors.textHint,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _MDPrimaryButton(
            label: 'CONTINUE',
            icon: Icons.chevron_right,
            onTap: hasText ? widget.onContinue : null,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─── Completion Page ──────────────────────────────────────────────────────────

class _CompletionPage extends StatelessWidget {
  final VoidCallback onFinish;
  const _CompletionPage({required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.primary,
                  size: 38,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Focus Logged!',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Awesome! Your self-reflection is the first\nstep to mastering your focus.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              _MDPrimaryButton(
                label: 'Finish Reflection',
                onTap: onFinish,
                active: true,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Shared Widgets ───────────────────────────────────────────────────────────

class _MDBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _MDBackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.textGhost,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.arrow_back_ios_new,
            color: AppColors.textPrimary, size: 16),
      ),
    );
  }
}

class _MDBadge extends StatelessWidget {
  final String label;
  const _MDBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.textGhost,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _MDPrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool active;

  const _MDPrimaryButton({
    required this.label,
    this.icon,
    this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final usePrimary = active || enabled;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: usePrimary
              ? AppColors.primaryLight.withValues(alpha: 0.9)
              : AppColors.borderGhost,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: usePrimary ? AppColors.surfaceDeep : AppColors.textIcon,
                size: 18,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                color: usePrimary ? AppColors.surfaceDeep : AppColors.textIcon,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
