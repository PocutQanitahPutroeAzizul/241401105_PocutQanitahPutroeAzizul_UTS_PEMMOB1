import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../utils/responsive.dart';
import '../widgets/answer_option.dart';
import '../widgets/primary_button.dart';
import '../widgets/question_card.dart';
import '../widgets/quiz_progress_bar.dart';
import 'result_screen.dart';

/// StatelessWidget: seluruh state ada di QuizProvider,
/// sehingga progres aman saat layar dirotasi.
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  Future<void> _confirmExit(BuildContext context) async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar dari kuis?'),
        content: const Text('Progres jawabanmu akan di-reset jika kamu memulai ulang.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Lanjut Kuis'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
    if (leave == true && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final r = context.r;
    final question = quiz.currentQuestion;
    final selected = quiz.answerFor(quiz.currentIndex);

    final options = Column(
      children: List.generate(question.options.length, (i) {
        return AnswerOption(
          label: String.fromCharCode(65 + i),
          text: question.options[i],
          isSelected: selected == i,
          onTap: () => quiz.selectAnswer(i),
        );
      }),
    );

    final questionCard = QuestionCard(
      number: quiz.currentIndex + 1,
      total: quiz.total,
      text: question.text,
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmExit(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Halo, ${quiz.userName}',
            style: TextStyle(fontSize: r.sp(18), fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => _confirmExit(context),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: r.maxContentWidth),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      r.shortest * 0.05,
                      r.shortest * 0.02,
                      r.shortest * 0.05,
                      r.shortest * 0.03,
                    ),
                    child: QuizProgressBar(
                      current: quiz.currentIndex + 1,
                      total: quiz.total,
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // Layout adaptif: dua kolom jika layar lebar
                        // (tablet / landscape / web), satu kolom jika sempit.
                        final wide = constraints.maxWidth >= 700;
                        return SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: r.shortest * 0.05),
                          child: wide
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(child: questionCard),
                                    SizedBox(width: r.shortest * 0.04),
                                    Expanded(child: options),
                                  ],
                                )
                              : Column(
                                  children: [
                                    questionCard,
                                    SizedBox(height: r.shortest * 0.03),
                                    options,
                                  ],
                                ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(r.shortest * 0.04),
                    child: Row(
                      children: [
                        if (!quiz.isFirstQuestion)
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: quiz.previous,
                              icon: const Icon(Icons.arrow_back),
                              label: Text(
                                'Sebelumnya',
                                style: TextStyle(fontSize: r.sp(14)),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  vertical: r.shortest * 0.035,
                                ),
                              ),
                            ),
                          ),
                        if (!quiz.isFirstQuestion)
                          SizedBox(width: r.shortest * 0.03),
                        Expanded(
                          child: PrimaryButton(
                            label: quiz.isLastQuestion ? 'Selesai' : 'Lanjut',
                            icon: quiz.isLastQuestion
                                ? Icons.flag
                                : Icons.arrow_forward,
                            onPressed: quiz.hasAnsweredCurrent
                                ? () {
                                    if (quiz.isLastQuestion) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const ResultScreen(),
                                        ),
                                      );
                                    } else {
                                      quiz.next();
                                    }
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
