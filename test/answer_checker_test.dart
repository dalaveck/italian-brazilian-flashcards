import 'package:flutter_test/flutter_test.dart';
import 'package:italian_brazilian_flashcards/services/answer_checker.dart';

void main() {
  group('AnswerChecker', () {
    test('ignora maiúsculas e espaços', () {
      expect(AnswerChecker.isCorrect('  Casa ', ['casa']), isTrue);
      expect(AnswerChecker.isCorrect('CASA', ['casa']), isTrue);
    });

    test('ignora acentuação', () {
      expect(AnswerChecker.isCorrect('agua', ['água']), isTrue);
      expect(AnswerChecker.isCorrect('mae', ['mãe']), isTrue);
      expect(AnswerChecker.isCorrect('cafe', ['café']), isTrue);
    });

    test('aceita respostas alternativas', () {
      expect(
        AnswerChecker.isCorrect('olá', ['oi', 'olá', 'tchau']),
        isTrue,
      );
    });

    test('ignora artigo no início', () {
      expect(AnswerChecker.isCorrect('o livro', ['livro']), isTrue);
      expect(AnswerChecker.isCorrect('livro', ['o livro']), isTrue);
    });

    test('rejeita resposta errada', () {
      expect(AnswerChecker.isCorrect('cachorro', ['gato']), isFalse);
    });

    test('rejeita resposta vazia', () {
      expect(AnswerChecker.isCorrect('   ', ['casa']), isFalse);
    });
  });
}
