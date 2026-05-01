import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:brainflow/core/constants/constants.dart';
import 'package:brainflow/features/home_screen/home_screen.dart';

class AppIntroVideoScreen extends StatefulWidget {
  const AppIntroVideoScreen({super.key});

  @override
  State<AppIntroVideoScreen> createState() => _AppIntroVideoScreenState();
}

class _AppIntroVideoScreenState extends State<AppIntroVideoScreen> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _showControls = true;
  bool _navigating = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _controller = VideoPlayerController.asset(
      'assets/tutorials/app_intro/app_intro.mp4',
    )..initialize().then((_) {
        if (!mounted) return;
        setState(() => _initialized = true);
        _controller.play();
        _scheduleHide();
      });

    _controller.addListener(_onVideoUpdate);
  }

  void _onVideoUpdate() {
    if (!mounted) return;
    setState(() {});

    if (_initialized &&
        _controller.value.position >= _controller.value.duration &&
        !_controller.value.isPlaying &&
        !_navigating) {
      _goHome();
    }
  }

  void _scheduleHide() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && _showControls) {
        setState(() => _showControls = false);
      }
    });
  }

  void _onTap() {
    setState(() => _showControls = !_showControls);
    if (_showControls) _scheduleHide();
  }

  void _togglePlay() {
    _controller.value.isPlaying ? _controller.pause() : _controller.play();
    if (_controller.value.isPlaying) _scheduleHide();
  }

  // Called on both natural end and user close — HomeScreen handles the 1-min delay
  void _goHome() {
    if (_navigating) return;
    _navigating = true;
    _controller.pause();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const HomeScreen(showFocusRatingAfterDelay: true),
        ),
        (_) => false,
      );
    }
  }

  String _format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void dispose() {
    _controller.removeListener(_onVideoUpdate);
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Video ──────────────────────────────────────────────────────
            Center(
              child: _initialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : const CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2.5,
                    ),
            ),

            // ── Controls overlay ───────────────────────────────────────────
            AnimatedOpacity(
              opacity: _showControls ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 250),
              child: IgnorePointer(
                ignoring: !_showControls,
                child: Stack(
                  children: [
                    // Gradient scrim — top
                    Positioned(
                      top: 0, left: 0, right: 0,
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.65),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Gradient scrim — bottom
                    Positioned(
                      bottom: 0, left: 0, right: 0,
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.65),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Close (✕) button — top-right
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 14,
                      right: 16,
                      child: GestureDetector(
                        onTap: _goHome,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withValues(alpha: 0.55),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                    // Center play / pause
                    if (_initialized)
                      Center(
                        child: GestureDetector(
                          onTap: _togglePlay,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withValues(alpha: 0.5),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.5),
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 34,
                            ),
                          ),
                        ),
                      ),

                    // Progress bar + timestamps
                    if (_initialized)
                      Positioned(
                        bottom: 0, left: 0, right: 0,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            20, 0, 20,
                            MediaQuery.of(context).padding.bottom + 20,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              VideoProgressIndicator(
                                _controller,
                                allowScrubbing: true,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                colors: VideoProgressColors(
                                  playedColor: AppColors.primaryLight,
                                  bufferedColor:
                                      Colors.white.withValues(alpha: 0.25),
                                  backgroundColor:
                                      Colors.white.withValues(alpha: 0.1),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _format(_controller.value.position),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    _format(_controller.value.duration),
                                    style: TextStyle(
                                      color: Colors.white
                                          .withValues(alpha: 0.6),
                                      fontSize: 12,
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
          ],
        ),
      ),
    );
  }
}
