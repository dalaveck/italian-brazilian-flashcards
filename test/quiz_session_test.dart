import 'package:flutter_test/flutter_test.dart';
import 'package:italian_brazilian_flashcards/models/flashcard.dart';
import 'package:italian_brazilian_flashcards/state/quiz_config.dart';
import 'package:italian_brazilian_flashcards/state/quiz_session.dart';

void main() {
  QuizSession buildSession({int count = 5, Direction dir = Direction.itToPt}) {
    return QuizSession(
      QuizConfig(
        moduleIds: {'cores'},
        direction: dir,
        questionCount: count,
        timerEnabled: false,
        shuffle: false,
      ),
    );
  }

  test('cria o número correto de perguntas', () {
    final s = buildSession(count: 5);
    expect(s.total, 5);
    expect(s.position, 1);
  });

  test('acerto soma pontos e avança', () {
    final s = buildSession(count: 3);
    final q = s.current!;
    final outcome = s.submit(q.answer);
    expect(outcome.correct, isTrue);
    expect(s.score, greaterThanOrEqualTo(QuizSession.kBasePoints));
    expect(s.correct, 1);
    s.next();
    expect(s.position, 2);
  });

  test('erro zera a sequência e não pontua', () {
    final s = buildSession(count: 2);
    final outcome = s.submit('resposta totalmente errada xyz');
    expect(outcome.correct, isFalse);
    expect(s.score, 0);
    expect(s.streak, 0);
  });

  test('finaliza após a última pergunta', () {
    final s = buildSession(count: 2);
    for (var i = 0; i < 2; i++) {
      s.submit(s.current!.answer);
      s.next();
    }
    expect(s.finished, isTrue);
    expect(s.accuracy, 1.0);
  });
}
