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
    final isFirstQuestion = quizProvider.currentQuestionIndex == 0;
    final isLastQuestion =
        quizProvider.currentQuestionIndex == quizProvider.questions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Soal ${quizProvider.currentQuestionIndex + 1} / ${quizProvider.questions.length}',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
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
              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: (quizProvider.currentQuestionIndex + 1) /
                      quizProvider.questions.length,
                  minHeight: 10,
                ),
              ),
              const SizedBox(height: 20),

              // Card Pertanyaan
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  currentQuestion.questionText,
                  style: GoogleFonts.poppins(
                    fontSize: isTabletOrWeb ? 20 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // List Pilihan Jawaban
              Expanded(
                child: ListView.builder(
                  itemCount: currentQuestion.options.length,
                  itemBuilder: (context, index) {
                    return OptionCard(
                      optionText: currentQuestion.options[index],
                      isSelected: quizProvider.selectedAnswerIndex == index,
                      onTap: () {
                        quizProvider.selectAnswer(index);
                        // Notifikasi Umpan Balik Jawaban Disimpan
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(Icons.check_circle, color: Colors.white, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  'Jawaban tersimpan!',
                                  style: GoogleFonts.poppins(fontSize: 13),
                                ),
                              ],
                            ),
                            backgroundColor: Colors.green.shade600,
                            duration: const Duration(milliseconds: 1000),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // Tombol Navigasi (Kembali & Selanjutnya)
              Row(
                children: [
                  if (!isFirstQuestion) ...[
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => quizProvider.previousQuestion(),
                        child: Text(
                          'Kembali',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      text: isLastQuestion ? 'Lihat Hasil' : 'Selanjutnya',
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}