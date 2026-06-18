/// Um cartão de estudo (flashcard) bilíngue italiano <-> português.
class Flashcard {
  const Flashcard({
    required this.moduleId,
    required this.it,
    required this.pt,
    this.itAlt = const [],
    this.ptAlt = const [],
    this.hint,
  });

  /// Id do módulo a que o cartão pertence (ex.: `verbos_presente`).
  final String moduleId;

  /// Forma em italiano.
  final String it;

  /// Forma em português brasileiro.
  final String pt;

  /// Respostas alternativas aceitas quando o alvo é o italiano.
  final List<String> itAlt;

  /// Respostas alternativas aceitas quando o alvo é o português.
  final List<String> ptAlt;

  /// Dica opcional mostrada sob demanda.
  final String? hint;
}

/// Sentido da pergunta no jogo.
enum Direction {
  itToPt, // mostra italiano, digita português
  ptToIt, // mostra português, digita italiano
  mixed, // alterna aleatoriamente
}

extension DirectionLabel on Direction {
  String get label {
    switch (this) {
      case Direction.itToPt:
        return 'Italiano → Português';
      case Direction.ptToIt:
        return 'Português → Italiano';
      case Direction.mixed:
        return 'Misto (aleatório)';
    }
  }

  String get shortLabel {
    switch (this) {
      case Direction.itToPt:
        return 'IT → PT';
      case Direction.ptToIt:
        return 'PT → IT';
      case Direction.mixed:
        return 'Misto';
    }
  }
}

/// Uma pergunta concretizada a partir de um [Flashcard] em um sentido fixo.
class Question {
  Question({
    required this.card,
    required this.askingItalian,
  });

  final Flashcard card;

  /// Quando `true`, a resposta esperada está em italiano (mostramos o português).
  final bool askingItalian;

  /// Texto exibido (a "frente" do cartão).
  String get prompt => askingItalian ? card.pt : card.it;

  /// Idioma exibido na frente.
  String get promptLang => askingItalian ? 'Português' : 'Italiano';

  /// Idioma esperado na resposta.
  String get answerLang => askingItalian ? 'Italiano' : 'Português';

  /// Resposta canônica esperada.
  String get answer => askingItalian ? card.it : card.pt;

  /// Todas as respostas aceitas (canônica + alternativas).
  List<String> get acceptedAnswers => askingItalian
      ? [card.it, ...card.itAlt]
      : [card.pt, ...card.ptAlt];
}
