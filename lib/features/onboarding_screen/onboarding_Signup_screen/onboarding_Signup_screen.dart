import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:brainflow/core/constants/constants.dart';
import 'package:brainflow/core/l10n/app_localizations.dart';
import 'package:brainflow/features/onboarding_screen/select_interest.dart';

class OnboardingSignupScreen extends StatefulWidget {
  const OnboardingSignupScreen({super.key});

  @override
  State<OnboardingSignupScreen> createState() => _OnboardingSignupScreenState();
}

class _OnboardingSignupScreenState extends State<OnboardingSignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _selectedGender = '';
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  bool get _has8Chars => _passwordController.text.length >= 8;
  bool get _hasUppercase => _passwordController.text.contains(RegExp(r'[A-Z]'));
  bool get _hasDigit => _passwordController.text.contains(RegExp(r'[0-9]'));

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
              Text(
                l.createProfile,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l.joinJourney,
                style: TextStyle(color: AppColors.textMuted, fontSize: 14),
              ),
              const SizedBox(height: 32),

              // Full Name
              _FieldLabel(l.fullName),
              const SizedBox(height: 8),
              _InputField(
                controller: _nameController,
                hint: l.fullNameHint,
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 20),

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

              // Region + Phone
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FieldLabel(l.region),
                      const SizedBox(height: 8),
                      Container(
                        height: 54,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceOnboarding,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: CountryCodePicker(
                          onChanged: (_) {},
                          initialSelection: 'US',
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                          textStyle: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                          ),
                          dialogTextStyle: const TextStyle(color: Colors.black),
                          searchStyle: const TextStyle(color: Colors.black),
                          flagDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          dialogBackgroundColor: Colors.white,
                          barrierColor: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _FieldLabel(l.phoneNumber),
                        const SizedBox(height: 8),
                        _InputField(
                          controller: _phoneController,
                          hint: l.phoneHint,
                          prefixIcon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Gender
              _FieldLabel(l.selectGender),
              const SizedBox(height: 8),
              _GenderSelector(
                selected: _selectedGender,
                onChanged: (v) => setState(() => _selectedGender = v),
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
              const SizedBox(height: 12),
              _PasswordRequirement(met: _has8Chars,    label: l.req8Chars),
              const SizedBox(height: 6),
              _PasswordRequirement(met: _hasUppercase, label: l.reqUppercase),
              const SizedBox(height: 6),
              _PasswordRequirement(met: _hasDigit,     label: l.reqDigit),
              const SizedBox(height: 20),

              // Confirm Password
              _FieldLabel(l.confirmPassword),
              const SizedBox(height: 8),
              _InputField(
                controller: _confirmPasswordController,
                hint: l.confirmPasswordHint,
                prefixIcon: Icons.lock_outline,
                obscure: !_confirmPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _confirmPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.textIcon,
                    size: 20,
                  ),
                  onPressed: () => setState(
                      () => _confirmPasswordVisible = !_confirmPasswordVisible),
                ),
              ),
              const SizedBox(height: 32),

              // Create Account button
              _CreateAccountButton(onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const InterestSelectionScreen(),
                  ),
                );
              }),
              const SizedBox(height: 24),
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
          hintStyle: TextStyle(
            color: AppColors.textHint,
            fontSize: 15,
          ),
          prefixIcon: Icon(prefixIcon, color: AppColors.textIcon, size: 20),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}

class _GenderSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const _GenderSelector({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _GenderOption(
            label: context.l10n.male,
            selected: selected == 'Male',
            onTap: () => onChanged('Male'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _GenderOption(
            label: context.l10n.female,
            selected: selected == 'Female',
            onTap: () => onChanged('Female'),
          ),
        ),
      ],
    );
  }
}

class _GenderOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _GenderOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.surfaceOnboarding,
          borderRadius: BorderRadius.circular(14),
          border: selected
              ? Border.all(color: AppColors.primary, width: 1.5)
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.primary : AppColors.textIcon,
                  width: 1.5,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: selected ? AppColors.textPrimary : AppColors.textSecondary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordRequirement extends StatelessWidget {
  final bool met;
  final String label;

  const _PasswordRequirement({required this.met, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: met
                ? AppColors.primary.withValues(alpha: 0.2)
                : Colors.transparent,
            border: Border.all(
              color: met ? AppColors.primary : AppColors.textDisabled,
              width: 1.5,
            ),
          ),
          child: met
              ? const Icon(Icons.check, color: AppColors.primary, size: 10)
              : null,
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            color: met ? AppColors.textSecondary : AppColors.textIcon,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CreateAccountButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.surfaceMedium,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.l10n.createAccount,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.chevron_right, color: AppColors.textPrimary, size: 20),
          ],
        ),
      ),
    );
  }
}
