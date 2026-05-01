import 'package:flutter/material.dart';
import 'package:brainflow/core/constants/constants.dart';
import 'package:brainflow/core/l10n/app_localizations.dart';

// ─── Data ─────────────────────────────────────────────────────────────────────

class _Emotion {
  final String emoji;
  final String Function(AppLocalizations) label;
  final Color color;

  const _Emotion({
    required this.emoji,
    required this.label,
    required this.color,
  });
}

const List<_Emotion> _emotions = [
  _Emotion(emoji: '😊', label: _lHappy,       color: Color(0xFFFFD166)),
  _Emotion(emoji: '😌', label: _lCalm,        color: Color(0xFF06D6A0)),
  _Emotion(emoji: '😟', label: _lAnxious,     color: Color(0xFFFF9F43)),
  _Emotion(emoji: '😢', label: _lSad,         color: Color(0xFF74B9FF)),
  _Emotion(emoji: '😡', label: _lAngry,       color: Color(0xFFFF6B6B)),
  _Emotion(emoji: '😱', label: _lScared,      color: Color(0xFFE17055)),
  _Emotion(emoji: '😴', label: _lBored,       color: Color(0xFFA29BFE)),
  _Emotion(emoji: '🤩', label: _lExcited,     color: Color(0xFFFD79A8)),
  _Emotion(emoji: '🤔', label: _lOverthink,   color: Color(0xFF81ECEC)),
  _Emotion(emoji: '😤', label: _lTense,       color: Color(0xFFD63031)),
  _Emotion(emoji: '🥵', label: _lOverwhelmed, color: Color(0xFFE84393)),
  _Emotion(emoji: '🙏', label: _lGrateful,    color: Color(0xFF55EFC4)),
];

String _lHappy(AppLocalizations l)       => l.emotionHappy;
String _lCalm(AppLocalizations l)        => l.emotionCalm;
String _lAnxious(AppLocalizations l)     => l.emotionAnxious;
String _lSad(AppLocalizations l)         => l.emotionSad;
String _lAngry(AppLocalizations l)       => l.emotionAngry;
String _lScared(AppLocalizations l)      => l.emotionScared;
String _lBored(AppLocalizations l)       => l.emotionBored;
String _lExcited(AppLocalizations l)     => l.emotionExcited;
String _lOverthink(AppLocalizations l)   => l.emotionOverthinking;
String _lTense(AppLocalizations l)       => l.emotionTense;
String _lOverwhelmed(AppLocalizations l) => l.emotionOverwhelmed;
String _lGrateful(AppLocalizations l)    => l.emotionGrateful;

// ─── Entry model ──────────────────────────────────────────────────────────────

class _DiaryEntry {
  final _Emotion emotion;
  final String text;
  final String date;

  const _DiaryEntry({
    required this.emotion,
    required this.text,
    required this.date,
  });
}

// ─── Screen ───────────────────────────────────────────────────────────────────

class EmotionsDiaryScreen extends StatefulWidget {
  const EmotionsDiaryScreen({super.key});

  @override
  State<EmotionsDiaryScreen> createState() => _EmotionsDiaryScreenState();
}

class _EmotionsDiaryScreenState extends State<EmotionsDiaryScreen> {
  final TextEditingController _diaryController = TextEditingController();
  _Emotion? _selected;
  final List<_DiaryEntry> _entries = [];

  String _nowFormatted() {
    final now = DateTime.now();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${now.year}-${two(now.month)}-${two(now.day)}  ${two(now.hour)}:${two(now.minute)}';
  }

  void _save() {
    final l = context.l10n;
    final text = _diaryController.text.trim();
    if (_selected == null) { _showSnack(l.selectFeelingFirst); return; }
    if (text.isEmpty)      { _showSnack(l.writeWhatYouFeel);   return; }

    setState(() {
      _entries.insert(0, _DiaryEntry(
        emotion: _selected!,
        text: text,
        date: _nowFormatted(),
      ));
      _diaryController.clear();
      _selected = null;
    });
    _showSnack(l.entrySaved);
  }

  void _delete(int index) => setState(() => _entries.removeAt(index));

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: const TextStyle(color: AppColors.textPrimary)),
      backgroundColor: AppColors.surfaceMedium,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  @override
  void dispose() {
    _diaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(l),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionLabel(l.chooseFeeling),
                    const SizedBox(height: 14),
                    _EmotionGrid(
                      emotions: _emotions,
                      selected: _selected,
                      onSelect: (e) => setState(() => _selected = e),
                      l: l,
                    ),
                    const SizedBox(height: 24),
                    _buildTextField(l),
                    const SizedBox(height: 14),
                    _buildSaveButton(l),
                    const SizedBox(height: 32),
                    _SectionLabel(l.savedEntries),
                    const SizedBox(height: 14),
                    _buildEntries(l),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).popUntil((r) => r.isFirst),
            child: Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
              ),
              child: const Icon(Icons.arrow_back_rounded,
                  color: AppColors.textPrimary, size: 20),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            l.emotionsDiaryTitle,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(AppLocalizations l) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: TextField(
        controller: _diaryController,
        maxLines: 5,
        style: const TextStyle(
            color: AppColors.textPrimary, fontSize: 14, height: 1.5),
        decoration: InputDecoration(
          hintText: l.feelingToday,
          hintStyle: TextStyle(color: AppColors.textHint, fontSize: 14),
          contentPadding: const EdgeInsets.all(16),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSaveButton(AppLocalizations l) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: _save,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_rounded,
                  color: AppColors.surfaceDeep, size: 18),
              const SizedBox(width: 8),
              Text(
                l.saveEntry,
                style: TextStyle(
                  color: AppColors.surfaceDeep,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEntries(AppLocalizations l) {
    if (_entries.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Center(
          child: Text(
            l.noEntriesYet,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textHint, fontSize: 13),
          ),
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _entries.length,
      separatorBuilder: (_, i) => const SizedBox(height: 12),
      itemBuilder: (ctx, i) => _EntryCard(
        entry: _entries[i],
        l: l,
        onDelete: () => _delete(i),
      ),
    );
  }
}

// ─── Emotion Grid ─────────────────────────────────────────────────────────────

class _EmotionGrid extends StatelessWidget {
  final List<_Emotion> emotions;
  final _Emotion? selected;
  final ValueChanged<_Emotion> onSelect;
  final AppLocalizations l;

  const _EmotionGrid({
    required this.emotions,
    required this.selected,
    required this.onSelect,
    required this.l,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: emotions.map((e) {
        final isSelected = selected == e;
        return GestureDetector(
          onTap: () => onSelect(e),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? e.color.withValues(alpha: 0.2)
                  : AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: isSelected
                    ? e.color.withValues(alpha: 0.85)
                    : AppColors.primary.withValues(alpha: 0.1),
                width: isSelected ? 1.8 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 1.0, end: isSelected ? 1.25 : 1.0),
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutBack,
                  builder: (_, scale, child) =>
                      Transform.scale(scale: scale, child: child),
                  child: Text(e.emoji,
                      style: const TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 6),
                Text(
                  e.label(l),
                  style: TextStyle(
                    color: isSelected ? e.color : AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ─── Entry Card ───────────────────────────────────────────────────────────────

class _EntryCard extends StatelessWidget {
  final _DiaryEntry entry;
  final AppLocalizations l;
  final VoidCallback onDelete;

  const _EntryCard({
    required this.entry,
    required this.l,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final color = entry.emotion.color;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left accent bar
              Container(
                width: 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withValues(alpha: 0.4)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top row: emotion chip + delete
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(entry.emotion.emoji,
                                    style: const TextStyle(fontSize: 16)),
                                const SizedBox(width: 5),
                                Text(
                                  entry.emotion.label(l),
                                  style: TextStyle(
                                    color: color,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: onDelete,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.error.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.delete_outline_rounded,
                                color: AppColors.error,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Entry text
                      Text(
                        entry.text,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Date
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 11,
                            color: AppColors.textPrimary
                                .withValues(alpha: 0.3),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            entry.date,
                            style: TextStyle(
                              color: AppColors.textPrimary
                                  .withValues(alpha: 0.3),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Section Label ────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.textFaint,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.8,
      ),
    );
  }
}
