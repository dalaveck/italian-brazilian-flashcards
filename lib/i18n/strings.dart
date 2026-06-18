import '../data/modules.dart';
import '../models/flashcard.dart';
import 'app_locale.dart';

/// Textos da interface em português (Brasil) e italiano.
///
/// Acesse via getters/metódos estáticos (ex.: `S.start`). O idioma atual é lido
/// de [AppLocale.instance]; troque o idioma e reconstrua a árvore para atualizar.
///
/// Atenção: nada aqui muda o conteúdo dos cartões nem o sentido das respostas —
/// apenas os rótulos do sistema, para que italianos também possam usar o app.
class S {
  S._();

  static bool get _it => AppLocale.instance.isItalian;

  static String _t(String pt, String it) => _it ? it : pt;

  // ---- Genéricos / idiomas ----
  static String get appSubtitle => _t(
        'Digite a resposta, ganhe pontos e marque seu tempo.',
        'Scrivi la risposta, guadagna punti e cronometra il tempo.',
      );

  /// Nome do idioma de origem/alvo (italiano ou português) no idioma da UI.
  static String languageName({required bool italian}) {
    if (italian) return 'Italiano';
    return _t('Português', 'Portoghese');
  }

  // ---- HomeScreen ----
  static String get statRecord => _t('🏆 Recorde', '🏆 Record');
  static String get statSessions => _t('📚 Sessões', '📚 Sessioni');
  static String get pts => 'pts';

  static String get sectionDirection =>
      _t('Sentido da tradução', 'Senso della traduzione');
  static String get sectionLevel => _t('Nível (A1–C1)', 'Livello (A1–C1)');
  static String get sectionModules => _t('Módulos / áreas', 'Moduli / aree');
  static String get clear => _t('Limpar', 'Pulisci');
  static String get all => _t('Todos', 'Tutti');

  static String availableCards(int n) => _t(
        '$n cartões disponíveis na seleção',
        '$n carte disponibili nella selezione',
      );

  static String get manageCards =>
      _t('Criar / gerenciar meus cartões', 'Crea / gestisci le mie carte');

  static String get sectionCount =>
      _t('Número de perguntas', 'Numero di domande');
  static String get allFeminine => _t('Todas', 'Tutte');
  static String get allQuestions => _t('Todas as perguntas', 'Tutte le domande');
  static String get allQuestionsSub => _t(
        'Usa todos os cartões da seleção (ignora a barra)',
        'Usa tutte le carte della selezione (ignora la barra)',
      );
  static String get timerTitle =>
      _t('Cronometrar a sessão', 'Cronometra la sessione');
  static String get timerSub => _t(
        'Mostra o tempo e dá bônus de velocidade',
        'Mostra il tempo e dà bonus di velocità',
      );
  static String get shuffleTitle =>
      _t('Embaralhar perguntas', 'Mescola le domande');
  static String get start => _t('Iniciar sessão', 'Inizia la sessione');

  static String get selectAtLeast => _t(
        'Selecione ao menos um módulo e um nível.',
        'Seleziona almeno un modulo e un livello.',
      );
  static String get noCardsCombo => _t(
        'Nenhum cartão para essa combinação de módulos e níveis.',
        'Nessuna carta per questa combinazione di moduli e livelli.',
      );

  static String get directionMixed => _t('Misto', 'Misto');

  // ---- QuizScreen ----
  static String get exitTitle => _t('Sair da sessão?', 'Uscire dalla sessione?');
  static String get exitContent => _t(
        'Seu progresso atual será perdido.',
        'I tuoi progressi attuali andranno persi.',
      );
  static String get continueLabel => _t('Continuar', 'Continua');
  static String get exit => _t('Sair', 'Esci');

  /// Cabeçalho da pergunta: "Traduza do <idioma> • <nível> · <módulo>".
  static String translateFrom(String lang) =>
      _t('Traduza do $lang', 'Traduci dal $lang');
  static String answerIn(String lang) =>
      _t('Responda em $lang', 'Rispondi in $lang');
  static String get hintTooltip => _t('Dica', 'Suggerimento');
  static String get inputHint =>
      _t('Digite a tradução…', 'Scrivi la traduzione…');
  static String get skip => _t('Pular', 'Salta');
  static String get answer => _t('Responder', 'Rispondi');
  static String get seeResult => _t('Ver resultado', 'Vedi risultato');
  static String get next => _t('Próxima', 'Avanti');
  static String get correct => _t('Correto!', 'Corretto!');
  static String get almost => _t('Quase!', 'Quasi!');
  static String get answerLabel => _t('Resposta: ', 'Risposta: ');
  static String alsoAccepted(String list) =>
      _t('Também aceito: $list', 'Accettato anche: $list');
  static String streak(int n) => _t('🔥 $n seguidas', '🔥 $n di fila');

  // ---- ResultsScreen ----
  static String get sessionDone =>
      _t('Sessão concluída', 'Sessione completata');
  static String resultMessage(double accuracy) {
    if (accuracy >= 0.9) {
      return _t('Eccellente! Desempenho excelente!', 'Eccellente! Ottimo lavoro!');
    }
    if (accuracy >= 0.7) {
      return _t('Molto bene! Muito bom!', 'Molto bene! Continua così!');
    }
    if (accuracy >= 0.5) {
      return _t('Bene! Continue praticando.', 'Bene! Continua a esercitarti.');
    }
    return _t(
      'Coraggio! A prática leva à perfeição.',
      'Coraggio! La pratica rende perfetti.',
    );
  }

  static String get newRecord =>
      _t('🏆 Novo recorde de pontuação!', '🏆 Nuovo record di punteggio!');
  static String get pointsWord => _t('pontos', 'punti');
  static String get statHits => _t('Acertos', 'Giuste');
  static String get statAccuracy => _t('Precisão', 'Precisione');
  static String get statErrors => _t('Erros', 'Errori');
  static String get statBestStreak => _t('Melhor seq.', 'Miglior serie');
  static String get statTotalTime => _t('Tempo total', 'Tempo totale');
  static String get playAgain => _t('Jogar de novo', 'Gioca di nuovo');
  static String get changeSettings =>
      _t('Alterar configurações', 'Cambia impostazioni');

  // ---- CustomCardsScreen ----
  static String get myCards => _t('Meus cartões', 'Le mie carte');
  static String get newCard => _t('Novo cartão', 'Nuova carta');
  static String get cardAdded => _t('Cartão adicionado!', 'Carta aggiunta!');
  static String get cardUpdated =>
      _t('Cartão atualizado!', 'Carta aggiornata!');
  static String get deleteCardTitle =>
      _t('Excluir cartão?', 'Eliminare la carta?');
  static String get cancel => _t('Cancelar', 'Annulla');
  static String get delete => _t('Excluir', 'Elimina');
  static String get emptyTitle =>
      _t('Nenhum cartão seu ainda', 'Ancora nessuna carta tua');
  static String get emptyBody => _t(
        'Toque em "Novo cartão" para criar seus próprios flashcards. '
            'Eles ficam salvos e aparecem na próxima vez que você abrir o app.',
        'Tocca "Nuova carta" per creare le tue flashcard. '
            'Vengono salvate e riappaiono alla prossima apertura dell\'app.',
      );
  static String get editTooltip => _t('Editar', 'Modifica');
  static String get editCard => _t('Editar cartão', 'Modifica carta');
  static String get fieldModule => _t('Módulo', 'Modulo');
  static String get fieldLevel => _t('Nível', 'Livello');
  static String get fieldItalian => _t('Italiano *', 'Italiano *');
  static String get hintGatto => _t('ex.: gatto', 'es.: gatto');
  static String get validatorItalian => _t(
        'Informe a palavra em italiano',
        'Inserisci la parola in italiano',
      );
  static String get fieldPortuguese => _t('Português *', 'Portoghese *');
  static String get hintGato => _t('ex.: gato', 'es.: gatto (portoghese)');
  static String get validatorPortuguese => _t(
        'Informe a tradução em português',
        'Inserisci la traduzione in portoghese',
      );
  static String get fieldPtAlt => _t(
        'Outras respostas em português (opcional)',
        'Altre risposte in portoghese (facoltativo)',
      );
  static String get fieldItAlt => _t(
        'Outras respostas em italiano (opcional)',
        'Altre risposte in italiano (facoltativo)',
      );
  static String get commaSep =>
      _t('separe por vírgula', 'separa con la virgola');
  static String get fieldHint =>
      _t('Dica (opcional)', 'Suggerimento (facoltativo)');
  static String get saveChanges =>
      _t('Salvar alterações', 'Salva le modifiche');
  static String get addCard => _t('Adicionar cartão', 'Aggiungi carta');

  // ---- Rótulos de dados (módulos, grupos, níveis) ----

  /// Rótulo do módulo no idioma da UI (cai no rótulo PT padrão se não houver IT).
  static String module(String id) {
    if (_it) return _itModuleLabels[id] ?? moduleLabel(id);
    return moduleLabel(id);
  }

  /// Rótulo de um grupo de módulos no idioma da UI.
  static String group(ModuleGroup g) {
    if (_it) return _itGroupLabels[g.label] ?? g.label;
    return g.label;
  }

  /// Descrição do nível (ex.: "A1 · Iniciante" / "A1 · Principiante").
  static String levelDescription(CefrLevel level) {
    if (!_it) return level.description;
    switch (level) {
      case CefrLevel.a1:
        return 'A1 · Principiante';
      case CefrLevel.a2:
        return 'A2 · Base';
      case CefrLevel.b1:
        return 'B1 · Intermedio';
      case CefrLevel.b2:
        return 'B2 · Intermedio avanzato';
      case CefrLevel.c1:
        return 'C1 · Avanzato';
    }
  }
}

/// Tradução dos rótulos dos módulos para o italiano (chave = id do módulo).
const Map<String, String> _itModuleLabels = {
  'verbos_presente': 'Verbi al presente',
  'verbos_infinitivo': 'Verbi (infinito)',
  'preposicoes': 'Preposizioni',
  'artigos': 'Articoli',
  'substantivos': 'Sostantivi comuni',
  'adjetivos': 'Aggettivi',
  'numeros': 'Numeri',
  'cores': 'Colori',
  'familia': 'Famiglia',
  'comida': 'Cibo e bevande',
  'saudacoes': 'Saluti ed espressioni',
  'tempo': 'Tempo e giorni',
  'corpo': 'Corpo umano',
  'casa': 'Casa e mobili',
  'roupas': 'Vestiti',
  'animais': 'Animali',
  'lugares': 'Città e luoghi',
  'transporte': 'Trasporti e viaggi',
  'compras': 'Acquisti e denaro',
  'profissoes': 'Professioni e lavoro',
  'educacao': 'Istruzione e studi',
  'natureza': 'Natura e clima',
  'saude': 'Salute e corpo',
  'tecnologia': 'Tecnologia',
  'emocoes': 'Sentimenti ed emozioni',
  'verbos_avancados': 'Verbi avanzati',
  'verbos_conjugacao': 'Coniugazione (tutte le persone)',
  'verbos_passato': 'Passato prossimo',
  'verbos_imperfetto': 'Imperfetto',
  'verbos_futuro': 'Futuro semplice',
  'verbos_imperativo': 'Imperativo',
  'verbos_passato_remoto': 'Passato remoto',
  'verbos_trapassato': 'Trapassato prossimo',
  'verbos_futuro_anteriore': 'Futuro anteriore',
  'verbos_condizionale': 'Condizionale presente',
  'verbos_condizionale_passato': 'Condizionale passato',
  'verbos_cong_presente': 'Congiuntivo presente',
  'verbos_cong_imperfetto': 'Congiuntivo imperfetto',
  'verbos_cong_passato': 'Congiuntivo passato',
  'verbos_cong_trapassato': 'Congiuntivo trapassato',
  'essenciais': 'Vocabolario essenziale',
  'adverbios': 'Avverbi',
  'conjuncoes': 'Congiunzioni e connettivi',
  'abstratos': 'Concetti astratti',
  'expressoes': 'Espressioni idiomatiche',
  'personalizados': 'Le mie carte',
};

/// Tradução dos rótulos dos grupos para o italiano (chave = rótulo PT).
const Map<String, String> _itGroupLabels = {
  'Verbos — vocabulário': 'Verbi — vocabolario',
  'Verbos — tempos e conjugação': 'Verbi — tempi e coniugazione',
  'Gramática': 'Grammatica',
  'Vocabulário': 'Vocabolario',
  'Meus cartões': 'Le mie carte',
};
