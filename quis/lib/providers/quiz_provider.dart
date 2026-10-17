import 'package:flutter/foundation.dart';

import '../data/questions_data.dart';
import '../models/question.dart';

/// State kuis disimpan di sini (di atas MaterialApp), sehingga progres
/// jawaban tidak hilang saat layar dirotasi atau berpindah halaman.
class QuizProvider extends ChangeNotifier {
  final List<Question> questions = quizQuestions;

  String _userName = '';
  int _currentIndex = 0;
  final Map<int, int> _answers = {}; // indeks soal -> indeks jawaban

  String get userName => _userName;
  int get currentIndex => _currentIndex;
  int get total => questions.length;
  Question get currentQuestion => questions[_currentIndex];
  bool get isFirstQuestion => _currentIndex == 0;
  bool get isLastQuestion => _currentIndex == total - 1;
  bool get hasAnsweredCurrent => _answers.containsKey(_currentIndex);
  int get answeredCount => _answers.length;

  int? answerFor(int questionIndex) => _answers[questionIndex];

  int get score {
    int result = 0;
    _answers.forEach((q, a) {
      if (questions[q].correctIndex == a) result++;
    });
    return result;
  }

  /// Mulai percobaan baru dengan nama pengguna.
  void start(String name) {
    _userName = name.trim();
    _currentIndex = 0;
    _answers.clear();
    notifyListeners();
  }

  void selectAnswer(int optionIndex) {
    _answers[_currentIndex] = optionIndex;
    notifyListeners();
  }

  void next() {
    if (_currentIndex < total - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previous() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  /// Ulangi kuis dengan nama yang sama.
  void reset() {
    _currentIndex = 0;
    _answers.clear();
    notifyListeners();
  }
}
