import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioScreen extends StatefulWidget {
  final String audioUrl;
  final String title;
  final String tag;
  final Color gradientStart;
  final Color gradientEnd;

  const AudioScreen({
    super.key,
    required this.audioUrl,
    required this.title,
    required this.tag,
    required this.gradientStart,
    required this.gradientEnd,
  });

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen>
    with TickerProviderStateMixin {
  final AudioPlayer _player = AudioPlayer();
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isPlaying = false;
  bool _isLoading = true;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;
  late AnimationController _rotateController;

  final List<StreamSubscription> _subs = [];

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );

    _subs.add(_player.onDurationChanged.listen((d) {
      if (mounted) setState(() => _duration = d);
    }));
    _subs.add(_player.onPositionChanged.listen((p) {
      if (mounted) setState(() => _position = p);
    }));
    _subs.add(_player.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      final playing = state == PlayerState.playing;
      setState(() => _isPlaying = playing);
      if (playing) {
        _pulseController.repeat(reverse: true);
        _rotateController.repeat();
      } else {
        _pulseController.stop();
        _rotateController.stop();
      }
    }));

    _init();
  }

  Future<void> _init() async {
    await _player.setSourceUrl(widget.audioUrl);
    if (mounted) setState(() => _isLoading = false);
    await _player.resume();
  }

  @override
  void dispose() {
    for (final s in _subs) {
      s.cancel();
    }
    _pulseController.dispose();
    _rotateController.dispose();
    _player.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (_isPlaying) {
      _player.pause();
    } else {
      _player.resume();
    }
  }

  void _seek(double value) {
    _player.seek(Duration(seconds: value.toInt()));
  }

  String _format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final maxSec = _duration.inSeconds > 0 ? _duration.inSeconds.toDouble() : 1.0;
    final curSec = _position.inSeconds.clamp(0, _duration.inSeconds).toDouble();

    return Scaffold(
      backgroundColor: const Color(0xFF0D0B1E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Back button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1C1A34),
                  ),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),

              const Spacer(),

              // Animated visualization
              Center(
                child: AnimatedBuilder(
                  animation: Listenable.merge([_pulseAnim, _rotateController]),
                  builder: (context, _) {
                    return SizedBox(
                      width: 260,
                      height: 260,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer ring
                          Transform.scale(
                            scale: _pulseAnim.value * 1.15,
                            child: Container(
                              width: 260,
                              height: 260,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: widget.gradientEnd
                                      .withValues(alpha: 0.12),
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                          // Mid ring
                          Transform.scale(
                            scale: _pulseAnim.value * 1.0,
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: widget.gradientEnd
                                      .withValues(alpha: 0.22),
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                          // Rotating arc decoration
                          Transform.rotate(
                            angle: _rotateController.value * 6.28,
                            child: Container(
                              width: 170,
                              height: 170,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: SweepGradient(
                                  colors: [
                                    widget.gradientEnd.withValues(alpha: 0.0),
                                    widget.gradientEnd.withValues(alpha: 0.35),
                                    widget.gradientEnd.withValues(alpha: 0.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Core circle
                          Transform.scale(
                            scale: _pulseAnim.value,
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    widget.gradientStart,
                                    widget.gradientEnd,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        widget.gradientEnd.withValues(alpha: 0.45),
                                    blurRadius: 40,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.graphic_eq_rounded,
                                color: Colors.white,
                                size: 48,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const Spacer(),

              // Tag + title
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: widget.gradientEnd.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.tag,
                  style: TextStyle(
                    color: widget.gradientEnd.withValues(alpha: 0.9),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'AUDIO COURSE',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.35),
                  fontSize: 11,
                  letterSpacing: 1.8,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 32),

              // Progress slider
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 3,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 6),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 14),
                  activeTrackColor: const Color(0xFFB8A8E8),
                  inactiveTrackColor:
                      Colors.white.withValues(alpha: 0.15),
                  thumbColor: const Color(0xFFCFC5F0),
                  overlayColor:
                      const Color(0xFFB8A8E8).withValues(alpha: 0.2),
                ),
                child: Slider(
                  value: curSec,
                  min: 0,
                  max: maxSec,
                  onChanged: _seek,
                ),
              ),

              // Time row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _format(_position),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _format(_duration),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Controls row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Rewind 15s
                  GestureDetector(
                    onTap: () => _player.seek(Duration(
                        seconds: (_position.inSeconds - 15).clamp(0, _duration.inSeconds))),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.07),
                      ),
                      child: const Icon(
                        Icons.replay_10_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),

                  const SizedBox(width: 24),

                  // Play / Pause
                  GestureDetector(
                    onTap: _isLoading ? null : _togglePlay,
                    child: Container(
                      width: 68,
                      height: 68,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFCFC5F0),
                      ),
                      child: _isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(20),
                              child: CircularProgressIndicator(
                                color: Color(0xFF1A1040),
                                strokeWidth: 2.5,
                              ),
                            )
                          : Icon(
                              _isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              color: const Color(0xFF1A1040),
                              size: 34,
                            ),
                    ),
                  ),

                  const SizedBox(width: 24),

                  // Forward 15s
                  GestureDetector(
                    onTap: () => _player.seek(Duration(
                        seconds: (_position.inSeconds + 15).clamp(0, _duration.inSeconds))),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.07),
                      ),
                      child: const Icon(
                        Icons.forward_10_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
