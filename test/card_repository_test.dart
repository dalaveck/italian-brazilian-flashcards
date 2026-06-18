import 'package:flutter_test/flutter_test.dart';
import 'package:italian_brazilian_flashcards/models/flashcard.dart';
import 'package:italian_brazilian_flashcards/state/card_repository.dart';

void main() {
  final repo = CardRepository.instance;

  group('cardsForSelection', () {
    test('filtra por módulo', () {
      final cores = repo.cardsForSelection({'cores'}, {});
      expect(cores, isNotEmpty);
      expect(cores.every((c) => c.moduleId == 'cores'), isTrue);
    });

    test('níveis vazio = todos os níveis', () {
      final all = repo.cardsForSelection({'abstratos'}, {});
      expect(all, isNotEmpty);
    });

    test('filtra por nível', () {
      final a1 = repo.cardsForSelection({'abstratos'}, {CefrLevel.a1});
      expect(a1, isEmpty, reason: 'abstratos são B2/C1, não A1');

      final b2 = repo.cardsForSelection({'abstratos'}, {CefrLevel.b2});
      expect(b2, isNotEmpty);
      expect(b2.every((c) => c.level == CefrLevel.b2), isTrue);
    });

    test('combina vários módulos e níveis', () {
      final cards = repo.cardsForSelection(
        {'cores', 'abstratos'},
        {CefrLevel.a1, CefrLevel.c1},
      );
      expect(cards.any((c) => c.moduleId == 'cores'), isTrue);
      expect(cards.any((c) => c.moduleId == 'abstratos'), isTrue);
      expect(
        cards.every((c) =>
            c.level == CefrLevel.a1 || c.level == CefrLevel.c1),
        isTrue,
      );
    });
  });
}
