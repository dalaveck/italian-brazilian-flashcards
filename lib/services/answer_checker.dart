/// Normaliza e compara respostas digitadas pelo usuário.
///
/// A comparação ignora maiúsculas/minúsculas, acentuação, pontuação simples,
/// espaços extras e artigos definidos/indefinidos no início da resposta.
class AnswerChecker {
  static const Map<String, String> _accents = {
    'á': 'a', 'à': 'a', 'â': 'a', 'ã': 'a', 'ä': 'a',
    'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
    'í': 'i', 'ì': 'i', 'î': 'i', 'ï': 'i',
    'ó': 'o', 'ò': 'o', 'ô': 'o', 'õ': 'o', 'ö': 'o',
    'ú': 'u', 'ù': 'u', 'û': 'u', 'ü': 'u',
    'ç': 'c', 'ñ': 'n',
  };

  /// Artigos ignorados no início da resposta para tornar a checagem tolerante.
  static const Set<String> _leadingArticles = {
    // italiano
    'il', 'lo', 'la', 'i', 'gli', 'le', 'un', 'uno', 'una',
    // português
    'o', 'a', 'os', 'as', 'um', 'uma',
  };

  static String normalize(String input) {
    final buffer = StringBuffer();
    for (final ch in input.toLowerCase().trim().split('')) {
      buffer.write(_accents[ch] ?? ch);
    }
    var s = buffer.toString();
    // remove pontuação comum
    s = s.replaceAll(RegExp(r"[?!.,;:_/\\\-]"), ' ');
    s = s.replaceAll("'", ' ');
    // colapsa espaços
    s = s.replaceAll(RegExp(r'\s+'), ' ').trim();
    return s;
  }

  static String _stripLeadingArticle(String normalized) {
    final parts = normalized.split(' ');
    if (parts.length > 1 && _leadingArticles.contains(parts.first)) {
      return parts.sublist(1).join(' ');
    }
    return normalized;
  }

  /// Retorna `true` se [given] corresponde a alguma das [accepted].
  static bool isCorrect(String given, List<String> accepted) {
    final g = normalize(given);
    if (g.isEmpty) return false;
    final gNoArticle = _stripLeadingArticle(g);
    for (final a in accepted) {
      final n = normalize(a);
      if (g == n) return true;
      if (gNoArticle == _stripLeadingArticle(n)) return true;
    }
    return false;
  }
}
