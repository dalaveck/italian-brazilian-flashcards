import 'dart:math';

import 'package:flutter/foundation.dart';

import '../models/flashcard.dart';
import '../services/answer_checker.dart';
import 'card_repository.dart';
import 'quiz_config.dart';

/// Resultado da avaliação da última resposta enviada.
class AnswerOutcome {
  AnswerOutcome({
    required this.correct,
    required this.given,
    required this.expected,
    required this.pointsAwarded,
  });

  final bool correct;
  final String given;
  final String expected;
  final int pointsAwarded;
}

/// Gerencia o andamento de uma sessão de flashcards.
class QuizSession extends ChangeNotifier {
  QuizSession(this.config) {
    _build();
  }

  final QuizConfig config;

  final List<Question> _questions = [];
  int _index = 0;
  int _score = 0;
  int _correct = 0;
  int _streak = 0;
  int _bestStreak = 0;

  final Stopwatch _stopwatch = Stopwatch();
  AnswerOutcome? _lastOutcome;
  bool _finished = false;

  // ---- getters ----
  List<Question> get questions => List.unmodifiable(_questions);
  int get total => _questions.length;
  int get index => _index;
  int get position => _index + 1;
  int get score => _score;
  int get correct => _correct;
  int get streak => _streak;
  int get bestStreak => _bestStreak;
  bool get finished => _finished;
  AnswerOutcome? get lastOutcome => _lastOutcome;
  bool get answered => _lastOutcome != null;
  Question? get current => _index < _questions.length ? _questions[_index] : null;
  Duration get elapsed => _stopwatch.elapsed;

  double get accuracy => total == 0 ? 0 : _correct / total;

  /// Pontos base por acerto.
  static const int kBasePoints = 100;

  void _build() {
    final cards = CardRepository.instance.cardsForModules(config.moduleIds);
    final rng = Random();
    final pool = List<Flashcard>.from(cards);
    if (config.shuffle) {
      pool.shuffle(rng);
    }

    var selected = pool;
    if (config.questionCount > 0 && config.questionCount < pool.length) {
      selected = pool.sublist(0, config.questionCount);
    }

    for (final card in selected) {
      late bool askingItalian;
      switch (config.direction) {
        case Direction.itToPt:
          askingItalian = false;
          break;
        case Direction.ptToIt:
          askingItalian = true;
          break;
        case Direction.mixed:
          askingItalian = rng.nextBool();
          break;
      }
      _questions.add(Question(card: card, askingItalian: askingItalian));
    }

    if (config.timerEnabled) {
      _stopwatch.start();
    }
  }

  /// Avalia a resposta digitada para a pergunta atual.
  AnswerOutcome submit(String given) {
    final question = current;
    if (question == null || _lastOutcome != null) {
      return _lastOutcome ??
          AnswerOutcome(
            correct: false,
            given: given,
            expected: '',
            pointsAwarded: 0,
          );
    }

    final isCorrect =
        AnswerChecker.isCorrect(given, question.acceptedAnswers);

    var points = 0;
    if (isCorrect) {
      _correct++;
      _streak++;
      _bestStreak = max(_bestStreak, _streak);
      points = kBasePoints;
      // bônus de sequência: +10 por acerto consecutivo (a partir do 2º)
      if (_streak > 1) {
        points += (_streak - 1) * 10;
      }
      // bônus de velocidade quando o cronômetro está ativo
      if (config.timerEnabled) {
        points += 10;
      }
      _score += points;
    } else {
      _streak = 0;
    }

    _lastOutcome = AnswerOutcome(
      correct: isCorrect,
      given: given,
      expected: question.answer,
      pointsAwarded: points,
    );
    notifyListeners();
    return _lastOutcome!;
  }

  /// Avança para a próxima pergunta (ou finaliza a sessão).
  void next() {
    if (_lastOutcome == null) return;
    _lastOutcome = null;
    if (_index < _questions.length - 1) {
      _index++;
    } else {
      _finish();
    }
    notifyListeners();
  }

  /// Pula a pergunta atual sem responder (conta como erro).
  void skip() {
    final question = current;
    if (question == null || _lastOutcome != null) return;
    _streak = 0;
    _lastOutcome = AnswerOutcome(
      correct: false,
      given: '',
      expected: question.answer,
      pointsAwarded: 0,
    );
    notifyListeners();
  }

  void _finish() {
    if (_stopwatch.isRunning) _stopwatch.stop();
    _finished = true;
  }

  /// Encerra antecipadamente (ao sair da sessão).
  void abort() {
    if (_stopwatch.isRunning) _stopwatch.stop();
  }
}
