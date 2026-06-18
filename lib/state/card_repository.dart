import 'package:flutter/foundation.dart';

import '../data/decks.dart';
import '../models/flashcard.dart';
import '../services/custom_card_store.dart';

/// Fonte única de cartões: combina os cartões internos do app (`kAllCards`)
/// com os cartões criados e salvos pelo usuário.
class CardRepository extends ChangeNotifier {
  CardRepository._();

  /// Instância global compartilhada.
  static final CardRepository instance = CardRepository._();

  final CustomCardStore _store = CustomCardStore();
  List<Flashcard> _custom = [];
  bool _loaded = false;

  bool get loaded => _loaded;
  List<Flashcard> get customCards => List.unmodifiable(_custom);

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

  /// Todos os cartões (internos + do usuário) que estão nos módulos e níveis
  /// selecionados. Um conjunto de níveis vazio significa "todos os níveis".
  List<Flashcard> cardsForSelection(
    Set<String> moduleIds,
    Set<CefrLevel> levels,
  ) {
    return [...kAllCards, ..._custom]
        .where((c) => moduleIds.contains(c.moduleId))
        .where((c) => levels.isEmpty || levels.contains(c.level))
        .toList();
  }

  /// Quantos cartões do usuário existem em um módulo.
  int customCountForModule(String moduleId) {
    return _custom.where((c) => c.moduleId == moduleId).length;
  }
}
