import 'package:flutter/material.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  String _userName = '';
  int _currentQuestionIndex = 0;
  bool _isThemeDark = true;

  // Menyimpan riwayat jawaban pengguna [indexSoal: indexJawaban]
  final Map<int, int> _userAnswers = {};

  final List<Question> _questions = [
    Question(
      id: 'q1',
      questionText: 'Apa nama framework UI buatan Google untuk pengembangan aplikasi lintas platform?',
      options: ['React Native', 'Flutter', 'Xamarin', 'Ionic'],
      correctAnswerIndex: 1,
      explanation: 'Flutter adalah SDK UI buatan Google yang memungkinkan pengembangan aplikasi lintas platform (Android, iOS, Web, Desktop) dari satu basis kode Dart.',
    ),
    Question(
      id: 'q2',
      questionText: 'Bahasa pemrograman utama yang digunakan dalam pengembangan Flutter adalah...',
      options: ['Java', 'Kotlin', 'Dart', 'Swift'],
      correctAnswerIndex: 2,
      explanation: 'Dart dikembangkan oleh Google dan dirancang khusus untuk membangun aplikasi UI yang cepat di berbagai platform.',
    ),
    Question(
      id: 'q3',
      questionText: 'Widget mana yang bersifat immutable (tidak mengalami perubahan state internal)?',
      options: ['StatefulWidget', 'StatelessWidget', 'InheritedWidget', 'Provider'],
      correctAnswerIndex: 1,
      explanation: 'StatelessWidget bersifat immutable (nilainya tidak berubah) dan tampilannya hanya bergantung pada konfigurasi awal yang diberikan.',
    ),
    Question(
      id: 'q4',
      questionText: 'File utama tempat konfigurasi dependensi dan aset dalam Flutter adalah...',
      options: ['build.gradle', 'AndroidManifest.xml', 'pubspec.yaml', 'index.html'],
      correctAnswerIndex: 2,
      explanation: 'File pubspec.yaml digunakan untuk mengelola paket dependensi, aset gambar, serta font kustom pada proyek Flutter.',
    ),
    Question(
      id: 'q5',
      questionText: 'Metode mana yang dipanggil untuk memperbarui tampilan pada StatefulWidget?',
      options: ['setState()', 'build()', 'initState()', 'notifyListeners()'],
      correctAnswerIndex: 0,
      explanation: 'Metode setState() memberi tahu framework bahwa state internal objek telah berubah, yang memicu pembentukan ulang (rebuild) UI.',
    ),
  ];

  // Getters
  String get userName => _userName;
  int get currentQuestionIndex => _currentQuestionIndex;
  List<Question> get questions => _questions;
  bool get isThemeDark => _isThemeDark;
  Question get currentQuestion => _questions[_currentQuestionIndex];
  Map<int, int> get userAnswers => _userAnswers;

  // Mengambil jawaban pengguna pada soal saat ini (bisa null jika belum dijawab)
  int? get selectedAnswerIndex => _userAnswers[_currentQuestionIndex];

  // Menghitung skor total
  int get score {
    int calculatedScore = 0;
    _userAnswers.forEach((qIndex, aIndex) {
      if (_questions[qIndex].correctAnswerIndex == aIndex) {
        calculatedScore += 20; // 5 soal x 20 = 100
      }
    });
    return calculatedScore;
  }

  // Setters & Actions
  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void toggleTheme() {
    _isThemeDark = !_isThemeDark;
    notifyListeners();
  }

  void selectAnswer(int index) {
    _userAnswers[_currentQuestionIndex] = index;
    notifyListeners();
  }

  bool nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
      return true;
    }
    return false; // Kuis selesai
  }

  bool previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
      return true;
    }
    return false;
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _userAnswers.clear();
    notifyListeners();
  }
}