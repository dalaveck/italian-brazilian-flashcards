import 'package:flutter/material.dart';

import 'i18n/app_locale.dart';
import 'screens/home_screen.dart';
import 'state/card_repository.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Carrega os cartões salvos e o idioma da interface antes de exibir a tela.
  await CardRepository.instance.load();
  await AppLocale.instance.load();
  runApp(const FlashcardsApp());
}

class FlashcardsApp extends StatelessWidget {
  const FlashcardsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Reconstrói toda a árvore ao trocar o idioma da interface.
    return AnimatedBuilder(
      animation: AppLocale.instance,
      builder: (context, _) => MaterialApp(
        title: 'Flashcards Italiano ⇄ Português',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        home: const HomeScreen(),
      ),
    );
  }
}
