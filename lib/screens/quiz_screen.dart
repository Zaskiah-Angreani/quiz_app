import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/option_card.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isTabletOrWeb = mediaQuery.size.width > 600;
    final quizProvider = Provider.of<QuizProvider>(context);
    final currentQuestion = quizProvider.currentQuestion;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Soal ${quizProvider.currentQuestionIndex + 1} dari ${quizProvider.questions.length}',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(quizProvider.isThemeDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => quizProvider.toggleTheme(),
          )
        ],
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          padding: EdgeInsets.all(isTabletOrWeb ? 32.0 : 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: (quizProvider.currentQuestionIndex + 1) /
                      quizProvider.questions.length,
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                currentQuestion.questionText,
                style: GoogleFonts.poppins(
                  fontSize: isTabletOrWeb ? 22 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: currentQuestion.options.length,
                  itemBuilder: (context, index) {
                    return OptionCard(
                      optionText: currentQuestion.options[index],
                      isSelected: quizProvider.selectedAnswerIndex == index,
                      onTap: () => quizProvider.selectAnswer(index),
                    );
                  },
                ),
              ),
              CustomButton(
                text: quizProvider.currentQuestionIndex ==
                    quizProvider.questions.length - 1
                    ? 'Lihat Hasil'
                    : 'Pertanyaan Selanjutnya',
                onPressed: quizProvider.selectedAnswerIndex == null
                    ? () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Silakan pilih jawaban terlebih dahulu!'),
                    ),
                  );
                }
                    : () {
                  bool hasNext = quizProvider.nextQuestion();
                  if (!hasNext) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const ResultScreen(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}