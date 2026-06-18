/// Nível de proficiência (CEFR/QECR) do cartão.
enum CefrLevel { a1, a2, b1, b2, c1 }

extension CefrLevelLabel on CefrLevel {
  /// Rótulo curto em maiúsculas (ex.: `A1`).
  String get label => name.toUpperCase();

  /// Nome do nível em português.
  String get description {
    switch (this) {
      case CefrLevel.a1:
        return 'A1 · Iniciante';
      case CefrLevel.a2:
        return 'A2 · Básico';
      case CefrLevel.b1:
        return 'B1 · Intermediário';
      case CefrLevel.b2:
        return 'B2 · Intermediário avançado';
      case CefrLevel.c1:
        return 'C1 · Avançado';
    }
  }
}

CefrLevel cefrFromName(String? name) {
  return CefrLevel.values.firstWhere(
    (l) => l.name == name,
    orElse: () => CefrLevel.a1,
  );
}

/// Um cartão de estudo (flashcard) bilíngue italiano <-> português.
class Flashcard {
  const Flashcard({
    required this.moduleId,
    required this.it,
    required this.pt,
    this.level = CefrLevel.a1,
    this.itAlt = const [],
    this.ptAlt = const [],
    this.hint,
    this.id,
  });

  /// Id do módulo a que o cartão pertence (ex.: `verbos_presente`).
  final String moduleId;

  /// Nível CEFR (A1–C1).
  final CefrLevel level;

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

  /// Identificador único. Presente apenas em cartões criados pelo usuário;
  /// `null` para os cartões internos do app.
  final String? id;

  /// `true` quando o cartão foi criado pelo usuário (tem [id]).
  bool get isCustom => id != null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'moduleId': moduleId,
        'level': level.name,
        'it': it,
        'pt': pt,
        'itAlt': itAlt,
        'ptAlt': ptAlt,
        'hint': hint,
      };

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    List<String> asList(dynamic v) =>
        (v as List?)?.map((e) => e.toString()).toList() ?? const [];
    return Flashcard(
      id: json['id'] as String?,
      moduleId: json['moduleId'] as String? ?? 'personalizados',
      level: cefrFromName(json['level'] as String?),
      it: json['it'] as String? ?? '',
      pt: json['pt'] as String? ?? '',
      itAlt: asList(json['itAlt']),
      ptAlt: asList(json['ptAlt']),
      hint: json['hint'] as String?,
    );
  }
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
