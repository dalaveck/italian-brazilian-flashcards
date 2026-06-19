// GERADO por tools/gen_module_counts.py — não edite à mão.
// Rode `python3 tools/gen_module_counts.py` após alterar os cartões.

import '../models/flashcard.dart';

/// Contagem de cartões internos por módulo e nível CEFR.
///
/// Permite à HomeScreen mostrar quantos cartões existem na seleção sem
/// carregar os decks pesados (que ficam atrás de imports `deferred` em
/// `card_repository.dart`). Não inclui os cartões do usuário.
const Map<String, Map<CefrLevel, int>> kModuleCardCounts = {
  'abstratos': {CefrLevel.b2: 21, CefrLevel.c1: 18},
  'adjetivos': {CefrLevel.a1: 15, CefrLevel.a2: 12, CefrLevel.b2: 16, CefrLevel.c1: 10},
  'adverbios': {CefrLevel.b1: 14},
  'animais': {CefrLevel.a2: 15},
  'artigos': {CefrLevel.a1: 12},
  'casa': {CefrLevel.a2: 19},
  'comida': {CefrLevel.a1: 14, CefrLevel.b1: 15},
  'compras': {CefrLevel.a2: 11},
  'conjuncoes': {CefrLevel.b1: 12, CefrLevel.c1: 7},
  'cores': {CefrLevel.a1: 12},
  'corpo': {CefrLevel.a2: 17},
  'educacao': {CefrLevel.b1: 17},
  'emocoes': {CefrLevel.a2: 11, CefrLevel.b2: 9},
  'essenciais': {CefrLevel.a1: 205, CefrLevel.a2: 349, CefrLevel.b1: 326, CefrLevel.b2: 123, CefrLevel.c1: 10},
  'expressoes': {CefrLevel.c1: 21},
  'familia': {CefrLevel.a1: 12},
  'lugares': {CefrLevel.a2: 17},
  'natureza': {CefrLevel.b1: 25},
  'numeros': {CefrLevel.a1: 13},
  'preposicoes': {CefrLevel.a1: 15},
  'profissoes': {CefrLevel.a2: 10, CefrLevel.b2: 15},
  'roupas': {CefrLevel.a2: 14},
  'saudacoes': {CefrLevel.a1: 13},
  'saude': {CefrLevel.b1: 14},
  'substantivos': {CefrLevel.a1: 15},
  'tecnologia': {CefrLevel.b1: 13},
  'tempo': {CefrLevel.a1: 14},
  'transporte': {CefrLevel.a2: 10},
  'verbos_avancados': {CefrLevel.b1: 18, CefrLevel.b2: 18, CefrLevel.c1: 14},
  'verbos_condizionale': {CefrLevel.b1: 1104},
  'verbos_condizionale_passato': {CefrLevel.b2: 1104},
  'verbos_cong_imperfetto': {CefrLevel.b2: 1104},
  'verbos_cong_passato': {CefrLevel.c1: 1104},
  'verbos_cong_presente': {CefrLevel.b2: 1104},
  'verbos_cong_trapassato': {CefrLevel.c1: 1104},
  'verbos_conjugacao': {CefrLevel.a2: 384, CefrLevel.b1: 768},
  'verbos_futuro': {CefrLevel.b1: 1104},
  'verbos_futuro_anteriore': {CefrLevel.b2: 1104},
  'verbos_imperativo': {CefrLevel.b1: 920},
  'verbos_imperfetto': {CefrLevel.b1: 1104},
  'verbos_infinitivo': {CefrLevel.a1: 18, CefrLevel.a2: 20},
  'verbos_passato': {CefrLevel.b1: 1104},
  'verbos_passato_remoto': {CefrLevel.b2: 960},
  'verbos_presente': {CefrLevel.a1: 16},
  'verbos_trapassato': {CefrLevel.b1: 1104},
};
