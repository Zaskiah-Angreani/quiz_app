import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final questions = quizProvider.questions;
    final userAnswers = quizProvider.userAnswers;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pembahasan Kuis', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          final userAnswer = userAnswers[index];
          final isCorrect = userAnswer == question.correctAnswerIndex;

          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: isCorrect ? Colors.green.shade100 : Colors.red.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isCorrect ? Icons.check : Icons.close,
                          color: isCorrect ? Colors.green : Colors.red,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '${index + 1}. ${question.questionText}',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),

                  // Jawaban Anda
                  Text(
                    'Jawaban Anda: ${userAnswer != null ? question.options[userAnswer] : "Tidak Dijawab"}',
                    style: GoogleFonts.poppins(
                      color: isCorrect ? Colors.green.shade700 : Colors.red.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  // Jika salah, tampilkan jawaban benar
                  if (!isCorrect) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Jawaban Benar: ${question.options[question.correctAnswerIndex]}',
                      style: GoogleFonts.poppins(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],

                  const SizedBox(height: 12),
                  // Penjelasan
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade800
                          : Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '💡 Penjelasan:',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          question.explanation,
                          style: GoogleFonts.poppins(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}