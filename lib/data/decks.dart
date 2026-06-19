import '../models/flashcard.dart';
import 'cards_a2.dart';
import 'cards_b1.dart';
import 'cards_b2.dart';
import 'cards_c1.dart';

/// Banco completo de flashcards, organizado por nível (A1–C1) e por módulo.
///
/// As listas `itAlt`/`ptAlt` trazem variantes aceitas (sinônimos, com/sem
/// artigo, grafias alternativas). A verificação de resposta também ignora
/// acentuação e maiúsculas/minúsculas (ver `services/answer_checker.dart`).
///
/// Os cartões deste arquivo são o núcleo de nível **A1** (nível padrão do
/// `Flashcard`). Os demais níveis ficam em `cards_a2/b1/b2/c1.dart` e são
/// reunidos em [kAllCards].
const List<Flashcard> kCardsA1 = [
  // ---------------------------------------------------------------------------
  // Verbos no presente (1ª pessoa do singular, "io ...")
  // ---------------------------------------------------------------------------
  Flashcard(moduleId: 'verbos_presente', it: 'io sono', pt: 'eu sou', ptAlt: ['eu estou', 'sou', 'estou']),
  Flashcard(moduleId: 'verbos_presente', it: 'io ho', pt: 'eu tenho', ptAlt: ['tenho']),
  Flashcard(moduleId: 'verbos_presente', it: 'io faccio', pt: 'eu faço', ptAlt: ['faço']),
  Flashcard(moduleId: 'verbos_presente', it: 'io vado', pt: 'eu vou', ptAlt: ['vou']),
  Flashcard(moduleId: 'verbos_presente', it: 'io parlo', pt: 'eu falo', ptAlt: ['falo']),
  Flashcard(moduleId: 'verbos_presente', it: 'io mangio', pt: 'eu como', ptAlt: ['como']),
  Flashcard(moduleId: 'verbos_presente', it: 'io bevo', pt: 'eu bebo', ptAlt: ['bebo']),
  Flashcard(moduleId: 'verbos_presente', it: 'io capisco', pt: 'eu entendo', ptAlt: ['entendo', 'eu compreendo', 'compreendo']),
  Flashcard(moduleId: 'verbos_presente', it: 'io voglio', pt: 'eu quero', ptAlt: ['quero']),
  Flashcard(moduleId: 'verbos_presente', it: 'io posso', pt: 'eu posso', ptAlt: ['posso']),
  Flashcard(moduleId: 'verbos_presente', it: 'io devo', pt: 'eu devo', ptAlt: ['devo', 'eu preciso', 'preciso']),
  Flashcard(moduleId: 'verbos_presente', it: 'io so', pt: 'eu sei', ptAlt: ['sei']),
  Flashcard(moduleId: 'verbos_presente', it: 'tu sei', pt: 'você é', ptAlt: ['tu és', 'voce e', 'você está', 'tu estás']),
  Flashcard(moduleId: 'verbos_presente', it: 'lui è', pt: 'ele é', ptAlt: ['ele está', 'ele e']),
  Flashcard(moduleId: 'verbos_presente', it: 'noi siamo', pt: 'nós somos', ptAlt: ['nos somos', 'nós estamos', 'somos']),
  Flashcard(moduleId: 'verbos_presente', it: 'loro sono', pt: 'eles são', ptAlt: ['eles estão', 'elas são', 'são']),

  // ---------------------------------------------------------------------------
  // Verbos no infinitivo
  // ---------------------------------------------------------------------------
  Flashcard(moduleId: 'verbos_infinitivo', it: 'essere', pt: 'ser', ptAlt: ['estar', 'ser/estar']),
  Flashcard(moduleId: 'verbos_infinitivo', it: 'avere', pt: 'ter', ptAlt: ['haver']),
  Flashcard(moduleId: 'verbos_infinitivo', it: 'fare', pt: 'fazer'),
  Flashcard(moduleId: 'verbos_infinitivo', it: 'andare', pt: 'ir'),
  Flashcard(moduleId: 'verbos_infinitivo', it: 'venire', pt: 'vir'),
  Flashcard(moduleId: 'verbos_infinitivo', it: 'parlare', pt: 'falar'),
  Flashcard(moduleId: 'verbos_infinitivo', it: 'mangiare', pt: 'comer'),
  Flashcard(moduleId: 'verbos_infinitivo', it: 'bere', pt: 'beber'),
  Flashcard(moduleId: 'verbos_infinitivo', it: 'dormire', pt: 'dormir'),
  Flashcard(moduleId: 'verbos_infinitivo', it: 'leggere', pt: 'ler'),
  Flashcard(moduleId: 'verbos_infinitivo', it: 'scrivere', pt: 'escrever'),
  Flashcard(moduleId: 'verbos_infinitivo', it: 'capire', pt: 'entender', ptAlt: ['compreender']),
  Flashcard(moduleId: 'verbos_infinitivo', it: 'volere', pt: 'querer'),
  Flashcard(moduleId: 'verbos_infinitivo', it: 'potere', pt: 'poder'),
  Flashcard(moduleId: 'verbos_infinitivo', it: 'dovere', pt: 'dever', ptAlt: ['precisar', 'ter que']),
  Flashcard(moduleId: 'verbos_infinitivo', it: 'sapere', pt: 'saber'),
  Flashcard(moduleId: 'verbos_infinitivo', it: 'comprare', pt: 'comprar'),
  Flashcard(moduleId: 'verbos_infinitivo', it: 'lavorare', pt: 'trabalhar'),

  // ---------------------------------------------------------------------------
  // Preposições
  // ---------------------------------------------------------------------------
  Flashcard(moduleId: 'preposicoes', it: 'di', pt: 'de'),
  Flashcard(moduleId: 'preposicoes', it: 'a', pt: 'a', ptAlt: ['para', 'em']),
  Flashcard(moduleId: 'preposicoes', it: 'da', pt: 'de', ptAlt: ['desde', 'a partir de']),
  Flashcard(moduleId: 'preposicoes', it: 'in', pt: 'em', ptAlt: ['no', 'na']),
  Flashcard(moduleId: 'preposicoes', it: 'con', pt: 'com'),
  Flashcard(moduleId: 'preposicoes', it: 'su', pt: 'sobre', ptAlt: ['em cima', 'sobre/em cima']),
  Flashcard(moduleId: 'preposicoes', it: 'per', pt: 'por', ptAlt: ['para', 'por/para']),
  Flashcard(moduleId: 'preposicoes', it: 'tra', pt: 'entre'),
  Flashcard(moduleId: 'preposicoes', it: 'fra', pt: 'entre'),
  Flashcard(moduleId: 'preposicoes', it: 'sotto', pt: 'sob', ptAlt: ['embaixo', 'debaixo']),
  Flashcard(moduleId: 'preposicoes', it: 'dopo', pt: 'depois', ptAlt: ['após']),
  Flashcard(moduleId: 'preposicoes', it: 'prima', pt: 'antes'),
  Flashcard(moduleId: 'preposicoes', it: 'senza', pt: 'sem'),
  Flashcard(moduleId: 'preposicoes', it: 'contro', pt: 'contra'),
  Flashcard(moduleId: 'preposicoes', it: 'verso', pt: 'em direção a', ptAlt: ['rumo a', 'para']),

  // ---------------------------------------------------------------------------
  // Artigos
  // ---------------------------------------------------------------------------
  Flashcard(moduleId: 'artigos', it: 'il', pt: 'o', hint: 'definido, masc. singular'),
  Flashcard(moduleId: 'artigos', it: 'lo', pt: 'o', hint: 'masc. sing. antes de s+cons., z, gn...'),
  Flashcard(moduleId: 'artigos', it: "l'", pt: 'o/a', ptAlt: ['o', 'a'], hint: 'antes de vogal'),
  Flashcard(moduleId: 'artigos', it: 'la', pt: 'a', hint: 'definido, fem. singular'),
  Flashcard(moduleId: 'artigos', it: 'i', pt: 'os', hint: 'definido, masc. plural'),
  Flashcard(moduleId: 'artigos', it: 'gli', pt: 'os', hint: 'masc. plural antes de vogal/s+cons.'),
  Flashcard(moduleId: 'artigos', it: 'le', pt: 'as', hint: 'definido, fem. plural'),
  Flashcard(moduleId: 'artigos', it: 'un', pt: 'um', hint: 'indefinido masculino'),
  Flashcard(moduleId: 'artigos', it: 'uno', pt: 'um', hint: 'masc. antes de s+cons., z...'),
  Flashcard(moduleId: 'artigos', it: 'una', pt: 'uma', hint: 'indefinido feminino'),
  Flashcard(moduleId: 'artigos', it: 'del', pt: 'do', ptAlt: ['de+o', 'algum'], hint: 'partitivo / di+il'),
  Flashcard(moduleId: 'artigos', it: 'nella', pt: 'na', ptAlt: ['em+a'], hint: 'in+la'),

  // ---------------------------------------------------------------------------
  // Substantivos comuns
  // ---------------------------------------------------------------------------
  Flashcard(moduleId: 'substantivos', it: 'casa', pt: 'casa'),
  Flashcard(moduleId: 'substantivos', it: 'libro', pt: 'livro'),
  Flashcard(moduleId: 'substantivos', it: 'macchina', pt: 'carro', ptAlt: ['máquina', 'automóvel']),
  Flashcard(moduleId: 'substantivos', it: 'lavoro', pt: 'trabalho', ptAlt: ['emprego']),
  Flashcard(moduleId: 'substantivos', it: 'città', pt: 'cidade'),
  Flashcard(moduleId: 'substantivos', it: 'strada', pt: 'rua', ptAlt: ['estrada', 'caminho']),
  Flashcard(moduleId: 'substantivos', it: 'acqua', pt: 'água'),
  Flashcard(moduleId: 'substantivos', it: 'tempo', pt: 'tempo'),
  Flashcard(moduleId: 'substantivos', it: 'giorno', pt: 'dia'),
  Flashcard(moduleId: 'substantivos', it: 'notte', pt: 'noite'),
  Flashcard(moduleId: 'substantivos', it: 'scuola', pt: 'escola'),
  Flashcard(moduleId: 'substantivos', it: 'amico', pt: 'amigo'),
  Flashcard(moduleId: 'substantivos', it: 'soldi', pt: 'dinheiro'),
  Flashcard(moduleId: 'substantivos', it: 'mano', pt: 'mão'),
  Flashcard(moduleId: 'substantivos', it: 'occhio', pt: 'olho'),

  // ---------------------------------------------------------------------------
  // Adjetivos
  // ---------------------------------------------------------------------------
  Flashcard(moduleId: 'adjetivos', it: 'grande', pt: 'grande'),
  Flashcard(moduleId: 'adjetivos', it: 'piccolo', pt: 'pequeno'),
  Flashcard(moduleId: 'adjetivos', it: 'bello', pt: 'bonito', ptAlt: ['belo', 'lindo']),
  Flashcard(moduleId: 'adjetivos', it: 'brutto', pt: 'feio'),
  Flashcard(moduleId: 'adjetivos', it: 'buono', pt: 'bom'),
  Flashcard(moduleId: 'adjetivos', it: 'cattivo', pt: 'ruim', ptAlt: ['mau', 'malvado']),
  Flashcard(moduleId: 'adjetivos', it: 'nuovo', pt: 'novo'),
  Flashcard(moduleId: 'adjetivos', it: 'vecchio', pt: 'velho', ptAlt: ['antigo']),
  Flashcard(moduleId: 'adjetivos', it: 'caldo', pt: 'quente'),
  Flashcard(moduleId: 'adjetivos', it: 'freddo', pt: 'frio'),
  Flashcard(moduleId: 'adjetivos', it: 'facile', pt: 'fácil'),
  Flashcard(moduleId: 'adjetivos', it: 'difficile', pt: 'difícil'),
  Flashcard(moduleId: 'adjetivos', it: 'felice', pt: 'feliz', ptAlt: ['contente']),
  Flashcard(moduleId: 'adjetivos', it: 'stanco', pt: 'cansado'),
  Flashcard(moduleId: 'adjetivos', it: 'veloce', pt: 'rápido', ptAlt: ['veloz']),

  // ---------------------------------------------------------------------------
  // Números
  // ---------------------------------------------------------------------------
  Flashcard(moduleId: 'numeros', it: 'uno', pt: 'um', ptAlt: ['1']),
  Flashcard(moduleId: 'numeros', it: 'due', pt: 'dois', ptAlt: ['2', 'duas']),
  Flashcard(moduleId: 'numeros', it: 'tre', pt: 'três', ptAlt: ['3']),
  Flashcard(moduleId: 'numeros', it: 'quattro', pt: 'quatro', ptAlt: ['4']),
  Flashcard(moduleId: 'numeros', it: 'cinque', pt: 'cinco', ptAlt: ['5']),
  Flashcard(moduleId: 'numeros', it: 'sei', pt: 'seis', ptAlt: ['6']),
  Flashcard(moduleId: 'numeros', it: 'sette', pt: 'sete', ptAlt: ['7']),
  Flashcard(moduleId: 'numeros', it: 'otto', pt: 'oito', ptAlt: ['8']),
  Flashcard(moduleId: 'numeros', it: 'nove', pt: 'nove', ptAlt: ['9']),
  Flashcard(moduleId: 'numeros', it: 'dieci', pt: 'dez', ptAlt: ['10']),
  Flashcard(moduleId: 'numeros', it: 'venti', pt: 'vinte', ptAlt: ['20']),
  Flashcard(moduleId: 'numeros', it: 'cento', pt: 'cem', ptAlt: ['100']),
  Flashcard(moduleId: 'numeros', it: 'mille', pt: 'mil', ptAlt: ['1000']),

  // ---------------------------------------------------------------------------
  // Cores
  // ---------------------------------------------------------------------------
  Flashcard(moduleId: 'cores', it: 'rosso', pt: 'vermelho'),
  Flashcard(moduleId: 'cores', it: 'blu', pt: 'azul'),
  Flashcard(moduleId: 'cores', it: 'azzurro', pt: 'azul-claro', ptAlt: ['azul claro', 'celeste']),
  Flashcard(moduleId: 'cores', it: 'verde', pt: 'verde'),
  Flashcard(moduleId: 'cores', it: 'giallo', pt: 'amarelo'),
  Flashcard(moduleId: 'cores', it: 'nero', pt: 'preto'),
  Flashcard(moduleId: 'cores', it: 'bianco', pt: 'branco'),
  Flashcard(moduleId: 'cores', it: 'grigio', pt: 'cinza'),
  Flashcard(moduleId: 'cores', it: 'marrone', pt: 'marrom'),
  Flashcard(moduleId: 'cores', it: 'rosa', pt: 'rosa'),
  Flashcard(moduleId: 'cores', it: 'viola', pt: 'roxo', ptAlt: ['violeta', 'lilás']),
  Flashcard(moduleId: 'cores', it: 'arancione', pt: 'laranja'),

  // ---------------------------------------------------------------------------
  // Família
  // ---------------------------------------------------------------------------
  Flashcard(moduleId: 'familia', it: 'madre', pt: 'mãe', ptAlt: ['mamãe']),
  Flashcard(moduleId: 'familia', it: 'padre', pt: 'pai', ptAlt: ['papai']),
  Flashcard(moduleId: 'familia', it: 'figlio', pt: 'filho'),
  Flashcard(moduleId: 'familia', it: 'figlia', pt: 'filha'),
  Flashcard(moduleId: 'familia', it: 'fratello', pt: 'irmão'),
  Flashcard(moduleId: 'familia', it: 'sorella', pt: 'irmã'),
  Flashcard(moduleId: 'familia', it: 'nonno', pt: 'avô'),
  Flashcard(moduleId: 'familia', it: 'nonna', pt: 'avó'),
  Flashcard(moduleId: 'familia', it: 'marito', pt: 'marido', ptAlt: ['esposo']),
  Flashcard(moduleId: 'familia', it: 'moglie', pt: 'esposa', ptAlt: ['mulher']),
  Flashcard(moduleId: 'familia', it: 'zio', pt: 'tio'),
  Flashcard(moduleId: 'familia', it: 'cugino', pt: 'primo'),

  // ---------------------------------------------------------------------------
  // Comida e bebida
  // ---------------------------------------------------------------------------
  Flashcard(moduleId: 'comida', it: 'pane', pt: 'pão'),
  Flashcard(moduleId: 'comida', it: 'latte', pt: 'leite'),
  Flashcard(moduleId: 'comida', it: 'formaggio', pt: 'queijo'),
  Flashcard(moduleId: 'comida', it: 'carne', pt: 'carne'),
  Flashcard(moduleId: 'comida', it: 'pesce', pt: 'peixe'),
  Flashcard(moduleId: 'comida', it: 'frutta', pt: 'fruta'),
  Flashcard(moduleId: 'comida', it: 'verdura', pt: 'verdura', ptAlt: ['legumes', 'vegetais']),
  Flashcard(moduleId: 'comida', it: 'uovo', pt: 'ovo'),
  Flashcard(moduleId: 'comida', it: 'caffè', pt: 'café'),
  Flashcard(moduleId: 'comida', it: 'vino', pt: 'vinho'),
  Flashcard(moduleId: 'comida', it: 'zucchero', pt: 'açúcar'),
  Flashcard(moduleId: 'comida', it: 'sale', pt: 'sal'),
  Flashcard(moduleId: 'comida', it: 'riso', pt: 'arroz'),
  Flashcard(moduleId: 'comida', it: 'pollo', pt: 'frango', ptAlt: ['galinha']),

  // ---------------------------------------------------------------------------
  // Saudações e expressões
  // ---------------------------------------------------------------------------
  Flashcard(moduleId: 'saudacoes', it: 'ciao', pt: 'oi', ptAlt: ['olá', 'tchau']),
  Flashcard(moduleId: 'saudacoes', it: 'buongiorno', pt: 'bom dia'),
  Flashcard(moduleId: 'saudacoes', it: 'buonasera', pt: 'boa noite', ptAlt: ['boa tarde']),
  Flashcard(moduleId: 'saudacoes', it: 'buonanotte', pt: 'boa noite'),
  Flashcard(moduleId: 'saudacoes', it: 'grazie', pt: 'obrigado', ptAlt: ['obrigada', 'obg']),
  Flashcard(moduleId: 'saudacoes', it: 'prego', pt: 'de nada', ptAlt: ['por favor']),
  Flashcard(moduleId: 'saudacoes', it: 'per favore', pt: 'por favor'),
  Flashcard(moduleId: 'saudacoes', it: 'scusa', pt: 'desculpa', ptAlt: ['desculpe', 'com licença']),
  Flashcard(moduleId: 'saudacoes', it: 'arrivederci', pt: 'até logo', ptAlt: ['adeus', 'até mais', 'tchau']),
  Flashcard(moduleId: 'saudacoes', it: 'come stai?', pt: 'como vai?', ptAlt: ['como está?', 'tudo bem?', 'como você está?']),
  Flashcard(moduleId: 'saudacoes', it: 'mi chiamo', pt: 'meu nome é', ptAlt: ['eu me chamo', 'me chamo']),
  Flashcard(moduleId: 'saudacoes', it: 'sì', pt: 'sim'),
  Flashcard(moduleId: 'saudacoes', it: 'no', pt: 'não'),

  // ---------------------------------------------------------------------------
  // Tempo e dias
  // ---------------------------------------------------------------------------
  Flashcard(moduleId: 'tempo', it: 'lunedì', pt: 'segunda-feira', ptAlt: ['segunda']),
  Flashcard(moduleId: 'tempo', it: 'martedì', pt: 'terça-feira', ptAlt: ['terça']),
  Flashcard(moduleId: 'tempo', it: 'mercoledì', pt: 'quarta-feira', ptAlt: ['quarta']),
  Flashcard(moduleId: 'tempo', it: 'giovedì', pt: 'quinta-feira', ptAlt: ['quinta']),
  Flashcard(moduleId: 'tempo', it: 'venerdì', pt: 'sexta-feira', ptAlt: ['sexta']),
  Flashcard(moduleId: 'tempo', it: 'sabato', pt: 'sábado'),
  Flashcard(moduleId: 'tempo', it: 'domenica', pt: 'domingo'),
  Flashcard(moduleId: 'tempo', it: 'oggi', pt: 'hoje'),
  Flashcard(moduleId: 'tempo', it: 'domani', pt: 'amanhã'),
  Flashcard(moduleId: 'tempo', it: 'ieri', pt: 'ontem'),
  Flashcard(moduleId: 'tempo', it: 'settimana', pt: 'semana'),
  Flashcard(moduleId: 'tempo', it: 'mese', pt: 'mês'),
  Flashcard(moduleId: 'tempo', it: 'anno', pt: 'ano'),
  Flashcard(moduleId: 'tempo', it: 'ora', pt: 'hora', ptAlt: ['agora']),
];

/// Cartões internos "leves" (núcleo A1–C1), carregados de imediato no bundle
/// inicial. Os decks GERADOS e grandes (conjugações, essenciais e tempos
/// verbais) NÃO entram aqui: ficam atrás de imports `deferred` em
/// `state/card_repository.dart` e só são baixados ao iniciar uma sessão, para
/// manter o primeiro carregamento da página leve.
const List<Flashcard> kAllCards = [
  ...kCardsA1,
  ...kCardsA2,
  ...kCardsB1,
  ...kCardsB2,
  ...kCardsC1,
];
