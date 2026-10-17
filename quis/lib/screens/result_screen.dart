import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../utils/responsive.dart';
import '../widgets/primary_button.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  String _message(double percent) {
    if (percent >= 0.8) return 'Luar biasa!';
    if (percent >= 0.5) return 'Bagus, terus belajar!';
    return 'Jangan menyerah, coba lagi!';
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final r = context.r;
    final scheme = Theme.of(context).colorScheme;
    final percent = quiz.score / quiz.total;
    final ringSize = (r.shortest * 0.45).clamp(120.0, 260.0);

    final summary = Column(
      children: [
        Text(
          _message(percent),
          style: TextStyle(fontSize: r.sp(22), fontWeight: FontWeight.w700),
        ),
        SizedBox(height: r.shortest * 0.01),
        Text(
          'Skor akhir ${quiz.userName}',
          style: TextStyle(fontSize: r.sp(14)),
        ),
        SizedBox(height: r.shortest * 0.05),
        SizedBox(
          width: ringSize,
          height: ringSize,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: percent,
                strokeWidth: ringSize * 0.1,
                backgroundColor: scheme.surfaceContainerHighest,
              ),
              Center(
                child: Text(
                  '${quiz.score}/${quiz.total}',
                  style: TextStyle(
                    fontSize: r.sp(32),
                    fontWeight: FontWeight.w700,
                    color: scheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: r.shortest * 0.03),
        Text(
          '${(percent * 100).round()}% jawaban benar',
          style: TextStyle(fontSize: r.sp(14)),
        ),
        SizedBox(height: r.shortest * 0.05),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
                icon: const Icon(Icons.home_outlined),
                label: Text('Beranda', style: TextStyle(fontSize: r.sp(14))),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: r.shortest * 0.035),
                ),
              ),
            ),
            SizedBox(width: r.shortest * 0.03),
            Expanded(
              child: PrimaryButton(
                label: 'Ulangi',
                icon: Icons.refresh,
                onPressed: () {
                  quiz.reset();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const QuizScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );

    final review = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Review Jawaban',
          style: TextStyle(fontSize: r.sp(16), fontWeight: FontWeight.w600),
        ),
        SizedBox(height: r.shortest * 0.02),
        ...List.generate(quiz.total, (i) {
          final q = quiz.questions[i];
          final answer = quiz.answerFor(i);
          final correct = answer == q.correctIndex;
          return Card(
            margin: EdgeInsets.only(bottom: r.shortest * 0.025),
            child: Padding(
              padding: EdgeInsets.all(r.shortest * 0.035),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    correct ? Icons.check_circle : Icons.cancel,
                    color: correct ? Colors.green : scheme.error,
                    size: r.sp(24),
                  ),
                  SizedBox(width: r.shortest * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${i + 1}. ${q.text}',
                          style: TextStyle(
                            fontSize: r.sp(13),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: r.shortest * 0.01),
                        if (!correct && answer != null)
                          Text(
                            'Jawabanmu: ${q.options[answer]}',
                            style: TextStyle(
                              fontSize: r.sp(12),
                              color: scheme.error,
                            ),
                          ),
                        Text(
                          'Jawaban benar: ${q.options[q.correctIndex]}',
                          style: TextStyle(fontSize: r.sp(12)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Kuis')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: r.maxContentWidth),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 700;
                return SingleChildScrollView(
                  padding: EdgeInsets.all(r.shortest * 0.05),
                  child: wide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: summary),
                            SizedBox(width: r.shortest * 0.05),
                            Expanded(child: review),
                          ],
                        )
                      : Column(
                          children: [
                            summary,
                            SizedBox(height: r.shortest * 0.06),
                            review,
                          ],
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
