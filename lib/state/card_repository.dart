import 'package:flutter/foundation.dart';

import '../data/decks.dart';
import '../data/module_card_counts.dart';
import '../models/flashcard.dart';
import '../services/custom_card_store.dart';

// Decks GERADOS e grandes (~3 MB de fonte). Importados como `deferred` para
// que o Dart os emita em chunks JS separados, baixados só quando uma sessão
// começa (ver `ensureDecksLoaded`) — assim o primeiro acesso à página não
// carrega esse volume todo.
import '../data/cards_conjugacoes.dart' deferred as conjugacoes;
import '../data/cards_essenciais.dart' deferred as essenciais;
import '../data/cards_tempos.dart' deferred as tempos;
import '../data/cards_tempos2.dart' deferred as tempos2;

/// Fonte única de cartões: combina os cartões internos do app (`kAllCards`)
/// com os cartões criados e salvos pelo usuário.
class CardRepository extends ChangeNotifier {
  CardRepository._();

  /// Instância global compartilhada.
  static final CardRepository instance = CardRepository._();

  final CustomCardStore _store = CustomCardStore();
  List<Flashcard> _custom = [];
  bool _loaded = false;

  // Decks pesados, preenchidos sob demanda por [ensureDecksLoaded].
  List<Flashcard> _heavy = const [];
  bool _decksLoaded = false;

  bool get loaded => _loaded;
  bool get decksLoaded => _decksLoaded;
  List<Flashcard> get customCards => List.unmodifiable(_custom);

  /// Carrega (uma única vez) os decks gerados pesados via `loadLibrary()`.
  ///
  /// Deve ser chamado antes de montar uma sessão de quiz (ver `QuizScreen`).
  /// Idempotente: chamadas seguintes retornam imediatamente.
  Future<void> ensureDecksLoaded() async {
    if (_decksLoaded) return;
    await Future.wait([
      conjugacoes.loadLibrary(),
      essenciais.loadLibrary(),
      tempos.loadLibrary(),
      tempos2.loadLibrary(),
    ]);
    _heavy = [
      ...conjugacoes.kCardsConjugacoes,
      ...essenciais.kCardsEssenciais,
      ...tempos.kCardsPassato,
      ...tempos.kCardsImperfetto,
      ...tempos.kCardsFuturo,
      ...tempos.kCardsImperativo,
      ...tempos2.kCardsPassatoRemoto,
      ...tempos2.kCardsTrapassato,
      ...tempos2.kCardsFuturoAnteriore,
      ...tempos2.kCardsCondizionale,
      ...tempos2.kCardsCondizionalePassato,
      ...tempos2.kCardsCongPresente,
      ...tempos2.kCardsCongImperfetto,
      ...tempos2.kCardsCongPassato,
      ...tempos2.kCardsCongTrapassato,
    ];
    _decksLoaded = true;
  }

  /// Carrega os cartões do usuário do armazenamento (idempotente).
  Future<void> load() async {
    _custom = await _store.load();
    _loaded = true;
    notifyListeners();
  }

  /// Adiciona um cartão do usuário e persiste.
  Future<void> add(Flashcard card) async {
    _custom = [..._custom, card];
    await _store.save(_custom);
    notifyListeners();
  }

  /// Atualiza um cartão existente (mesmo [Flashcard.id]) e persiste.
  Future<void> update(Flashcard card) async {
    _custom = _custom.map((c) => c.id == card.id ? card : c).toList();
    await _store.save(_custom);
    notifyListeners();
  }

  /// Remove um cartão do usuário pelo id e persiste.
  Future<void> remove(String id) async {
    _custom = _custom.where((c) => c.id != id).toList();
    await _store.save(_custom);
    notifyListeners();
  }

  /// Todos os cartões (internos leves + pesados + do usuário) que estão nos
  /// módulos e níveis selecionados. Um conjunto de níveis vazio significa
  /// "todos os níveis".
  ///
  /// Os decks pesados só entram no resultado depois de [ensureDecksLoaded];
  /// chame-o antes de montar a sessão.
  List<Flashcard> cardsForSelection(
    Set<String> moduleIds,
    Set<CefrLevel> levels,
  ) {
    return [...kAllCards, ..._heavy, ..._custom]
        .where((c) => moduleIds.contains(c.moduleId))
        .where((c) => levels.isEmpty || levels.contains(c.level))
        .toList();
  }

  /// Quantos cartões existem na seleção, SEM carregar os decks pesados.
  ///
  /// Usa a contagem estática pré-gerada ([kModuleCardCounts]) para os cartões
  /// internos e percorre apenas os cartões do usuário (lista pequena). Assim a
  /// tela inicial mostra o total sem baixar os chunks `deferred`.
  int countForSelection(Set<String> moduleIds, Set<CefrLevel> levels) {
    var total = 0;
    for (final id in moduleIds) {
      final byLevel = kModuleCardCounts[id];
      if (byLevel == null) continue;
      for (final entry in byLevel.entries) {
        if (levels.isEmpty || levels.contains(entry.key)) {
          total += entry.value;
        }
      }
    }
    for (final c in _custom) {
      if (moduleIds.contains(c.moduleId) &&
          (levels.isEmpty || levels.contains(c.level))) {
        total++;
      }
    }
    return total;
  }

  /// Quantos cartões do usuário existem em um módulo.
  int customCountForModule(String moduleId) {
    return _custom.where((c) => c.moduleId == moduleId).length;
  }
}
