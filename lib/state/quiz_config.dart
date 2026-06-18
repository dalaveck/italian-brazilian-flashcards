import '../models/flashcard.dart';

/// Configuração escolhida na tela inicial antes de iniciar a sessão.
class QuizConfig {
  QuizConfig({
    required this.moduleIds,
    required this.direction,
    required this.questionCount,
    required this.timerEnabled,
    required this.shuffle,
  });

  /// Módulos selecionados.
  final Set<String> moduleIds;

  /// Sentido da tradução.
  final Direction direction;

  /// Quantidade de perguntas (0 = todas as disponíveis).
  final int questionCount;

  /// Se o cronômetro deve correr durante a sessão.
  final bool timerEnabled;

  /// Embaralhar a ordem das perguntas.
  final bool shuffle;
}
