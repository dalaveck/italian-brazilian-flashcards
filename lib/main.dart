import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'state/card_repository.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Carrega os cartões salvos pelo usuário antes de exibir a interface.
  await CardRepository.instance.load();
  runApp(const FlashcardsApp());
}

class FlashcardsApp extends StatelessWidget {
  const FlashcardsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcards Italiano ⇄ Português',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const HomeScreen(),
    );
  }
}
