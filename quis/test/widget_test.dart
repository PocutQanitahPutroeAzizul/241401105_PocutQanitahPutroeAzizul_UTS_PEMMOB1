import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:quis/main.dart';
import 'package:quis/providers/quiz_provider.dart';
import 'package:quis/providers/theme_provider.dart';

Widget _buildApp() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => QuizProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ],
    child: const QuizApp(),
  );
}

void main() {
  testWidgets('Home menolak nama kosong lalu membuka kuis jika nama diisi',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(900, 1800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_buildApp());

    expect(find.text('Kuis Flutter'), findsOneWidget);
    expect(find.text('Mulai Kuis'), findsOneWidget);

    // Nama kosong -> muncul pesan validasi.
    await tester.ensureVisible(find.text('Mulai Kuis'));
    await tester.tap(find.text('Mulai Kuis'));
    await tester.pump();
    expect(find.text('Nama tidak boleh kosong'), findsOneWidget);

    // Nama diisi -> pindah ke halaman kuis.
    await tester.enterText(find.byType(TextFormField), 'Budi');
    await tester.ensureVisible(find.text('Mulai Kuis'));
    await tester.tap(find.text('Mulai Kuis'));
    await tester.pumpAndSettle();

    expect(find.text('Halo, Budi'), findsOneWidget);
    expect(find.textContaining('Soal 1 dari'), findsOneWidget);
  });
}
