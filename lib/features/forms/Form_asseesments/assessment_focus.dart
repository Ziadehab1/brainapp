import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';
import '../../custom_widgets/form_shared_widget.dart';

class AssessmentFocusScreen extends StatefulWidget {
  const AssessmentFocusScreen({super.key});

  @override
  State<AssessmentFocusScreen> createState() => _AssessmentFocusScreenState();
}

class _AssessmentFocusScreenState extends State<AssessmentFocusScreen> {
  int _step = 0; // 0 = intro, 1-8 = questions, 9 = done

  final _q1 = TextEditingController();
  final _q4 = TextEditingController();
  final _q5 = TextEditingController();
  final _q6 = TextEditingController();
  final _q7 = TextEditingController();
  final _q2Other = TextEditingController();
  final _q3Other = TextEditingController();

  final Set<String> _q2Selected = {};
  final Set<String> _q3Selected = {};

  static const _q2Options = [
    'A QUIET PLACE', 'TURN OFF YOUR PHONE', 'TIDY YOUR TABLE',
    'SET A SMALL GOAL', 'SET A TIMER', 'LISTEN TO CALMING MUSIC',
    'TAKE DEEP BREATHS', 'GET ENOUGH SLEEP', 'SOMETHING ELSE',
  ];

  static const _q3Options = [
    'NO ONE', 'FRIEND', 'FAMILY MEMBER', 'COACH/TEACHER', 'OTHER',
  ];

  @override
  void dispose() {
    _q1.dispose();
    _q4.dispose();
    _q5.dispose();
    _q6.dispose();
    _q7.dispose();
    _q2Other.dispose();
    _q3Other.dispose();
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
      onBack: _back,
      child: _buildQuestion(),
    );
  }

  Widget _buildQuestion() {
    switch (_step) {
      case 1:
        return _TextQuestionPage(
          badge: 'QUICK NOTE',
          number: 1,
          question: 'The moment I felt most focused today:',
          placeholder: 'Describe your most focused moment...',
          controller: _q1,
          onContinue: _next,
          buttonLabel: 'CONTINUE',
        );
      case 2:
        return _McqQuestionPage(
          badge: 'MULTIPLE CHOICE',
          number: 2,
          question: 'What helped me reach this moment?',
          options: _q2Options,
          selected: _q2Selected,
          otherKey: 'SOMETHING ELSE',
          otherController: _q2Other,
          onToggle: (v) => setState(() {
            _q2Selected.contains(v) ? _q2Selected.remove(v) : _q2Selected.add(v);
          }),
          onContinue: _next,
        );
      case 3:
        return _McqQuestionPage(
          badge: 'MULTIPLE CHOICE',
          number: 3,
          question: 'People who helped me focus (if any):',
          options: _q3Options,
          selected: _q3Selected,
          otherKey: 'OTHER',
          otherController: _q3Other,
          onToggle: (v) => setState(() {
            _q3Selected.contains(v) ? _q3Selected.remove(v) : _q3Selected.add(v);
          }),
          onContinue: _next,
        );
      case 4:
        return _TextQuestionPage(
          badge: 'QUICK NOTE',
          number: 4,
          question: 'Things I said to myself that encouraged me to focus:',
          placeholder: 'What did you tell yourself?',
          controller: _q4,
          onContinue: _next,
          buttonLabel: 'CONTINUE',
        );
      case 5:
        return _TextQuestionPage(
          badge: 'QUICK NOTE',
          number: 5,
          question: 'One thing I will repeat tomorrow because it helped me today:',
          placeholder: 'Repeat this...',
          controller: _q5,
          onContinue: _next,
          buttonLabel: 'CONTINUE',
        );
      case 6:
        return _TextQuestionPage(
          badge: 'QUICK NOTE',
          number: 6,
          question: 'One thing I will try to avoid because it weakens my concentration:',
          placeholder: 'Avoid this...',
          controller: _q6,
          onContinue: _next,
          buttonLabel: 'CONTINUE',
        );
      case 7:
        return _TextQuestionPage(
          badge: 'QUICK NOTE',
          number: 7,
          question: 'My words about my focus today:',
          placeholder: 'Example: Good – Average – Better – Consistent – Stronger than yesterday',
          controller: _q7,
          onContinue: _next,
          buttonLabel: 'CONTINUE',
        );
      case 8:
        return _ReminderPage(onFinish: _next);
      default:
        return const SizedBox.shrink();
    }
  }
}

// ─── Intro Page ──────────────────────────────────────────────────────────────

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
            // Top image area
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
                  // Decorative blurred overlay to mimic the photo look
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
                  // Back button
                  Positioned(
                    top: 16,
                    left: 16,
                    child: _BackButton(onTap: () => Navigator.pop(context)),
                  ),
                ],
              ),
            ),
            // Bottom content
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    // Icon
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.assignment_outlined,
                        color: AppColors.primary,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'WHAT HELPED ME TO\nFOCUS TODAY?',
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
                      'Pinpoint exactly what triggered your flow\nstate today so you can replicate it tomorrow.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    const Spacer(),
                    _PrimaryButton(
                      label: 'START SESSION',
                      icon: Icons.bolt,
                      onTap: onStart,
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

// ─── Question Shell (header + progress bar) ──────────────────────────────────

class _QuestionShell extends StatelessWidget {
  final int step;
  final int total;
  final VoidCallback onBack;
  final Widget child;

  const _QuestionShell({
    required this.step,
    required this.total,
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
            // Header row
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Row(
                children: [
                  _BackButton(onTap: onBack),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        'FOCUS FACTORS',
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
                  const SizedBox(width: 40), // balance
                ],
              ),
            ),
            // Progress bar
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

// ─── Text Question Page ───────────────────────────────────────────────────────

class _TextQuestionPage extends StatefulWidget {
  final String badge;
  final int number;
  final String question;
  final String placeholder;
  final TextEditingController controller;
  final VoidCallback onContinue;
  final String buttonLabel;

  const _TextQuestionPage({
    required this.badge,
    required this.number,
    required this.question,
    required this.placeholder,
    required this.controller,
    required this.onContinue,
    required this.buttonLabel,
  });

  @override
  State<_TextQuestionPage> createState() => _TextQuestionPageState();
}

class _TextQuestionPageState extends State<_TextQuestionPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_rebuild);
  }

  @override
  void didUpdateWidget(_TextQuestionPage oldWidget) {
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
          _Badge(label: widget.badge),
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
          // Text area
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
                      style: const TextStyle(color: AppColors.textPrimary, fontSize: 15),
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
          _PrimaryButton(
            label: widget.buttonLabel,
            icon: Icons.chevron_right,
            onTap: hasText ? widget.onContinue : null,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─── MCQ Question Page ────────────────────────────────────────────────────────

class _McqQuestionPage extends StatelessWidget {
  final String badge;
  final int number;
  final String question;
  final List<String> options;
  final Set<String> selected;
  final String otherKey;
  final TextEditingController otherController;
  final ValueChanged<String> onToggle;
  final VoidCallback onContinue;

  const _McqQuestionPage({
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
          _Badge(label: badge),
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
          // 2-column grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.1,
            ),
            itemCount: options.length,
            itemBuilder: (_, i) {
              final opt = options[i];
              final isSel = selected.contains(opt);
              return FormMcqTile(
                label: opt,
                selected: isSel,
                onTap: () => onToggle(opt),
              );
            },
          ),
          // "Other" text field — animates in when otherKey is selected
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
          _PrimaryButton(
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

// ─── Reminder / Check-In Page (Q8) ───────────────────────────────────────────

class _ReminderPage extends StatelessWidget {
  final VoidCallback onFinish;
  const _ReminderPage({required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Badge(label: 'CHECK-IN'),
          const SizedBox(height: 16),
          const Text(
            '⭐ 8. A reminder to myself:',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              '“I can concentrate when I create the right conditions for myself.”',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ),
          const Spacer(),
          _PrimaryButton(
            label: 'FINISH REFLECTION',
            icon: Icons.track_changes,
            onTap: onFinish,
            active: true,
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
              _PrimaryButton(
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

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BackButton({required this.onTap});

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
        child: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 16),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  const _Badge({required this.label});

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


class _PrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool active;

  const _PrimaryButton({
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
            if (icon == Icons.chevron_right) ...[
              const SizedBox(width: 4),
            ],
          ],
        ),
      ),
    );
  }
}
