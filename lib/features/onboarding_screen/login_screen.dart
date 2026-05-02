import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brainflow/core/constants/constants.dart';
import 'package:brainflow/core/l10n/app_localizations.dart';
import 'package:brainflow/core/services/local/storage_keys.dart';
import 'package:brainflow/features/onboarding_screen/onboarding_Signup_screen/onboarding_Signup_screen.dart';
import 'package:brainflow/features/onboarding_screen/select_interest.dart';
import 'package:brainflow/features/home_screen/home_screen.dart';

class AppLoginScreen extends StatefulWidget {
  const AppLoginScreen({super.key});

  @override
  State<AppLoginScreen> createState() => _AppLoginScreenState();
}

class _AppLoginScreenState extends State<AppLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.fillAllFields),
          backgroundColor: AppColors.surface,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 400));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(StorageKeys.isLoggedIn, true);
    final interestsDone =
        prefs.getBool(StorageKeys.interestsSelected) ?? false;

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (interestsDone) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(showFocusRatingAfterDelay: true),
        ),
        (_) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const InterestSelectionScreen()),
        (_) => false,
      );
    }
  }

  void _onSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const OnboardingSignupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.backgroundOnboarding,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Brain icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primaryLighter, AppColors.primaryMuted],
                  ),
                ),
                child: const Center(child: _SmallBrainIcon()),
              ),

              const SizedBox(height: 32),

              Text(
                l.welcomeBack,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l.signInToContinue,
                style: TextStyle(color: AppColors.textMuted, fontSize: 14),
              ),

              const SizedBox(height: 40),

              // Email
              _FieldLabel(l.emailAddress),
              const SizedBox(height: 8),
              _InputField(
                controller: _emailController,
                hint: l.emailHint,
                prefixIcon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // Password
              _FieldLabel(l.password),
              const SizedBox(height: 8),
              _InputField(
                controller: _passwordController,
                hint: l.passwordHint,
                prefixIcon: Icons.lock_outline,
                obscure: !_passwordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.textIcon,
                    size: 20,
                  ),
                  onPressed: () =>
                      setState(() => _passwordVisible = !_passwordVisible),
                ),
              ),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 8),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    l.forgotPassword,
                    style: TextStyle(
                      color: AppColors.primaryLight,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Login button
              GestureDetector(
                onTap: _isLoading ? null : _onLogin,
                child: Container(
                  width: double.infinity,
                  height: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.primaryLight,
                  ),
                  child: _isLoading
                      ? const Center(
                          child: SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: AppColors.surfaceDeep,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              l.signIn,
                              style: const TextStyle(
                                color: AppColors.surfaceDeep,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward,
                              color: AppColors.surfaceDeep,
                              size: 18,
                            ),
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 24),

              // Divider
              Row(
                children: [
                  Expanded(
                    child: Divider(color: AppColors.borderFaint, thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: AppColors.textDim,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: AppColors.borderFaint, thickness: 1),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Sign up button
              GestureDetector(
                onTap: _onSignUp,
                child: Container(
                  width: double.infinity,
                  height: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.surfaceOnboarding,
                    border: Border.all(
                      color: AppColors.borderFaint,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l.noAccount,
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        l.signUp,
                        style: TextStyle(
                          color: AppColors.primaryLight,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.textMuted,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.1,
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final bool obscure;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: AppColors.surfaceOnboarding,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.textHint, fontSize: 15),
          prefixIcon: Icon(prefixIcon, color: AppColors.textIcon, size: 20),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}

class _SmallBrainIcon extends StatelessWidget {
  const _SmallBrainIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(32, 32),
      painter: _BrainPainter(),
    );
  }
}

class _BrainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.surfaceDeep
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final path = Path();

    path.moveTo(cx, cy - 1);
    path.cubicTo(cx - 2, cy - 9, cx - 11, cy - 10, cx - 11, cy - 3);
    path.cubicTo(cx - 11, cy + 4, cx - 6, cy + 7, cx - 2, cy + 8);
    path.lineTo(cx, cy + 8);
    path.moveTo(cx - 4, cy - 2);
    path.cubicTo(cx - 7, cy - 4, cx - 9, cy - 1, cx - 6, cy + 2);
    path.moveTo(cx - 2, cy + 2);
    path.cubicTo(cx - 5, cy + 3, cx - 7, cy + 5, cx - 4, cy + 7);
    path.moveTo(cx, cy - 1);
    path.cubicTo(cx + 2, cy - 9, cx + 11, cy - 10, cx + 11, cy - 3);
    path.cubicTo(cx + 11, cy + 4, cx + 6, cy + 7, cx + 2, cy + 8);
    path.lineTo(cx, cy + 8);
    path.moveTo(cx + 4, cy - 2);
    path.cubicTo(cx + 7, cy - 4, cx + 9, cy - 1, cx + 6, cy + 2);
    path.moveTo(cx + 2, cy + 2);
    path.cubicTo(cx + 5, cy + 3, cx + 7, cy + 5, cx + 4, cy + 7);
    path.moveTo(cx, cy - 1);
    path.lineTo(cx, cy + 8);
    path.moveTo(cx - 3, cy + 8);
    path.lineTo(cx + 3, cy + 8);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BrainPainter old) => false;
}
