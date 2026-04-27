import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';
import '../../custom_widgets/form_shared_widget.dart';

class HelpOnFocusScreen extends StatefulWidget {
  const HelpOnFocusScreen({super.key});

  @override
  State<HelpOnFocusScreen> createState() => _HelpOnFocusScreenState();
}

class _HelpOnFocusScreenState extends State<HelpOnFocusScreen> {
  int _step = 0; // 0 = intro, 1–8 = questions, 9 = done

  // Single-select answers
  String? _q1;
  String? _q2;
  String? _q3;
  String? _q5;
  String? _q6;

  // Multi-select
  final Set<String> _q4Selected = {};

  // Text controllers
  final _q7 = TextEditingController();
  final _q8 = TextEditingController();

  // "Other" text for Q4 and Q6
  final _q4Other = TextEditingController();
  final _q6Other = TextEditingController();

  static const _q1Options = [
    '1  Very poor',
    '2  Poor',
    '3  Average',
    '4  Good',
    '5  Excellent',
  ];

  static const _q2Options = [
    'Concentrating well',
    'Sometimes distracted',
    'Often distracted',
    'Unable to continue the task',
  ];

  static const _q3Options = [
    'No distractions',
    'Once',
    '2–3 times',
    'More than 3 times',
  ];

  static const _q4Options = [
    'MY PHONE', 'NOISE', 'PEOPLE AROUND ME',
    'INTERNAL THOUGHTS', 'BOREDOM', 'FATIGUE', 'SOMETHING ELSE',
  ];

  static const _q5Options = [
    'Yes, easily',
    'Yes, with difficulty',
    "I tried but couldn't",
    "I didn't try",
  ];

  static const _q6Options = [
    'Deep breathing',
    'Turning off distractions',
    'Changing your sitting position',
    'Taking a short break',
    'Nothing helped',
    'Other',
  ];

  @override
  void dispose() {
    _q7.dispose();
    _q8.dispose();
    _q4Other.dispose();
    _q6Other.dispose();
    super.dispose();
  }

  void _next() => setState(() => _step++);
  void _back() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    if (_step == 0) return _IntroPage(onStart: _next);
    if (_step == 9) return _CompletionPage(onFinish: () => Navigator.pop(context));
    return _QuestionShell(
      step: _step,
      total: 8,
      sessionLabel: 'FOCUS CHECK',
      onBack: _back,
      child: _buildQuestion(),
    );
  }

  Widget _buildQuestion() {
    switch (_step) {
      case 1:
        return _NumberedListPage(
          badge: 'CHECK-IN',
          number: 1,
          question: 'How would you rate your overall attention level today?',
          options: _q1Options,
          selected: _q1,
          onSelect: (v) => setState(() => _q1 = v),
          onContinue: _next,
        );
      case 2:
        return _SingleSelectPage(
          badge: 'CHECK-IN',
          number: 2,
          question: 'While performing the required task, I was:',
          options: _q2Options,
          selected: _q2,
          onSelect: (v) => setState(() => _q2 = v),
          onContinue: _next,
        );
      case 3:
        return _SingleSelectPage(
          badge: 'CHECK-IN',
          number: 3,
          question: 'Number of times distracted during the task:',
          options: _q3Options,
          selected: _q3,
          onSelect: (v) => setState(() => _q3 = v),
          onContinue: _next,
        );
      case 4:
        return _McqGridPage(
          badge: 'MULTIPLE CHOICE',
          number: 4,
          question: 'What distracted me most today was:',
          options: _q4Options,
          selected: _q4Selected,
          otherKey: 'SOMETHING ELSE',
          otherController: _q4Other,
          onToggle: (v) => setState(() {
            _q4Selected.contains(v)
                ? _q4Selected.remove(v)
                : _q4Selected.add(v);
          }),
          onContinue: _next,
        );
      case 5:
        return _SingleSelectPage(
          badge: 'CHECK-IN',
          number: 5,
          question: 'Were you able to regain your focus after being distracted?',
          options: _q5Options,
          selected: _q5,
          onSelect: (v) => setState(() => _q5 = v),
          onContinue: _next,
          highlightLast: true,
        );
      case 6:
        return _SingleSelectPage(
          badge: 'CHECK-IN',
          number: 6,
          question: 'What helped you regain your attention?',
          options: _q6Options,
          selected: _q6,
          onSelect: (v) => setState(() => _q6 = v),
          onContinue: _next,
          otherKey: 'Other',
          otherController: _q6Other,
        );
      case 7:
        return _HOFTextQuestionPage(
          badge: 'QUICK NOTE',
          number: 7,
          question: 'Describe my attention today in one word:',
          placeholder: 'One word focus...',
          controller: _q7,
          onContinue: _next,
        );
      case 8:
        return _HOFTextQuestionPage(
          badge: 'QUICK NOTE',
          number: 8,
          question: 'What will I do tomorrow to improve my attention?',
          placeholder: 'My improvement plan...',
          controller: _q8,
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
                    child: _HOFBackButton(onTap: () => Navigator.pop(context)),
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
                        Icons.psychology_outlined,
                        color: AppColors.primary,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'FOCUS ASSESSMENT',
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
                      'A comprehensive check-in on your attention\nquality throughout today\'s activities.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    const Spacer(),
                    _HOFPrimaryButton(
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
                  _HOFBackButton(onTap: onBack),
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

// ─── Numbered List Page (Q1 — shows number badges) ───────────────────────────

class _NumberedListPage extends StatelessWidget {
  final String badge;
  final int number;
  final String question;
  final List<String> options;
  final String? selected;
  final ValueChanged<String> onSelect;
  final VoidCallback onContinue;

  const _NumberedListPage({
    required this.badge,
    required this.number,
    required this.question,
    required this.options,
    required this.selected,
    required this.onSelect,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HOFBadge(label: badge),
          const SizedBox(height: 16),
          Text(
            '⭐ $number. $question',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: options.length,
              separatorBuilder: (_, i) => const SizedBox(height: 10),
              itemBuilder: (_, i) {
                final opt = options[i];
                final isSel = selected == opt;
                return GestureDetector(
                  onTap: () => onSelect(opt),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 15),
                    decoration: BoxDecoration(
                      color: isSel
                          ? AppColors.primaryDeep.withValues(alpha: 0.4)
                          : AppColors.surfaceDark,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSel
                            ? AppColors.primary.withValues(alpha: 0.5)
                            : AppColors.divider,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Number badge
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: isSel
                                ? AppColors.primary.withValues(alpha: 0.25)
                                : AppColors.formTipStart,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Text(
                              '${i + 1}',
                              style: TextStyle(
                                color: isSel
                                    ? AppColors.primaryLight
                                    : AppColors.formTipAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          opt.substring(3), // strip leading "N  "
                          style: TextStyle(
                            color: isSel
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                            fontSize: 15,
                            fontWeight: isSel
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          _HOFPrimaryButton(
            label: 'CONTINUE',
            icon: Icons.chevron_right,
            onTap: selected != null ? onContinue : null,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─── Single Select Page (Q2, Q3, Q5, Q6) ─────────────────────────────────────

class _SingleSelectPage extends StatelessWidget {
  final String badge;
  final int number;
  final String question;
  final List<String> options;
  final String? selected;
  final ValueChanged<String> onSelect;
  final VoidCallback onContinue;
  final bool highlightLast;
  final String? otherKey;
  final TextEditingController? otherController;

  const _SingleSelectPage({
    required this.badge,
    required this.number,
    required this.question,
    required this.options,
    required this.selected,
    required this.onSelect,
    required this.onContinue,
    this.highlightLast = false,
    this.otherKey,
    this.otherController,
  });

  @override
  Widget build(BuildContext context) {
    final showOther =
        otherKey != null && selected == otherKey && otherController != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HOFBadge(label: badge),
          const SizedBox(height: 16),
          Text(
            '⭐ $number. $question',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(options.length, (i) {
            final opt = options[i];
            final isSel = selected == opt;
            final isLastAndHighlight =
                highlightLast && i == options.length - 1;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: () => onSelect(opt),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 16),
                  decoration: BoxDecoration(
                    color: isSel
                        ? AppColors.primaryDeep.withValues(alpha: 0.4)
                        : AppColors.surfaceDark,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSel
                          ? AppColors.primary.withValues(alpha: 0.5)
                          : AppColors.divider,
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    opt,
                    style: TextStyle(
                      color: isSel
                          ? AppColors.textPrimary
                          : isLastAndHighlight
                              ? AppColors.error.withValues(alpha: 0.8)
                              : AppColors.textSecondary,
                      fontSize: 15,
                      fontWeight:
                          isSel ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
          // "Other" text field
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            child: showOther
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: FormOtherTextField(controller: otherController!),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 6),
          _HOFPrimaryButton(
            label: 'CONTINUE',
            icon: Icons.chevron_right,
            onTap: selected != null ? onContinue : null,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─── MCQ Grid Page (Q4) ───────────────────────────────────────────────────────

class _McqGridPage extends StatelessWidget {
  final String badge;
  final int number;
  final String question;
  final List<String> options;
  final Set<String> selected;
  final String otherKey;
  final TextEditingController otherController;
  final ValueChanged<String> onToggle;
  final VoidCallback onContinue;

  const _McqGridPage({
    required this.badge,
    required this.number,
    required this.question,
    required this.options,
    required this.selected,
    required this.otherKey,
    required this.otherController,
    required this.onToggle,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final showOther = selected.contains(otherKey);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HOFBadge(label: badge),
          const SizedBox(height: 16),
          Text(
            '⭐ $number. $question',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'CHOOSE AS MANY AS APPLY',
            style: TextStyle(
              color: AppColors.textDim,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.1,
            ),
            itemCount: options.length,
            itemBuilder: (_, i) {
              final opt = options[i];
              return FormMcqTile(
                label: opt,
                selected: selected.contains(opt),
                onTap: () => onToggle(opt),
              );
            },
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: showOther
                ? Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: FormOtherTextField(controller: otherController),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 20),
          _HOFPrimaryButton(
            label: 'DONE FOR NOW',
            icon: Icons.chevron_right,
            onTap: onContinue,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─── Text Question Page (Q7, Q8) ─────────────────────────────────────────────

class _HOFTextQuestionPage extends StatefulWidget {
  final String badge;
  final int number;
  final String question;
  final String placeholder;
  final TextEditingController controller;
  final VoidCallback onContinue;

  const _HOFTextQuestionPage({
    required this.badge,
    required this.number,
    required this.question,
    required this.placeholder,
    required this.controller,
    required this.onContinue,
  });

  @override
  State<_HOFTextQuestionPage> createState() => _HOFTextQuestionPageState();
}

class _HOFTextQuestionPageState extends State<_HOFTextQuestionPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_rebuild);
  }

  @override
  void didUpdateWidget(_HOFTextQuestionPage oldWidget) {
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
          _HOFBadge(label: widget.badge),
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
          _HOFPrimaryButton(
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
              _HOFPrimaryButton(
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

class _HOFBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _HOFBackButton({required this.onTap});

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

class _HOFBadge extends StatelessWidget {
  final String label;
  const _HOFBadge({required this.label});

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


class _HOFPrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool active;

  const _HOFPrimaryButton({
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
                color:
                    usePrimary ? AppColors.surfaceDeep : AppColors.textIcon,
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
