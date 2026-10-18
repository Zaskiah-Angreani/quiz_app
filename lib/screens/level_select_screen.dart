import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import 'quiz_screen.dart';

class LevelSelectScreen extends StatefulWidget {
  const LevelSelectScreen({super.key});

  @override
  State<LevelSelectScreen> createState() => _LevelSelectScreenState();
}

class _LevelSelectScreenState extends State<LevelSelectScreen> {
  String _selectedLevel = 'Mudah';

  void _startQuiz() {
    Provider.of<QuizProvider>(context, listen: false).setLevel(_selectedLevel);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const QuizScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isTabletOrWeb = mediaQuery.size.width > 600;
    final quizProvider = Provider.of<QuizProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Level', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(quizProvider.isThemeDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => quizProvider.toggleTheme(),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isTabletOrWeb ? mediaQuery.size.width * 0.25 : 24.0,
            vertical: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                ),
                child: Icon(
                  Icons.psychology_rounded,
                  size: isTabletOrWeb ? 90 : 65,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Halo, ${quizProvider.userName}!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: isTabletOrWeb ? 26 : 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Pilih tingkat kesulitan kuis yang ingin Anda selesaikan:',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: isTabletOrWeb ? 16 : 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),

              // Pilihan Level Card (Mudah)
              InkWell(
                onTap: () => setState(() => _selectedLevel = 'Mudah'),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: _selectedLevel == 'Mudah'
                        ? Colors.green.withOpacity(0.15)
                        : Theme.of(context).cardColor,
                    border: Border.all(
                      color: _selectedLevel == 'Mudah' ? Colors.green : Colors.grey.withOpacity(0.3),
                      width: _selectedLevel == 'Mudah' ? 2.5 : 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.sentiment_satisfied_alt_rounded, color: Colors.green, size: 32),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '🟢 Level Mudah',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '5 soal dasar seputar Flutter & Dart',
                              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      if (_selectedLevel == 'Mudah')
                        const Icon(Icons.check_circle, color: Colors.green),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Pilihan Level Card (Sulit)
              InkWell(
                onTap: () => setState(() => _selectedLevel = 'Sulit'),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: _selectedLevel == 'Sulit'
                        ? Colors.red.withOpacity(0.15)
                        : Theme.of(context).cardColor,
                    border: Border.all(
                      color: _selectedLevel == 'Sulit' ? Colors.red : Colors.grey.withOpacity(0.3),
                      width: _selectedLevel == 'Sulit' ? 2.5 : 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.local_fire_department_rounded, color: Colors.red, size: 32),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '🔴 Level Sulit',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '5 soal lanjutan seputar State & Architecture',
                              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      if (_selectedLevel == 'Sulit')
                        const Icon(Icons.check_circle, color: Colors.red),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              CustomButton(
                text: 'Mulai Kuis Sekarang',
                onPressed: _startQuiz,
              ),
            ],
          ),
        ),
      ),
    );
  }
}