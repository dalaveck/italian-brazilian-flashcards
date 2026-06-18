import 'package:flutter_test/flutter_test.dart';
import 'package:italian_brazilian_flashcards/data/cards_tempos2.dart';

void main() {
  final all = {
    'kCardsPassatoRemoto': kCardsPassatoRemoto,
    'kCardsTrapassato': kCardsTrapassato,
    'kCardsFuturoAnteriore': kCardsFuturoAnteriore,
    'kCardsCondizionale': kCardsCondizionale,
    'kCardsCondizionalePassato': kCardsCondizionalePassato,
    'kCardsCongPresente': kCardsCongPresente,
    'kCardsCongImperfetto': kCardsCongImperfetto,
    'kCardsCongPassato': kCardsCongPassato,
    'kCardsCongTrapassato': kCardsCongTrapassato,
  };

  test('cada tempo tem perto de 1000 cartões', () {
    all.forEach((name, list) {
      expect(list.length, greaterThan(900), reason: name);
    });
  });

  test('congiuntivo usa "che" no italiano e "que" no português', () {
    for (final c in kCardsCongPresente) {
      expect(c.it.startsWith('che '), isTrue);
      expect(c.pt.startsWith('que '), isTrue);
    }
  });

  test('compostos usam auxiliar avere + particípio', () {
    for (final c in kCardsFuturoAnteriore) {
      expect(RegExp(r'\b(avrò|avrai|avrà|avremo|avrete|avranno)\b').hasMatch(c.it), isTrue);
    }
  });

  test('campos preenchidos', () {
    for (final list in all.values) {
      for (final c in list) {
        expect(c.it.trim(), isNotEmpty);
        expect(c.pt.trim(), isNotEmpty);
      }
    }
  });
}
