import 'package:flutter_test/flutter_test.dart';
import 'package:italian_brazilian_flashcards/models/flashcard.dart';

void main() {
  group('Flashcard JSON', () {
    test('serializa e desserializa preservando os campos', () {
      const card = Flashcard(
        id: '42',
        moduleId: 'personalizados',
        it: 'gatto',
        pt: 'gato',
        ptAlt: ['bichano'],
        itAlt: ['micio'],
        hint: 'animal',
      );

      final restored = Flashcard.fromJson(card.toJson());

      expect(restored.id, '42');
      expect(restored.moduleId, 'personalizados');
      expect(restored.it, 'gatto');
      expect(restored.pt, 'gato');
      expect(restored.ptAlt, ['bichano']);
      expect(restored.itAlt, ['micio']);
      expect(restored.hint, 'animal');
      expect(restored.isCustom, isTrue);
    });

    test('cartão interno (sem id) não é custom', () {
      const card = Flashcard(moduleId: 'cores', it: 'rosso', pt: 'vermelho');
      expect(card.isCustom, isFalse);
    });

    test('tolera campos ausentes no JSON', () {
      final card = Flashcard.fromJson({'it': 'sole', 'pt': 'sol'});
      expect(card.it, 'sole');
      expect(card.pt, 'sol');
      expect(card.moduleId, 'personalizados');
      expect(card.itAlt, isEmpty);
    });
  });
}
