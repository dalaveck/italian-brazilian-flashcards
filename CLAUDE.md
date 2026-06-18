# CLAUDE.md — Contexto de IA do projeto

Este arquivo orienta o Claude Code (e outros agentes de IA) ao trabalhar neste
repositório. Leia antes de fazer alterações.

## Visão geral

App de **flashcards Italiano ⇄ Português brasileiro**, feito em **Flutter
(Web)** e publicado na **Vercel**. O usuário escolhe módulos (verbos no
presente, preposições, artigos, etc.), o sentido da tradução, digita a resposta
e recebe pontuação; há cronômetro opcional.

URL de produção: `https://<seu-projeto>.vercel.app`

## Stack

- Flutter (canal `stable`), Dart `>=3.4.0`.
- Material 3, tema escuro (ver `lib/theme.dart`).
- Dependências: apenas `shared_preferences` (persistência de recordes em
  `localStorage` no web). Evite adicionar pacotes sem necessidade — cada
  dependência nova precisa resolver no CI offline-restrito.
- Sem gerenciador de estado externo: usamos `ChangeNotifier` + `AnimatedBuilder`.

## Estrutura de pastas

```
lib/
  main.dart                  # bootstrap do app
  theme.dart                 # tema visual
  models/flashcard.dart      # Flashcard, Question, Direction
  data/
    modules.dart             # metadados dos módulos (id, label, ícone)
    decks.dart               # núcleo A1 (kCardsA1) + agrega kAllCards
    cards_a2.dart            # vocabulário A2
    cards_b1.dart            # vocabulário B1
    cards_b2.dart            # vocabulário B2
    cards_c1.dart            # vocabulário C1 (inclui expressões idiomáticas)
  services/
    answer_checker.dart      # normalização e comparação de respostas
    score_store.dart         # persistência de recordes (shared_preferences)
    custom_card_store.dart   # persistência dos cartões do usuário (JSON)
  state/
    quiz_config.dart         # configuração escolhida na home
    quiz_session.dart        # lógica/estado de uma sessão (pontuação, fluxo)
    card_repository.dart     # combina kAllCards + cartões do usuário (singleton)
  screens/
    home_screen.dart         # seleção de módulos/sentido/opções
    quiz_screen.dart         # tela de pergunta + cronômetro + digitação
    results_screen.dart      # placar final
    custom_cards_screen.dart # criar/editar/excluir cartões do usuário
test/                        # testes unitários (answer checker, sessão)
web/                         # index.html, manifest, ícones
.github/workflows/
  ci.yml                     # analyze + test (branches/PRs)
vercel.json                  # config de deploy na Vercel
vercel-build.sh              # baixa o Flutter SDK e roda `flutter build web`
```

## Regras e convenções

- **Idioma da UI e dos commits: português (Brasil).**
- Toda lógica de pontuação vive em `quiz_session.dart`. Regras atuais:
  - +100 por acerto;
  - bônus de sequência: +10 × (sequência − 1);
  - bônus de velocidade: +10 quando o cronômetro está ativo;
  - erro zera a sequência e não pontua.
- A comparação de respostas (`AnswerChecker`) é tolerante: ignora
  maiúsculas/minúsculas, acentuação, pontuação e artigo inicial. Ao mexer nisso,
  mantenha os testes em `test/answer_checker_test.dart` passando.
- **Para adicionar vocabulário interno:** edite o arquivo do nível
  correspondente (`decks.dart` para A1, `cards_a2/b1/b2/c1.dart` para os demais).
  Cada cartão é um `Flashcard(moduleId, it, pt, level, itAlt?, ptAlt?, hint?)`.
  O `level` (enum `CefrLevel`) tem padrão `a1`; nos arquivos A2–C1 ele é sempre
  informado explicitamente. Use `itAlt`/`ptAlt` para sinônimos/variantes
  aceitas. Para um módulo novo, adicione a entrada em `lib/data/modules.dart`
  (id + label + ícone) e cartões com esse `moduleId`. Todos os arquivos de nível
  são reunidos em `kAllCards` (em `decks.dart`).
- **Seleção do usuário:** `QuizConfig` carrega `moduleIds` + `levels`;
  `CardRepository.cardsForSelection(moduleIds, levels)` filtra por ambos
  (conjunto de níveis vazio = todos os níveis).
- **Cartões do usuário:** criados em `custom_cards_screen.dart`, persistidos por
  `custom_card_store.dart` e expostos via `CardRepository.instance` (carregado no
  `main()` antes do `runApp`). `QuizSession` monta as perguntas a partir de
  `CardRepository.instance.cardsForModules(...)`, que une internos + do usuário.
  Cartões do usuário têm `Flashcard.id` (os internos têm `id == null`).

## Comandos

```bash
flutter pub get
flutter run -d chrome          # desenvolvimento local (web)
flutter test                   # testes
flutter analyze                # lint/análise estática
flutter build web --release    # base-href padrão "/" (raiz do domínio)
```

## Publicação (Vercel)

Deploy via **Vercel**. `vercel.json` define `buildCommand: bash vercel-build.sh`
e `outputDirectory: build/web`. O script baixa o Flutter (versão em
`FLUTTER_VERSION`, padrão `3.44.2`) e roda `flutter build web --release`. Como o
app é servido na **raiz** do domínio na Vercel, o `--base-href` fica `/`
(padrão). O `rewrites` catch-all serve `index.html` para rotas desconhecidas (a
Vercel checa o filesystem antes, então os assets continuam sendo servidos
diretamente).

Na Vercel: **Add New → Project → importar o repositório**; nada mais a
configurar (lê o `vercel.json`). O CI do GitHub (`ci.yml`) segue rodando
`analyze` + `test`, mas não faz deploy.

## Ao alterar o projeto

1. Mantenha `flutter analyze` limpo e `flutter test` verde.
2. Não comite `build/`, `.dart_tool/` nem `pubspec.lock` (ver `.gitignore`).
3. Prefira widgets pequenos e privados (prefixo `_`) por tela, como já é feito.
