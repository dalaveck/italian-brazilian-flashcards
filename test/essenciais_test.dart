import 'package:flutter_test/flutter_test.dart';
import 'package:italian_brazilian_flashcards/data/cards_essenciais.dart';

void main() {
  group('Vocabulário essencial', () {
    test('mais de 1000 cartões', () {
      expect(kCardsEssenciais.length, greaterThan(1000));
    });

    test('inclui singular e plural', () {
      bool has(String it) => kCardsEssenciais.any((c) => c.it == it);
      expect(has('uomo'), isTrue);
      expect(has('uomini'), isTrue);
      expect(has('città'), isTrue); // invariável
      expect(has('animale'), isTrue);
      expect(has('animali'), isTrue);
    });

    test('todos no módulo essenciais com campos preenchidos', () {
      for (final c in kCardsEssenciais) {
        expect(c.moduleId, 'essenciais');
        expect(c.it.trim(), isNotEmpty);
        expect(c.pt.trim(), isNotEmpty);
      }
    });
  });
}
