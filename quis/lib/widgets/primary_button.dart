import 'package:flutter/material.dart';

import '../utils/responsive.dart';

/// Tombol utama yang dipakai di semua halaman.
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: r.shortest * 0.035,
          horizontal: r.shortest * 0.06,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(r.shortest * 0.04),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: r.sp(20)),
            SizedBox(width: r.shortest * 0.02),
          ],
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: r.sp(16), fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
