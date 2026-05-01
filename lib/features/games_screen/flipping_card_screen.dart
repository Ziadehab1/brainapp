import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:brainflow/core/constants/constants.dart';
import 'package:brainflow/core/l10n/app_localizations.dart';

// ─── Level config ─────────────────────────────────────────────────────────────

class _LevelConfig {
  final int pairs;
  final int checkDelayMs;
  const _LevelConfig(this.pairs, this.checkDelayMs);
}

const _levels = [
  _LevelConfig(10, 1000), // Level 1 – Easy:   10 pairs, 1.0 s flip-back
  _LevelConfig(12, 650),  // Level 2 – Medium: 12 pairs, 0.65 s flip-back
  _LevelConfig(16, 400),  // Level 3 – Hard:   16 pairs, 0.4 s flip-back
];

// ─── Screen ───────────────────────────────────────────────────────────────────

class FlippingCardScreen extends StatefulWidget {
  const FlippingCardScreen({super.key});

  @override
  State<FlippingCardScreen> createState() => _FlippingCardScreenState();
}

class _FlippingCardScreenState extends State<FlippingCardScreen> {
  int _currentLevel = 1; // 1-indexed

  int seconds = 0;
  Timer? timer;
  int score = 0;
  bool isChecking = false;

  List<GlobalKey<FlipCardState>> cardKeys = [];
  List<Color> cardColors = [];
  List<bool> isMatched = [];
  List<int> flippedIndices = [];

  final AudioPlayer flipPlayer = AudioPlayer();
  final AudioPlayer matchPlayer = AudioPlayer();
  final AudioPlayer wrongPlayer = AudioPlayer();

  _LevelConfig get _cfg => _levels[_currentLevel - 1];

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  @override
  void dispose() {
    timer?.cancel();
    flipPlayer.dispose();
    matchPlayer.dispose();
    wrongPlayer.dispose();
    super.dispose();
  }

  void _initializeGame({int level = 1}) {
    _currentLevel = level;
    timer?.cancel();
    seconds = 0;
    score = 0;
    isChecking = false;
    flippedIndices.clear();

    final base = AppColors.cardGameColors.take(_cfg.pairs).toList();
    cardColors = [...base, ...base]..shuffle();

    cardKeys = List.generate(cardColors.length, (_) => GlobalKey<FlipCardState>());
    isMatched = List.generate(cardColors.length, (_) => false);

    setState(() {});
    _startTimer();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => seconds++);
    });
  }

  String _formatTime(int s) =>
      '${(s ~/ 60).toString().padLeft(2, '0')}:${(s % 60).toString().padLeft(2, '0')}';

  Future<void> _playFlipSound() async {
    try {
      if (flipPlayer.state == PlayerState.playing) await flipPlayer.stop();
      await flipPlayer.play(AssetSource('flipcard.mp3'));
    } catch (_) {}
  }

  Future<void> _playMatchSound() async {
    try {
      await matchPlayer.stop();
      await matchPlayer.play(AssetSource('win_game.mp3'));
    } catch (_) {}
  }

  Future<void> _playWrongSound() async {
    try {
      await wrongPlayer.stop();
      await wrongPlayer.play(AssetSource('wronganswer.mp3'));
    } catch (_) {}
  }

  void _onCardTap(int index) {
    if (isChecking || isMatched[index] || flippedIndices.contains(index)) return;
    cardKeys[index].currentState?.toggleCard();
    _playFlipSound();
    setState(() => flippedIndices.add(index));
    if (flippedIndices.length == 2) _checkForMatch();
  }

  Future<void> _checkForMatch() async {
    isChecking = true;
    final i1 = flippedIndices[0];
    final i2 = flippedIndices[1];

    await Future.delayed(Duration(milliseconds: _cfg.checkDelayMs));

    if (cardColors[i1] == cardColors[i2]) {
      setState(() {
        score += 10;
        isMatched[i1] = true;
        isMatched[i2] = true;
      });
      _playMatchSound();
      if (isMatched.every((e) => e)) _showWinSheet();
    } else {
      cardKeys[i1].currentState?.toggleCard();
      cardKeys[i2].currentState?.toggleCard();
      _playWrongSound();
    }

    flippedIndices.clear();
    isChecking = false;
  }

  String _levelName(AppLocalizations l) {
    switch (_currentLevel) {
      case 1: return l.levelEasy;
      case 2: return l.levelMedium;
      case 3: return l.levelHard;
      default: return l.levelEasy;
    }
  }

  void _showWinSheet() {
    timer?.cancel();
    if (!mounted) return;
    final l = context.l10n;
    final bool hasNext = _currentLevel < 3;
    double rating = 3;
    final int finalTime = seconds;
    final int finalScore = score;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setSheetState) => Container(
          padding: EdgeInsets.fromLTRB(
            28, 20, 28,
            MediaQuery.of(ctx).padding.bottom + 28,
          ),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textFaint.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),

              // Level badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.35),
                  ),
                ),
                child: Text(
                  '${l.levelLabel} $_currentLevel  ·  ${_levelName(l)}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                '✦',
                style: TextStyle(color: AppColors.primaryLight, fontSize: 28),
              ),
              const SizedBox(height: 8),
              Text(
                l.sessionComplete,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),

              // Stats row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _StatPill(label: l.timeLabel, value: _formatTime(finalTime)),
                  const SizedBox(width: 12),
                  _StatPill(
                    label: l.scoreLabel,
                    value: '$finalScore',
                    highlight: true,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Divider(color: AppColors.textGhost, height: 1),
              const SizedBox(height: 20),

              // Rating
              Text(
                l.rateSession,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l.rateGameSub,
                style: TextStyle(color: AppColors.textFaint, fontSize: 13),
              ),
              const SizedBox(height: 18),
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 6),
                itemBuilder: (context, _) => const Icon(
                  Icons.star_rounded,
                  color: AppColors.primary,
                ),
                onRatingUpdate: (val) => setSheetState(() => rating = val),
              ),
              const SizedBox(height: 28),

              // Next Level button (levels 1 & 2)
              if (hasNext)
                _SheetButton(
                  label: l.nextLevel,
                  primary: true,
                  onTap: () {
                    Navigator.pop(ctx);
                    _initializeGame(level: _currentLevel + 1);
                  },
                ),
              if (hasNext) const SizedBox(height: 12),

              // Play Again button
              _SheetButton(
                label: hasNext ? l.playAgain : l.allLevelsDone,
                primary: !hasNext,
                onTap: () {
                  Navigator.pop(ctx);
                  _initializeGame();
                },
              ),
              const SizedBox(height: 12),

              // Exit
              GestureDetector(
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Text(
                  l.exitGame,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final size = MediaQuery.of(context).size;
    final double cardWidth = (size.width - 48) / 4;
    final double cardHeight = cardWidth * 1.25;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).popUntil((route) => route.isFirst),
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
                  const SizedBox(width: 12),

                  // Level badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      '${l.levelLabel} $_currentLevel · ${_levelName(l)}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Stats pill
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceDark,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        width: 1,
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Column(
                              children: [
                                Text(
                                  l.timeLabel,
                                  style: TextStyle(
                                    color: AppColors.textFaint,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  _formatTime(seconds),
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          VerticalDivider(
                            color: AppColors.textGhost,
                            thickness: 1,
                            width: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Column(
                              children: [
                                Text(
                                  l.scoreLabel,
                                  style: TextStyle(
                                    color: AppColors.textFaint,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '$score',
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Card grid
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: cardWidth / cardHeight,
                  ),
                  itemCount: cardColors.length,
                  itemBuilder: (context, index) {
                    return FlipCard(
                      key: cardKeys[index],
                      flipOnTouch: false,
                      direction: FlipDirection.HORIZONTAL,
                      front: GestureDetector(
                        onTap: () => _onCardTap(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.surfaceDark,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.22),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.question_mark_rounded,
                              color: AppColors.primary.withValues(alpha: 0.45),
                              size: 26,
                            ),
                          ),
                        ),
                      ),
                      back: Container(
                        decoration: BoxDecoration(
                          color: isMatched[index]
                              ? cardColors[index].withValues(alpha: 0.5)
                              : cardColors[index],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isMatched[index]
                                ? AppColors.primary.withValues(alpha: 0.6)
                                : AppColors.textHint,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: cardColors[index].withValues(alpha: 0.4),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            isMatched[index]
                                ? Icons.check_rounded
                                : Icons.star_rounded,
                            color: AppColors.textStrong,
                            size: 26,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Stat pill ────────────────────────────────────────────────────────────────

class _StatPill extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _StatPill({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: highlight
              ? AppColors.primary.withValues(alpha: 0.4)
              : AppColors.textGhost,
          width: 1.2,
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.textFaint,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: highlight ? AppColors.primary : AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Sheet button ─────────────────────────────────────────────────────────────

class _SheetButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool primary;

  const _SheetButton({
    required this.label,
    required this.onTap,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: primary ? AppColors.primaryLight : AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(26),
          border: primary
              ? null
              : Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  width: 1.5,
                ),
          boxShadow: primary
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: primary ? AppColors.surfaceDeep : AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
