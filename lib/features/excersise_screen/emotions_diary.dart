import 'package:flutter/material.dart';
import 'package:brainflow/core/constants/constants.dart';
import 'package:brainflow/core/l10n/app_localizations.dart';

class EmotionsDiaryScreen extends StatefulWidget {
  const EmotionsDiaryScreen({super.key});

  @override
  State<EmotionsDiaryScreen> createState() => _EmotionsDiaryScreenState();
}

class _DiaryEntry {
  final String emoji;
  final String text;
  final String date;
  final int colorIndex;

  const _DiaryEntry({
    required this.emoji,
    required this.text,
    required this.date,
    required this.colorIndex,
  });
}

class _EmotionsDiaryScreenState extends State<EmotionsDiaryScreen> {
  final TextEditingController diaryController = TextEditingController();

  final List<String> emojis = [
    '😄', '😊', '😁', '😃', '😅',
    '😢', '😭', '😞', '😡', '😤',
    '😴', '😪', '🤔', '😕', '😍',
    '🤩', '😱', '😳', '😇', '🙃',
  ];

  static const List<Color> _palette = AppColors.emotionPalette;

  String selectedEmoji = '';
  final List<_DiaryEntry> _entries = [];

  Color _colorForIndex(int index) => _palette[index % _palette.length];

  String _nowFormatted() {
    final now = DateTime.now();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${now.year}-${two(now.month)}-${two(now.day)} ${two(now.hour)}:${two(now.minute)}';
  }

  void saveNote() {
    final l = context.l10n;
    final text = diaryController.text.trim();
    if (selectedEmoji.isEmpty) {
      _showSnack(l.selectFeelingFirst);
      return;
    }
    if (text.isEmpty) {
      _showSnack(l.writeWhatYouFeel);
      return;
    }

    setState(() {
      _entries.insert(
        0,
        _DiaryEntry(
          emoji: selectedEmoji,
          text: text,
          date: _nowFormatted(),
          colorIndex: selectedEmoji.codeUnitAt(0) % _palette.length,
        ),
      );
      diaryController.clear();
      selectedEmoji = '';
    });
    _showSnack(l.entrySaved);
  }

  void deleteNote(int index) {
    setState(() => _entries.removeAt(index));
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(color: AppColors.textPrimary)),
        backgroundColor: AppColors.surfaceMedium,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  void dispose() {
    diaryController.dispose();
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
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.surface,
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.textPrimary,
                        size: 20,
                      ),
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
            ),

            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Feeling label
                    Text(
                      l.chooseFeeling,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Emoji picker
                    SizedBox(
                      height: 90,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: emojis.map((e) {
                          final isSelected = selectedEmoji == e;
                          return GestureDetector(
                            onTap: () => setState(() => selectedEmoji = e),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              padding: EdgeInsets.all(isSelected ? 10 : 8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.surfaceMedium
                                    : AppColors.surfaceDark,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                          .withValues(alpha: 0.7)
                                      : AppColors.primary
                                          .withValues(alpha: 0.1),
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween(
                                    begin: 1.0,
                                    end: isSelected ? 1.3 : 1.0,
                                  ),
                                  duration: const Duration(milliseconds: 220),
                                  curve: Curves.easeOutBack,
                                  builder: (context, scale, child) =>
                                      Transform.scale(
                                    scale: scale,
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                          fontSize: isSelected ? 36 : 26),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Text field
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceDark,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color:
                              AppColors.primary.withValues(alpha: 0.15),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: diaryController,
                        maxLines: 5,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          height: 1.5,
                        ),
                        decoration: InputDecoration(
                          hintText: l.feelingToday,
                          hintStyle: TextStyle(
                            color: AppColors.textHint,
                            fontSize: 14,
                          ),
                          contentPadding: const EdgeInsets.all(16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Save button
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: saveNote,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check_rounded,
                                  color: AppColors.surfaceDeep, size: 18),
                              SizedBox(width: 8),
                              Text(
                                'Save Entry',
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
                    ),

                    const SizedBox(height: 28),

                    // Saved notes label
                    Text(
                      l.savedEntries,
                      style: TextStyle(
                        color: AppColors.textFaint,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.8,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Notes list
                    if (_entries.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Center(
                          child: Text(
                            l.noEntriesYet,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textHint,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _entries.length,
                        separatorBuilder: (_, i) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final entry = _entries[index];
                          final noteColor = _colorForIndex(entry.colorIndex);

                          return Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceDark,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: noteColor.withValues(alpha: 0.35),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: noteColor.withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Center(
                                    child: Text(entry.emoji,
                                        style:
                                            const TextStyle(fontSize: 28)),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        entry.text,
                                        style: const TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 14,
                                          height: 1.45,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        entry.date,
                                        style: TextStyle(
                                          color: AppColors.textPrimary
                                              .withValues(alpha: 0.35),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => deleteNote(index),
                                  child: const Icon(
                                    Icons.delete_outline_rounded,
                                    color: AppColors.error,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

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
}
