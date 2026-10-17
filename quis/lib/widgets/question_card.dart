import 'package:flutter/material.dart';

import '../utils/responsive.dart';

class QuestionCard extends StatelessWidget {
  final int number;
  final int total;
  final String text;

  const QuestionCard({
    super.key,
    required this.number,
    required this.total,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(r.shortest * 0.05),
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: BorderRadius.circular(r.shortest * 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.help_outline, color: scheme.onPrimary, size: r.sp(20)),
              SizedBox(width: r.shortest * 0.02),
              Text(
                'Soal $number dari $total',
                style: TextStyle(
                  color: scheme.onPrimary.withValues(alpha: 0.85),
                  fontSize: r.sp(13),
                ),
              ),
            ],
          ),
          SizedBox(height: r.shortest * 0.03),
          Text(
            text,
            style: TextStyle(
              color: scheme.onPrimary,
              fontSize: r.sp(18),
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
