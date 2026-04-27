import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:brainflow/core/constants/constants.dart';
import 'package:brainflow/core/l10n/app_localizations.dart';

class FlippingCardScreen extends StatefulWidget {
  const FlippingCardScreen({super.key});

  @override
  State<FlippingCardScreen> createState() => _FlippingCardScreenState();
}

class _FlippingCardScreenState extends State<FlippingCardScreen> {
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

  void _initializeGame() {
    timer?.cancel();
    seconds = 0;
    score = 0;
    isChecking = false;
    flippedIndices.clear();

    final List<Color> baseColors = List.from(AppColors.cardGameColors);

    cardColors = [...baseColors, ...baseColors];
    cardColors.shuffle();

    cardKeys = List.generate(
      cardColors.length,
      (_) => GlobalKey<FlipCardState>(),
    );
    isMatched = List.generate(cardColors.length, (_) => false);

    setState(() {});
    _startTimer();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => seconds++);
    });
  }

  String _formatTime(int totalSeconds) {
    final m = totalSeconds ~/ 60;
    final s = totalSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

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

    await Future.delayed(const Duration(seconds: 1));

    if (cardColors[i1] == cardColors[i2]) {
      setState(() {
        score += 10;
        isMatched[i1] = true;
        isMatched[i2] = true;
      });
      _playMatchSound();
      if (isMatched.every((e) => e)) _showWinDialog();
    } else {
      cardKeys[i1].currentState?.toggleCard();
      cardKeys[i2].currentState?.toggleCard();
      _playWrongSound();
    }

    flippedIndices.clear();
    isChecking = false;
  }

  void _showWinDialog() {
    timer?.cancel();
    final l = context.l10n;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        backgroundColor: AppColors.surfaceDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '✦',
                style: TextStyle(color: AppColors.primaryLight, fontSize: 32),
              ),
              const SizedBox(height: 12),
              Text(
                l.sessionComplete,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${l.timeLabelColon}${_formatTime(seconds)}',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${l.scoreLabelColon}$score',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.pop(ctx);
                  _initializeGame();
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      l.playAgain,
                      style: const TextStyle(
                        color: AppColors.surfaceDeep,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
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
                                horizontal: 20, vertical: 12),
                            child: Column(
                              children: [
                                Text(
                                  l.timeLabel,
                                  style: TextStyle(
                                    color:
                                        AppColors.textFaint,
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
                                    fontSize: 18,
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
                                horizontal: 20, vertical: 12),
                            child: Column(
                              children: [
                                Text(
                                  l.scoreLabel,
                                  style: TextStyle(
                                    color:
                                        AppColors.textFaint,
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
                                    fontSize: 18,
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

            // Grid
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
                              color: AppColors.primary
                                  .withValues(alpha: 0.22),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.question_mark_rounded,
                              color:
                                  AppColors.primary.withValues(alpha: 0.45),
                              size: 26,
                            ),
                          ),
                        ),
                      ),
                      back: Container(
                        decoration: BoxDecoration(
                          color: cardColors[index],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.textHint,
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
                            Icons.star_rounded,
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
