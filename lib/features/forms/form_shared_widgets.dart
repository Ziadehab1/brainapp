import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';

// ─── MCQ Option Tile ──────────────────────────────────────────────────────────

class FormMcqTile extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const FormMcqTile({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primaryDeep.withValues(alpha: 0.5)
              : AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? AppColors.primary.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.06),
            width: 1.5,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 10,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected
                      ? AppColors.primary
                      : Colors.white.withValues(alpha: 0.15),
                  border: Border.all(
                    color: selected
                        ? AppColors.primary
                        : Colors.white.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selected
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.7),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── MCQ Grid + "Other" text field ───────────────────────────────────────────

class FormMcqGrid extends StatelessWidget {
  final List<String> options;
  final Set<String> selected;
  final String? otherKey;
  final TextEditingController? otherController;
  final ValueChanged<String> onToggle;

  const FormMcqGrid({
    super.key,
    required this.options,
    required this.selected,
    required this.onToggle,
    this.otherKey,
    this.otherController,
  });

  @override
  Widget build(BuildContext context) {
    final showOther = otherKey != null &&
        otherController != null &&
        selected.contains(otherKey);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CHOOSE AS MANY AS APPLY',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.3,
          ),
        ),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.1,
          ),
          itemCount: options.length,
          itemBuilder: (_, i) {
            final opt = options[i];
            return FormMcqTile(
              label: opt,
              selected: selected.contains(opt),
              onTap: () => onToggle(opt),
            );
          },
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: showOther
              ? Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: FormOtherTextField(controller: otherController!),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

// ─── "Other / Something Else" expandable text field ──────────────────────────

class FormOtherTextField extends StatefulWidget {
  final TextEditingController controller;

  const FormOtherTextField({super.key, required this.controller});

  @override
  State<FormOtherTextField> createState() => _FormOtherTextFieldState();
}

class _FormOtherTextFieldState extends State<FormOtherTextField> {
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
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: widget.controller,
            maxLines: 3,
            minLines: 3,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Describe...',
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.25),
                fontSize: 14,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${widget.controller.text.length} CHARS',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.3),
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
