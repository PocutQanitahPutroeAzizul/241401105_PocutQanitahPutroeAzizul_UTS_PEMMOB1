import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/responsive.dart';
import '../widgets/primary_button.dart';
import 'quiz_screen.dart';

/// StatefulWidget karena memegang TextEditingController dan FormState.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: context.read<QuizProvider>().userName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    if (!_formKey.currentState!.validate()) return;
    context.read<QuizProvider>().start(_nameController.text);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const QuizScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = context.r;
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final logoSize = (r.shortest * 0.4).clamp(100.0, 260.0);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: isDark ? 'Mode terang' : 'Mode gelap',
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => context.read<ThemeProvider>().toggle(isDark),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(r.shortest * 0.06),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: r.maxContentWidth * 0.7),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: logoSize,
                      height: logoSize,
                    ),
                    SizedBox(height: r.shortest * 0.04),
                    Text(
                      'Kuis Flutter',
                      style: TextStyle(
                        fontSize: r.sp(30),
                        fontWeight: FontWeight.w700,
                        color: scheme.primary,
                      ),
                    ),
                    SizedBox(height: r.shortest * 0.02),
                    Text(
                      'Uji pemahamanmu tentang dasar-dasar Flutter.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: r.sp(14)),
                    ),
                    SizedBox(height: r.shortest * 0.08),
                    TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _startQuiz(),
                      style: TextStyle(fontSize: r.sp(16)),
                      decoration: InputDecoration(
                        labelText: 'Nama kamu',
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(r.shortest * 0.04),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nama tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: r.shortest * 0.05),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        label: 'Mulai Kuis',
                        icon: Icons.play_arrow_rounded,
                        onPressed: _startQuiz,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
