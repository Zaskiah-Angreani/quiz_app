import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import 'level_select_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    super.dispose();
  }

  void _nextPage() {
    final name = _nameController.text.trim();
    final nim = _nimController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap masukkan nama Anda!')),
      );
      return;
    }

    if (nim.length != 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('NIM harus berisi tepat 9 digit angka!')),
      );
      return;
    }

    Provider.of<QuizProvider>(context, listen: false).setUserDetails(name, nim);

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LevelSelectScreen()),
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
              const SizedBox(height: 20),
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
              const SizedBox(height: 28),

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
              const SizedBox(height: 16),

              TextField(
                controller: _nimController,
                keyboardType: TextInputType.number,
                maxLength: 9,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: 'NIM (9 Digit)',
                  hintText: 'Contoh: 241401098',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.badge_outlined),
                  counterText: "",
                ),
                style: GoogleFonts.poppins(fontSize: isTabletOrWeb ? 18 : 14),
              ),
              const SizedBox(height: 24),

              CustomButton(
                text: 'Lanjut Pilih Level',
                onPressed: _nextPage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}