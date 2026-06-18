import 'package:flutter_test/flutter_test.dart';
import 'package:italian_brazilian_flashcards/data/cards_conjugacoes.dart';

void main() {
  group('Conjugações', () {
    test('mais de 1000 cartões de conjugação', () {
      expect(kCardsConjugacoes.length, greaterThan(1000));
    });

    test('todas as 6 pessoas verbais estão presentes', () {
      for (final pron in ['io', 'tu', 'lui', 'noi', 'voi', 'loro']) {
        expect(
          kCardsConjugacoes.any((c) => c.it.startsWith('$pron ')),
          isTrue,
          reason: 'falta a pessoa "$pron"',
        );
      }
    });

    test('todos têm módulo e campos preenchidos', () {
      for (final c in kCardsConjugacoes) {
        expect(c.moduleId, 'verbos_conjugacao');
        expect(c.it.trim(), isNotEmpty);
        expect(c.pt.trim(), isNotEmpty);
      }
    });
  });
}
