import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import 'review_screen.dart';
import 'welcome_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isTabletOrWeb = mediaQuery.size.width > 600;
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isTabletOrWeb ? mediaQuery.size.width * 0.25 : 24.0,
            vertical: 24.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber.withOpacity(0.15),
                ),
                child: Icon(
                  Icons.emoji_events_rounded,
                  size: isTabletOrWeb ? 110 : 80,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Kuis Selesai!',
                style: GoogleFonts.poppins(
                  fontSize: isTabletOrWeb ? 32 : 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Kerja Bagus, ${quizProvider.userName}!',
                style: GoogleFonts.poppins(
                  fontSize: isTabletOrWeb ? 20 : 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Skor Akhir Anda',
                      style: GoogleFonts.poppins(
                        fontSize: isTabletOrWeb ? 18 : 15,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${quizProvider.score}',
                      style: GoogleFonts.poppins(
                        fontSize: isTabletOrWeb ? 64 : 52,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(
                      'dari 100 poin',
                      style: GoogleFonts.poppins(
                        fontSize: isTabletOrWeb ? 16 : 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Tombol Lihat Pembahasan
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ReviewScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.analytics_outlined),
                  label: Text(
                    'Lihat Pembahasan / Detail Jawaban',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Tombol Coba Lagi
              CustomButton(
                text: 'Coba Lagi',
                onPressed: () {
                  quizProvider.resetQuiz();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}