import 'package:flutter/material.dart';

import '../utils/responsive.dart';

/// Satu pilihan jawaban. Dipakai berulang untuk setiap opsi di setiap soal.
class AnswerOption extends StatelessWidget {
  final String label;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerOption({
    super.key,
    required this.label,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(r.shortest * 0.04);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: r.shortest * 0.015),
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(r.shortest * 0.04),
          decoration: BoxDecoration(
            color: isSelected ? scheme.primaryContainer : scheme.surfaceContainerHighest,
            border: Border.all(
              color: isSelected ? scheme.primary : scheme.outlineVariant,
              width: 2,
            ),
            borderRadius: radius,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: r.sp(16),
                backgroundColor: isSelected ? scheme.primary : scheme.secondaryContainer,
                foregroundColor: isSelected ? scheme.onPrimary : scheme.onSecondaryContainer,
                child: Text(
                  label,
                  style: TextStyle(fontSize: r.sp(14), fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(width: r.shortest * 0.035),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(fontSize: r.sp(15)),
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle, color: scheme.primary, size: r.sp(22)),
            ],
          ),
        ),
      ),
    );
  }
}
