import 'package:flutter_test/flutter_test.dart';
import 'package:italian_brazilian_flashcards/data/cards_tempos.dart';

void main() {
  group('Tempos verbais', () {
    test('cada tempo tem ~1000 cartões', () {
      expect(kCardsPassato.length, greaterThan(900));
      expect(kCardsImperfetto.length, greaterThan(900));
      expect(kCardsFuturo.length, greaterThan(900));
      expect(kCardsImperativo.length, greaterThan(900));
    });

    test('tempos com 6 pessoas cobrem todos os pronomes', () {
      for (final list in [kCardsPassato, kCardsImperfetto, kCardsFuturo]) {
        for (final pron in ['io', 'tu', 'lui', 'noi', 'voi', 'loro']) {
          expect(list.any((c) => c.it.startsWith('$pron ')), isTrue,
              reason: 'falta "$pron"');
        }
      }
    });

    test('passato prossimo usa auxiliar avere', () {
      expect(kCardsPassato.every((c) => RegExp(r'\b(ho|hai|ha|abbiamo|avete|hanno)\b').hasMatch(c.it)), isTrue);
    });

    test('campos preenchidos e módulos corretos', () {
      final mods = {
        'verbos_passato': kCardsPassato,
        'verbos_imperfetto': kCardsImperfetto,
        'verbos_futuro': kCardsFuturo,
        'verbos_imperativo': kCardsImperativo,
      };
      mods.forEach((mod, list) {
        for (final c in list) {
          expect(c.moduleId, mod);
          expect(c.it.trim(), isNotEmpty);
          expect(c.pt.trim(), isNotEmpty);
        }
      });
    });
  });
}
