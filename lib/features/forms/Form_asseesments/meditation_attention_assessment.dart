import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../custom_widgets/form_shared_widget.dart';

class MeditationAttentionAssessmentScreen extends StatefulWidget {
  const MeditationAttentionAssessmentScreen({super.key});

  @override
  State<MeditationAttentionAssessmentScreen> createState() =>
      _MeditationAttentionAssessmentScreenState();
}

class _MeditationAttentionAssessmentScreenState
    extends State<MeditationAttentionAssessmentScreen> {
  int _step = 0; // 0 = intro, 1–9 = questions, 10 = done

  // Q1 – 1-5 rating
  String? _q1Rating;

  // Q2 – multi-select
  final Set<String> _q2 = {};

  // Q3 – single-select
  String? _q3;

  // Q4 – single-select
  String? _q4;

  // Q5 – single-select
  String? _q5;

  // Q6 – multi-select + other text
  final Set<String> _q6 = {};
  final _q6Other = TextEditingController();

  // Q7 – multi-select
  final Set<String> _q7 = {};

  // Q8 & Q9 – text
  final _q8 = TextEditingController();
  final _q9 = TextEditingController();

  @override
  void dispose() {
    _q6Other.dispose();
    _q8.dispose();
    _q9.dispose();
    super.dispose();
  }

  void _next() => setState(() => _step++);
  void _back() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    if (_step == 0) return _IntroPage(onStart: _next);
    if (_step == 10) return _CompletionPage(onFinish: () => Navigator.pop(context));
    return _QuestionShell(
      step: _step,
      total: 9,
      sessionLabel: context.l10n.maaSessionLabel,
      onBack: _back,
      child: _buildQuestion(),
    );
  }

  Widget _buildQuestion() {
    final l = context.l10n;
    switch (_step) {
      case 1:
        return _RatingPage(
          question: l.maaQ1,
          hint: l.maaQ1Hint,
          labels: [l.maaR1Label, l.maaR2Label, l.maaR3Label, l.maaR4Label, l.maaR5Label],
          feedbacks: [l.maaFeedback1, l.maaFeedback2, l.maaFeedback3, l.maaFeedback4, l.maaFeedback5],
          emojis: const ['😞', '😕', '😐', '🙂', '😊'],
          colors: const [
            AppColors.ratingScattered,
            AppColors.ratingMany,
            AppColors.ratingModerate,
            AppColors.ratingMinimal,
            AppColors.ratingFocused,
          ],
          selected: _q1Rating,
          onSelect: (v) => setState(() => _q1Rating = v),
          onContinue: _next,
        );
      case 2:
        return _MCQPage(
          number: 2,
          question: l.maaQ2,
          options: [l.maaQ2O1, l.maaQ2O2, l.maaQ2O3, l.maaQ2O4, l.maaQ2O5, l.maaQ2O6],
          selected: _q2,
          multiSelect: true,
          onToggle: (v) => setState(() {
            _q2.contains(v) ? _q2.remove(v) : _q2.add(v);
          }),
          onContinue: _next,
        );
      case 3:
        return _MCQPage(
          number: 3,
          question: l.maaQ3,
          options: [l.maaQ3O1, l.maaQ3O2, l.maaQ3O3, l.maaQ3O4],
          selected: _q3 != null ? {_q3!} : {},
          multiSelect: false,
          onToggle: (v) => setState(() => _q3 = _q3 == v ? null : v),
          onContinue: _next,
        );
      case 4:
        return _MCQPage(
          number: 4,
          question: l.maaQ4,
          options: [l.maaQ4O1, l.maaQ4O2, l.maaQ4O3, l.maaQ4O4],
          selected: _q4 != null ? {_q4!} : {},
          multiSelect: false,
          onToggle: (v) => setState(() => _q4 = _q4 == v ? null : v),
          onContinue: _next,
        );
      case 5:
        return _MCQPage(
          number: 5,
          question: l.maaQ5,
          options: [l.maaQ5O1, l.maaQ5O2, l.maaQ5O3, l.maaQ5O4, l.maaQ5O5],
          selected: _q5 != null ? {_q5!} : {},
          multiSelect: false,
          onToggle: (v) => setState(() => _q5 = _q5 == v ? null : v),
          onContinue: _next,
        );
      case 6:
        return _MCQPage(
          number: 6,
          question: l.maaQ6,
          options: [l.maaQ6O1, l.maaQ6O2, l.maaQ6O3, l.maaQ6O4, l.maaQ6O5, l.maaQ6Other],
          selected: _q6,
          multiSelect: true,
          otherKey: l.maaQ6Other,
          otherController: _q6Other,
          onToggle: (v) => setState(() {
            _q6.contains(v) ? _q6.remove(v) : _q6.add(v);
          }),
          onContinue: _next,
        );
      case 7:
        return _MCQPage(
          number: 7,
          question: l.maaQ7,
          options: [l.maaQ7O1, l.maaQ7O2, l.maaQ7O3, l.maaQ7O4, l.maaQ7O5],
          selected: _q7,
          multiSelect: true,
          onToggle: (v) => setState(() {
            _q7.contains(v) ? _q7.remove(v) : _q7.add(v);
          }),
          onContinue: _next,
        );
      case 8:
        return _TextPage(
          number: 8,
          question: l.maaQ8,
          placeholder: l.maaQ8Hint,
          controller: _q8,
          onContinue: _next,
        );
      case 9:
        return _TextPage(
          number: 9,
          question: l.maaQ9,
          placeholder: l.maaQ9Hint,
          controller: _q9,
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
    final l = context.l10n;
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
                        colors: [AppColors.formIndigoStart, AppColors.background],
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
                            colors: [AppColors.formIndigoEnd, AppColors.background],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: _BackBtn(onTap: () => Navigator.pop(context)),
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
                        Icons.spa_outlined,
                        color: AppColors.primary,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      l.maaIntroTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l.maaIntroBody,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    const Spacer(),
                    _PrimaryBtn(label: l.startSession, icon: Icons.bolt, onTap: onStart, active: true),
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
                  _BackBtn(onTap: onBack),
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

// ─── Rating Page (Q1) ─────────────────────────────────────────────────────────

class _RatingPage extends StatelessWidget {
  final String question;
  final String hint;
  final List<String> labels;
  final List<String> feedbacks;
  final List<String> emojis;
  final List<Color> colors;
  final String? selected;
  final ValueChanged<String> onSelect;
  final VoidCallback onContinue;

  const _RatingPage({
    required this.question,
    required this.hint,
    required this.labels,
    required this.feedbacks,
    required this.emojis,
    required this.colors,
    required this.selected,
    required this.onSelect,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final sel = selected != null ? int.tryParse(selected!) : null;
    final hasSelection = selected != null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Badge(label: l.badgeCheckIn),
          const SizedBox(height: 16),
          Text(
            question,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            hint,
            style: TextStyle(color: AppColors.textMuted, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 28),
          Row(
            children: List.generate(5, (i) {
              final isSel = sel == i + 1;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i < 4 ? 8 : 0),
                  child: GestureDetector(
                    onTap: () => onSelect('${i + 1}'),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 90,
                      decoration: BoxDecoration(
                        color: isSel
                            ? colors[i].withValues(alpha: 0.75)
                            : AppColors.surfaceDark,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSel ? colors[i] : AppColors.divider,
                          width: 1.5,
                        ),
                        boxShadow: isSel
                            ? [BoxShadow(color: colors[i].withValues(alpha: 0.35), blurRadius: 12, offset: const Offset(0, 4))]
                            : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${i + 1}',
                            style: TextStyle(
                              color: isSel ? Colors.white : AppColors.textMuted,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(emojis[i], style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(5, (i) {
              final isSel = sel == i + 1;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i < 4 ? 8 : 0),
                  child: Text(
                    labels[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSel ? AppColors.textStrong : AppColors.textFaint,
                      fontSize: 9,
                      fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ),
              );
            }),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            child: hasSelection
                ? Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      decoration: BoxDecoration(
                        color: colors[sel! - 1].withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colors[sel - 1].withValues(alpha: 0.4), width: 1),
                      ),
                      child: Row(
                        children: [
                          Text(emojis[sel - 1], style: const TextStyle(fontSize: 22)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              feedbacks[sel - 1],
                              style: TextStyle(color: AppColors.textStrong, fontSize: 13, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const Spacer(),
          _PrimaryBtn(
            label: l.continueUpper,
            icon: Icons.chevron_right,
            onTap: hasSelection ? onContinue : null,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─── MCQ Page ─────────────────────────────────────────────────────────────────

class _MCQPage extends StatelessWidget {
  final int number;
  final String question;
  final List<String> options;
  final Set<String> selected;
  final bool multiSelect;
  final String? otherKey;
  final TextEditingController? otherController;
  final ValueChanged<String> onToggle;
  final VoidCallback onContinue;

  const _MCQPage({
    required this.number,
    required this.question,
    required this.options,
    required this.selected,
    required this.multiSelect,
    required this.onToggle,
    required this.onContinue,
    this.otherKey,
    this.otherController,
  });

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final showOther = otherKey != null && selected.contains(otherKey);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Badge(label: l.badgeMultiChoice),
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
          const SizedBox(height: 8),
          Text(
            multiSelect ? l.chooseAsMany : l.chooseOne,
            style: TextStyle(
              color: AppColors.textDim,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(height: 14),
          ...options.map((opt) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormSelectTile(
              label: opt,
              selected: selected.contains(opt),
              multiSelect: multiSelect,
              onTap: () => onToggle(opt),
            ),
          )),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: showOther
                ? Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: FormOtherTextField(controller: otherController!),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 20),
          _PrimaryBtn(
            label: l.continueUpper,
            icon: Icons.chevron_right,
            onTap: onContinue,
            active: true,
          ),
        ],
      ),
    );
  }
}

// ─── Text Page (Q8, Q9) ───────────────────────────────────────────────────────

class _TextPage extends StatefulWidget {
  final int number;
  final String question;
  final String placeholder;
  final TextEditingController controller;
  final VoidCallback onContinue;

  const _TextPage({
    required this.number,
    required this.question,
    required this.placeholder,
    required this.controller,
    required this.onContinue,
  });

  @override
  State<_TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<_TextPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_rebuild);
  }

  @override
  void didUpdateWidget(_TextPage old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      old.controller.removeListener(_rebuild);
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
    final l = context.l10n;
    final hasText = widget.controller.text.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Badge(label: l.badgeQuickNote),
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
                      style: const TextStyle(color: AppColors.textPrimary, fontSize: 15),
                      decoration: InputDecoration(
                        hintText: widget.placeholder,
                        hintStyle: TextStyle(color: AppColors.textDisabled, fontSize: 15),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  Text(
                    '${widget.controller.text.length} ${l.chars}',
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
          _PrimaryBtn(
            label: l.continueUpper,
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
    final l = context.l10n;
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
                child: const Icon(Icons.check_circle_outline, color: AppColors.primary, size: 38),
              ),
              const SizedBox(height: 28),
              Text(
                l.maaCompleteTitle,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l.maaCompleteBody,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textMuted, fontSize: 14, height: 1.5),
              ),
              const Spacer(),
              _PrimaryBtn(label: l.finishReflection, onTap: onFinish, active: true),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Shared Widgets ───────────────────────────────────────────────────────────

class _BackBtn extends StatelessWidget {
  final VoidCallback onTap;
  const _BackBtn({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: AppColors.textGhost, shape: BoxShape.circle),
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
      decoration: BoxDecoration(color: AppColors.textGhost, borderRadius: BorderRadius.circular(20)),
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

class _PrimaryBtn extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool active;

  const _PrimaryBtn({required this.label, this.icon, this.onTap, this.active = false});

  @override
  Widget build(BuildContext context) {
    final usePrimary = active || onTap != null;
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
              Icon(icon, color: usePrimary ? AppColors.surfaceDeep : AppColors.textIcon, size: 18),
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
