import 'package:flutter/material.dart';

import '../utils/responsive.dart';

class QuizProgressBar extends StatelessWidget {
  final int current; // 1-based
  final int total;

  const QuizProgressBar({super.key, required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    return ClipRRect(
      borderRadius: BorderRadius.circular(r.shortest * 0.02),
      child: LinearProgressIndicator(
        value: current / total,
        minHeight: r.shortest * 0.025,
      ),
    );
  }
}
