# CLAUDE.md — Contexto de IA do projeto

Este arquivo orienta o Claude Code (e outros agentes de IA) ao trabalhar neste
repositório. Leia antes de fazer alterações.

## Visão geral

App de **flashcards Italiano ⇄ Português brasileiro**, feito em **Flutter
(Web)** e publicado no **GitHub Pages**. O usuário escolhe módulos (verbos no
presente, preposições, artigos, etc.), o sentido da tradução, digita a resposta
e recebe pontuação; há cronômetro opcional.

URL de produção (após habilitar o Pages):
`https://dalaveck.github.io/italian-brazilian-flashcards/`

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
    decks.dart               # TODO o vocabulário (kAllCards)
  services/
    answer_checker.dart      # normalização e comparação de respostas
    score_store.dart         # persistência de recordes (shared_preferences)
  state/
    quiz_config.dart         # configuração escolhida na home
    quiz_session.dart        # lógica/estado de uma sessão (pontuação, fluxo)
  screens/
    home_screen.dart         # seleção de módulos/sentido/opções
    quiz_screen.dart         # tela de pergunta + cronômetro + digitação
    results_screen.dart      # placar final
test/                        # testes unitários (answer checker, sessão)
web/                         # index.html, manifest, ícones
.github/workflows/
  deploy.yml                 # build web + deploy no Pages (push na main)
  ci.yml                     # analyze + test (branches/PRs)
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
- **Para adicionar vocabulário:** edite só `lib/data/decks.dart`. Cada cartão é
  um `Flashcard(moduleId, it, pt, itAlt?, ptAlt?, hint?)`. Use `itAlt`/`ptAlt`
  para sinônimos/variantes aceitas. Para um módulo novo, adicione a entrada em
  `lib/data/modules.dart` (id + label + ícone) e cartões com esse `moduleId`.

## Comandos

```bash
flutter pub get
flutter run -d chrome          # desenvolvimento local (web)
flutter test                   # testes
flutter analyze                # lint/análise estática
flutter build web --release --base-href "/italian-brazilian-flashcards/"
```

## Publicação

O deploy é automático: ao dar **push na branch `main`**, o workflow
`deploy.yml` compila o web e publica no GitHub Pages. Pré-requisito único
(feito uma vez no GitHub): **Settings → Pages → Source = "GitHub Actions"**.

Se o repositório for renomeado, atualize o `--base-href` em `deploy.yml` para
`/<novo-nome>/`.

## Ao alterar o projeto

1. Mantenha `flutter analyze` limpo e `flutter test` verde.
2. Não comite `build/`, `.dart_tool/` nem `pubspec.lock` (ver `.gitignore`).
3. Prefira widgets pequenos e privados (prefixo `_`) por tela, como já é feito.
