import 'package:flutter/material.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  String _userName = '';
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;
  bool _isThemeDark = true;

  // Dummy Data Pertanyaan Kuis
  final List<Question> _questions = [
    Question(
      id: 'q1',
      questionText: 'Apa nama framework UI buatan Google untuk pengembangan aplikasi lintas platform?',
      options: ['React Native', 'Flutter', 'Xamarin', 'Ionic'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 'q2',
      questionText: 'Bahasa pemrograman utama yang digunakan dalam pengembangan Flutter adalah...',
      options: ['Java', 'Kotlin', 'Dart', 'Swift'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'q3',
      questionText: 'Widget mana yang bersifat immutable (tidak mengalami perubahan state internal)?',
      options: ['StatefulWidget', 'StatelessWidget', 'InheritedWidget', 'Provider'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 'q4',
      questionText: 'File utama tempat konfigurasi dependensi dan aset dalam Flutter adalah...',
      options: ['build.gradle', 'AndroidManifest.xml', 'pubspec.yaml', 'index.html'],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 'q5',
      questionText: 'Metode mana yang dipanggil untuk memperbarui tampilan pada StatefulWidget?',
      options: ['setState()', 'build()', 'initState()', 'notifyListeners()'],
      correctAnswerIndex: 0,
    ),
  ];

  // Getters
  String get userName => _userName;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  int? get selectedAnswerIndex => _selectedAnswerIndex;
  List<Question> get questions => _questions;
  bool get isThemeDark => _isThemeDark;
  Question get currentQuestion => _questions[_currentQuestionIndex];

  // Logic Functions
  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void toggleTheme() {
    _isThemeDark = !_isThemeDark;
    notifyListeners();
  }

  void selectAnswer(int index) {
    _selectedAnswerIndex = index;
    notifyListeners();
  }

  bool nextQuestion() {
    if (_selectedAnswerIndex == currentQuestion.correctAnswerIndex) {
      _score += 20; // 5 Soal x 20 = 100 Poin
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _selectedAnswerIndex = null;
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _selectedAnswerIndex = null;
    notifyListeners();
  }
}