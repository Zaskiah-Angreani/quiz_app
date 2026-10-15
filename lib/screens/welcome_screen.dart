import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import 'quiz_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap masukkan nama Anda terlebih dahulu!')),
      );
      return;
    }

    Provider.of<QuizProvider>(context, listen: false)
        .setUserName(_nameController.text.trim());

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
        title: Text('QuizVerse', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(quizProvider.isThemeDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => quizProvider.toggleTheme(),
            tooltip: 'Ganti Tema',
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
                  Icons.extension_rounded,
                  size: isTabletOrWeb ? 100 : 70,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Selamat Datang di Mobile Quiz!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: isTabletOrWeb ? 28 : 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Uji kemampuan dasar Pemrograman Mobile & Flutter Anda.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: isTabletOrWeb ? 16 : 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Peserta',
                  hintText: 'Masukkan nama Anda...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                style: GoogleFonts.poppins(fontSize: isTabletOrWeb ? 18 : 14),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Mulai Kuis',
                onPressed: _startQuiz,
              ),
            ],
          ),
        ),
      ),
    );
  }
}