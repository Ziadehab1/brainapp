import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../custom_widgets/form_shared_widget.dart';

class _QItem {
  final String label;
  final TextEditingController controller;
  _QItem({required this.label, required this.controller});
}

class INoticeActivityScreen extends StatefulWidget {
  const INoticeActivityScreen({super.key});

  @override
  State<INoticeActivityScreen> createState() => _INoticeActivityScreenState();
}

class _INoticeActivityScreenState extends State<INoticeActivityScreen> {
  int _step = 0;

  // Card 1
  final _c1q1 = TextEditingController();
  final _c1q2 = TextEditingController();
  final _c1q3 = TextEditingController();
  final _c1q4 = TextEditingController();

  // Card 2
  final _c2q1 = TextEditingController();
  final _c2q2 = TextEditingController();
  final _c2q3 = TextEditingController();

  // Card 3
  final _c3q1 = TextEditingController();
  final _c3q2 = TextEditingController();
  final _c3q3 = TextEditingController();
  final _c3q4 = TextEditingController();

  // Card 4
  final _c4q1 = TextEditingController();
  final _c4q2 = TextEditingController();
  final _c4q3 = TextEditingController();

  // Card 5
  final _c5q1 = TextEditingController();
  final _c5q2 = TextEditingController();
  final _c5q3 = TextEditingController();

  // Card 6
  final Set<String> _c6Selected = {};
  final _c6Next = TextEditingController();

  // Card 7
  final _c7q1 = TextEditingController();
  final _c7q2 = TextEditingController();
  final _c7q3 = TextEditingController();

  // Card 8
  final _c8q1 = TextEditingController();
  final _c8q2 = TextEditingController();

  @override
  void dispose() {
    for (final c in [
      _c1q1, _c1q2, _c1q3, _c1q4,
      _c2q1, _c2q2, _c2q3,
      _c3q1, _c3q2, _c3q3, _c3q4,
      _c4q1, _c4q2, _c4q3,
      _c5q1, _c5q2, _c5q3,
      _c6Next,
      _c7q1, _c7q2, _c7q3,
      _c8q1, _c8q2,
    ]) {
      c.dispose();
    }
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
      child: _buildCard(),
    );
  }

  Widget _buildCard() {
    final l = context.l10n;
    switch (_step) {
      case 1:
        return _CardPage(
          cardTitle: l.inaCard1Title,
          questions: [
            _QItem(label: '1. ${l.inaC1Q1}', controller: _c1q1),
            _QItem(label: '2. ${l.inaC1Q2}', controller: _c1q2),
            _QItem(label: '3. ${l.inaC1Q3}', controller: _c1q3),
            _QItem(label: '4. ${l.inaC1Q4}', controller: _c1q4),
          ],
          onContinue: _next,
        );
      case 2:
        return _CardPage(
          cardTitle: l.inaCard2Title,
          questions: [
            _QItem(label: '1. ${l.inaC2Q1}', controller: _c2q1),
            _QItem(label: '2. ${l.inaC2Q2}', controller: _c2q2),
            _QItem(label: '3. ${l.inaC2Q3}', controller: _c2q3),
          ],
          onContinue: _next,
        );
      case 3:
        return _CardPage(
          cardTitle: l.inaCard3Title,
          questions: [
            _QItem(label: '1. ${l.inaC3Q1}', controller: _c3q1),
            _QItem(label: '2. ${l.inaC3Q2}', controller: _c3q2),
            _QItem(label: '3. ${l.inaC3Q3}', controller: _c3q3),
            _QItem(label: '4. ${l.inaC3Q4}', controller: _c3q4),
          ],
          onContinue: _next,
        );
      case 4:
        return _CardPage(
          cardTitle: l.inaCard4Title,
          questions: [
            _QItem(label: '1. ${l.inaC4Q1}', controller: _c4q1),
            _QItem(label: '2. ${l.inaC4Q2}', controller: _c4q2),
            _QItem(label: '3. ${l.inaC4Q3}', controller: _c4q3),
          ],
          onContinue: _next,
        );
      case 5:
        return _CardPage(
          cardTitle: l.inaCard5Title,
          questions: [
            _QItem(label: '1. ${l.inaC5Q1}', controller: _c5q1),
            _QItem(label: '2. ${l.inaC5Q2}', controller: _c5q2),
            _QItem(label: '3. ${l.inaC5Q3}', controller: _c5q3),
          ],
          onContinue: _next,
        );
      case 6:
        return _Card6Page(
          cardTitle: l.inaCard6Title,
          options: [
            l.inaC6OptEnergy,
            l.inaC6OptCalm,
            l.inaC6OptSpace,
            l.inaC6OptSupport,
            l.inaC6OptFocus,
            l.inaC6OptRest,
          ],
          selected: _c6Selected,
          onToggle: (v) => setState(() {
            _c6Selected.contains(v) ? _c6Selected.remove(v) : _c6Selected.add(v);
          }),
          nextLabel: l.inaC6Next,
          nextHint: l.inaC6NextHint,
          nextController: _c6Next,
          onContinue: _next,
        );
      case 7:
        return _CardPage(
          cardTitle: l.inaCard7Title,
          questions: [
            _QItem(label: '1. ${l.inaC7Q1}', controller: _c7q1),
            _QItem(label: '2. ${l.inaC7Q2}', controller: _c7q2),
            _QItem(label: '3. ${l.inaC7Q3}', controller: _c7q3),
          ],
          onContinue: _next,
        );
      case 8:
        return _CardPage(
          cardTitle: l.inaCard8Title,
          questions: [
            _QItem(label: '1. ${l.inaC8Q1}', controller: _c8q1),
            _QItem(label: '2. ${l.inaC8Q2}', controller: _c8q2),
          ],
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
                        colors: [AppColors.formTealStart, AppColors.background],
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
                            colors: [AppColors.formTealEnd, AppColors.background],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: _BackButton(onTap: () => Navigator.pop(context)),
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
                        Icons.self_improvement_outlined,
                        color: AppColors.primary,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      l.inaIntroTitle,
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
                      l.inaIntroBody,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    const Spacer(),
                    _PrimaryButton(
                      label: l.startSession,
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

// ─── Question Shell ───────────────────────────────────────────────────────────

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
    final l = context.l10n;
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
                  _BackButton(onTap: onBack),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        l.inaSessionLabel,
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

// ─── Multi-question Card Page ─────────────────────────────────────────────────

class _CardPage extends StatelessWidget {
  final String cardTitle;
  final List<_QItem> questions;
  final VoidCallback onContinue;

  const _CardPage({
    required this.cardTitle,
    required this.questions,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Badge(label: l.badgeQuickNote),
          const SizedBox(height: 16),
          Text(
            cardTitle,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 20),
          ...questions.map((q) => _QuestionField(item: q)),
          const SizedBox(height: 8),
          _PrimaryButton(
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

// ─── Card 6: MCQ + text field ─────────────────────────────────────────────────

class _Card6Page extends StatelessWidget {
  final String cardTitle;
  final List<String> options;
  final Set<String> selected;
  final ValueChanged<String> onToggle;
  final String nextLabel;
  final String nextHint;
  final TextEditingController nextController;
  final VoidCallback onContinue;

  const _Card6Page({
    required this.cardTitle,
    required this.options,
    required this.selected,
    required this.onToggle,
    required this.nextLabel,
    required this.nextHint,
    required this.nextController,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Badge(label: l.badgeMultiChoice),
          const SizedBox(height: 16),
          Text(
            cardTitle,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            l.chooseAsMany,
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
              multiSelect: true,
              onTap: () => onToggle(opt),
            ),
          )),
          const SizedBox(height: 20),
          Text(
            nextLabel,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          _InlineTextField(controller: nextController, hint: nextHint),
          const SizedBox(height: 24),
          _PrimaryButton(
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

// ─── Single question field ────────────────────────────────────────────────────

class _QuestionField extends StatefulWidget {
  final _QItem item;
  const _QuestionField({required this.item});

  @override
  State<_QuestionField> createState() => _QuestionFieldState();
}

class _QuestionFieldState extends State<_QuestionField> {
  @override
  void initState() {
    super.initState();
    widget.item.controller.addListener(_rebuild);
  }

  @override
  void didUpdateWidget(_QuestionField old) {
    super.didUpdateWidget(old);
    if (old.item.controller != widget.item.controller) {
      old.item.controller.removeListener(_rebuild);
      widget.item.controller.addListener(_rebuild);
    }
  }

  void _rebuild() => setState(() {});

  @override
  void dispose() {
    widget.item.controller.removeListener(_rebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.item.label,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: widget.item.controller,
                  maxLines: 3,
                  minLines: 2,
                  style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: '...',
                    hintStyle: TextStyle(color: AppColors.textDisabled, fontSize: 14),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Text(
                  '${widget.item.controller.text.length} ${context.l10n.chars}',
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
        ],
      ),
    );
  }
}

// ─── Inline text field (used for Card 6 next step) ───────────────────────────

class _InlineTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  const _InlineTextField({required this.controller, required this.hint});

  @override
  State<_InlineTextField> createState() => _InlineTextFieldState();
}

class _InlineTextFieldState extends State<_InlineTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_rebuild);
  }

  void _rebuild() => setState(() {});

  @override
  void dispose() {
    widget.controller.removeListener(_rebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: widget.controller,
            maxLines: 3,
            minLines: 2,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(color: AppColors.textDisabled, fontSize: 14),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          Text(
            '${widget.controller.text.length} ${context.l10n.chars}',
            style: TextStyle(
              color: AppColors.textHint,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
          ),
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
                child: const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.primary,
                  size: 38,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                l.inaCompleteTitle,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l.inaCompleteBody,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              _PrimaryButton(
                label: l.finishReflection,
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
          ],
        ),
      ),
    );
  }
}
