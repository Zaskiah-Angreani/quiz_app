import 'package:flutter/material.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  String _userName = '';
  String _studentId = '';
  String _selectedLevel = 'Mudah';
  int _currentQuestionIndex = 0;
  bool _isThemeDark = true;

  final Map<int, int> _userAnswers = {};

  final List<Question> _allQuestions = [
    // --- SOAL LEVEL MUDAH ---
    Question(
      id: 'm1',
      questionText: 'Bahasa pemrograman utama yang digunakan dalam Flutter adalah...',
      options: ['Java', 'Kotlin', 'Dart', 'Swift'],
      correctAnswerIndex: 2,
      explanation: 'Dart adalah bahasa pemrograman utama yang digunakan untuk membangun aplikasi Flutter.',
    ),
    Question(
      id: 'm2',
      questionText: 'Perusahaan yang mengandalkan dan mengembangkan Flutter adalah...',
      options: ['Facebook', 'Google', 'Microsoft', 'Apple'],
      correctAnswerIndex: 1,
      explanation: 'Flutter dikembangkan dan dipelihara secara aktif oleh Google.',
    ),
    Question(
      id: 'm3',
      questionText: 'Widget yang tampilannya TIDAK dapat berubah secara dinamis dinamakan...',
      options: ['StatefulWidget', 'StatelessWidget', 'InheritedWidget', 'Provider'],
      correctAnswerIndex: 1,
      explanation: 'StatelessWidget bersifat immutable (nilainya tidak berubah secara dinamis saat runtime).',
    ),
    Question(
      id: 'm4',
      questionText: ' File konfigurasi utama untuk mendaftarkan dependensi paket adalah...',
      options: ['build.gradle', 'AndroidManifest.xml', 'pubspec.yaml', 'main.dart'],
      correctAnswerIndex: 2,
      explanation: 'File pubspec.yaml digunakan untuk mengatur dependensi paket, font, dan aset gambar.',
    ),
    Question(
      id: 'm5',
      questionText: 'Perintah CLI untuk mengunduh paket dependensi baru adalah...',
      options: ['flutter run', 'flutter pub get', 'flutter build', 'flutter clean'],
      correctAnswerIndex: 1,
      explanation: 'Perintah flutter pub get digunakan untuk mengunduh semua paket yang tertulis di pubspec.yaml.',
    ),

    // --- SOAL LEVEL SULIT ---
    Question(
      id: 's1',
      questionText: 'Metode mana yang dipanggil sekali saat StatefulWidget pertama kali dibuat?',
      options: ['build()', 'setState()', 'initState()', 'dispose()'],
      correctAnswerIndex: 2,
      explanation: 'initState() dipanggil sekali saja ketika objek state pertama kali dimasukkan ke dalam tree.',
    ),
    Question(
      id: 's2',
      questionText: 'Konsep mana yang digunakan Provider untuk memberitahu UI agar dirender ulang?',
      options: ['ChangeNotifier', 'StreamController', 'FutureBuilder', 'StatefulElement'],
      correctAnswerIndex: 0,
      explanation: 'ChangeNotifier memanggil notifyListeners() untuk memberitahu para listener (UI) agar melakukan rebuild.',
    ),
    Question(
      id: 's3',
      questionText: 'Pohon (Tree) mana yang mengelola lokasi fisik dan ukuran layout di Flutter?',
      options: ['Widget Tree', 'Element Tree', 'RenderObject Tree', 'State Tree'],
      correctAnswerIndex: 2,
      explanation: 'RenderObject Tree bertanggung jawab menangani kalkulasi ukuran (layout) dan menggambar UI (painting).',
    ),
    Question(
      id: 's4',
      questionText: 'Keyword Dart mana yang digunakan untuk variabel yang nilainya konstan saat compile-time?',
      options: ['final', 'const', 'var', 'late'],
      correctAnswerIndex: 1,
      explanation: 'const menetapkan nilai konstan yang sudah diketahui sejak proses kompilasi (compile-time).',
    ),
    Question(
      id: 's5',
      questionText: 'Widget mana yang paling tepat digunakan untuk membuat daftar item tak terhingga (lazy loading)?',
      options: ['Column', 'SingleChildScrollView', 'ListView.builder', 'Row'],
      correctAnswerIndex: 2,
      explanation: 'ListView.builder hanya merender item yang muncul di layar saja (efisien untuk daftar panjang).',
    ),
  ];

  // Getters
  String get userName => _userName;
  String get studentId => _studentId;
  String get selectedLevel => _selectedLevel;
  int get currentQuestionIndex => _currentQuestionIndex;
  bool get isThemeDark => _isThemeDark;
  Map<int, int> get userAnswers => _userAnswers;

  List<Question> get questions {
    return _allQuestions.where((q) {
      if (_selectedLevel == 'Mudah') {
        return q.questionText.startsWith('[Mudah]');
      } else {
        return q.questionText.startsWith('[Sulit]');
      }
    }).toList();
  }

  Question get currentQuestion => questions[_currentQuestionIndex];

  int get score {
    int calculatedScore = 0;
    _userAnswers.forEach((qIndex, aIndex) {
      if (questions[qIndex].correctAnswerIndex == aIndex) {
        calculatedScore += 20;
      }
    });
    return calculatedScore;
  }

  int? get selectedAnswerIndex => _userAnswers[_currentQuestionIndex];

  // Setters
  void setUserDetails(String name, String nim) {
    _userName = name;
    _studentId = nim;
    notifyListeners();
  }

  void setLevel(String level) {
    _selectedLevel = level;
    _userAnswers.clear();
    _currentQuestionIndex = 0;
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
    if (_currentQuestionIndex < questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
      return true;
    }
    return false;
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