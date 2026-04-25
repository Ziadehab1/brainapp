import 'package:flutter/material.dart';
import 'package:brainapp/core/constants/constants.dart';

class _Mood {
  final String id;
  final String title;
  final String mainEmoji;
  final List<String> alternatives;
  final List<Color> gradient;

  const _Mood({
    required this.id,
    required this.title,
    required this.mainEmoji,
    required this.alternatives,
    required this.gradient,
  });
}

class _SavedMood {
  final String emoji;
  final String title;
  final String date;
  final List<Color> gradient;

  const _SavedMood({
    required this.emoji,
    required this.title,
    required this.date,
    required this.gradient,
  });
}

class MoodDiaryScreen extends StatefulWidget {
  const MoodDiaryScreen({super.key});

  @override
  State<MoodDiaryScreen> createState() => _MoodDiaryScreenState();
}

class _MoodDiaryScreenState extends State<MoodDiaryScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.82);

  final List<_Mood> moods = const [
    _Mood(
      id: 'happy',
      title: 'Happy',
      mainEmoji: '😄',
      alternatives: ['🙂', '😊', '🤗', '😍'],
      gradient: [AppColors.exercisePurpleStart, AppColors.moodHappyEnd],
    ),
    _Mood(
      id: 'stressed',
      title: 'Stressed',
      mainEmoji: '😵‍💫',
      alternatives: ['😫', '😖', '😣', '😰'],
      gradient: [AppColors.moodAngryStart, AppColors.moodAngryEnd],
    ),
    _Mood(
      id: 'calm',
      title: 'Calm',
      mainEmoji: '😌',
      alternatives: ['😇', '😴', '🌿', '🕊️'],
      gradient: [AppColors.exerciseTealStart, AppColors.moodCalmEnd],
    ),
    _Mood(
      id: 'overthinking',
      title: 'Overthinking',
      mainEmoji: '🤯',
      alternatives: ['😕', '😟', '😩', '🧠'],
      gradient: [AppColors.tutorialNavyStart, AppColors.moodSadEnd],
    ),
    _Mood(
      id: 'sad',
      title: 'Sad',
      mainEmoji: '😢',
      alternatives: ['😔', '😞', '😣', '💔'],
      gradient: [AppColors.tutorialBlueStart, AppColors.tutorialBlueEnd],
    ),
  ];

  final Map<String, String> _selectedEmojiPerMood = {};
  final List<_SavedMood> _savedMoods = [];

  @override
  void initState() {
    super.initState();
    for (final m in moods) {
      _selectedEmojiPerMood[m.id] = m.mainEmoji;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String _nowFormatted() {
    final now = DateTime.now();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${now.year}-${two(now.month)}-${two(now.day)} ${two(now.hour)}:${two(now.minute)}';
  }

  void _onTapSelect(_Mood mood) {
    final chosen = _selectedEmojiPerMood[mood.id] ?? mood.mainEmoji;
    setState(() {
      _savedMoods.insert(
        0,
        _SavedMood(
          emoji: chosen,
          title: mood.title,
          date: _nowFormatted(),
          gradient: mood.gradient,
        ),
      );
    });
    _showSnack('Saved: ${mood.title} $chosen');
  }

  void _deleteMood(int index) {
    setState(() => _savedMoods.removeAt(index));
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(color: Colors.white)),
        backgroundColor: AppColors.surfaceMedium,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.surface,
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Mood Diary',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Mood card swiper
            Expanded(
              flex: 6,
              child: PageView.builder(
                controller: _pageController,
                itemCount: moods.length,
                itemBuilder: (context, index) {
                  final mood = moods[index];
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double scale = 1.0;
                      if (_pageController.hasClients) {
                        final page = _pageController.page ??
                            _pageController.initialPage.toDouble();
                        scale = (1 - ((page - index).abs() * 0.25))
                            .clamp(0.8, 1.0);
                      }
                      return Transform.scale(scale: scale, child: child);
                    },
                    child: _buildMoodCard(mood),
                  );
                },
              ),
            ),

            // Saved moods section
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
                    child: Text(
                      'SAVED MOODS',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.35),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ),
                  Expanded(
                    child: _savedMoods.isEmpty
                        ? Center(
                            child: Text(
                              'Tap a card to log your mood',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.3),
                                fontSize: 13,
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            itemCount: _savedMoods.length,
                            separatorBuilder: (_, i) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, i) {
                              final saved = _savedMoods[i];
                              return Dismissible(
                                key: ValueKey(
                                    '${saved.title}_${saved.date}_$i'),
                                direction: DismissDirection.endToStart,
                                onDismissed: (_) => _deleteMood(i),
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                    color: AppColors.error,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Icon(Icons.delete_outline_rounded,
                                      color: Colors.white),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceDark,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: saved.gradient.last
                                          .withValues(alpha: 0.35),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: saved.gradient,
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Text(saved.emoji,
                                              style: const TextStyle(
                                                  fontSize: 24)),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              saved.title,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              saved.date,
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withValues(alpha: 0.35),
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodCard(_Mood mood) {
    final selected = _selectedEmojiPerMood[mood.id] ?? mood.mainEmoji;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: GestureDetector(
        onTap: () => _onTapSelect(mood),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: mood.gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: mood.gradient.last.withValues(alpha: 0.4),
                blurRadius: 28,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                const SizedBox(height: 4),
                // Animated main emoji
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, anim) =>
                      ScaleTransition(scale: anim, child: child),
                  child: SizedBox(
                    key: ValueKey(selected),
                    height: 110,
                    child: Center(
                      child: Text(
                        selected,
                        style: const TextStyle(
                          fontSize: 76,
                          shadows: [
                            Shadow(blurRadius: 20, color: Colors.white54),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  mood.title,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 12, color: Colors.black38)],
                  ),
                ),
                const SizedBox(height: 16),
                _buildAlternativesRow(mood),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'Tap the card to save this mood',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlternativesRow(_Mood mood) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: mood.alternatives.length,
        separatorBuilder: (_, i) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final e = mood.alternatives[i];
          final isSelected = _selectedEmojiPerMood[mood.id] == e;
          return GestureDetector(
            onTap: () => setState(() => _selectedEmojiPerMood[mood.id] = e),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: EdgeInsets.all(isSelected ? 10 : 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.25)
                    : Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border.all(
                        color: Colors.white.withValues(alpha: 0.7), width: 1.5)
                    : null,
              ),
              child: Text(
                e,
                style: TextStyle(fontSize: isSelected ? 36 : 26),
              ),
            ),
          );
        },
      ),
    );
  }
}
