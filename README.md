# 🇮🇹 ⇄ 🇧🇷 Flashcards Italiano · Português

App de **flashcards** para estudar vocabulário e verbos **italiano ⇄ português
brasileiro**, feito em **Flutter Web**. Você escolhe os módulos, o sentido da
tradução, **digita a resposta**, ganha **pontos** e pode **cronometrar** a
sessão.

> Produção (após habilitar o Pages): **https://dalaveck.github.io/italian-brazilian-flashcards/**

## ✨ Recursos

- **Dois sentidos:** Italiano → Português, Português → Italiano ou **Misto**.
- **Módulos selecionáveis** (ou todos): verbos no presente, verbos no
  infinitivo, preposições, artigos, substantivos, adjetivos, números, cores,
  família, comida e bebida, saudações/expressões, tempo e dias.
- **Resposta digitada** com correção tolerante (ignora acentos, maiúsculas,
  pontuação e artigo inicial; aceita sinônimos).
- **Cronômetro** opcional com bônus de velocidade.
- **Pontuação** com bônus de sequência (combo) e **recordes salvos** no
  navegador.
- Escolha do **número de perguntas** (10, 15, 20, 30 ou todas) e embaralhamento.
- Tela de **resultados** com precisão, acertos/erros, melhor sequência e tempo.

## 🚀 Rodar localmente

Pré-requisito: [Flutter](https://docs.flutter.dev/get-started/install) (canal
`stable`).

```bash
flutter pub get
flutter run -d chrome
```

Testes e análise:

```bash
flutter test
flutter analyze
```

## 🌐 Publicar na internet (GitHub Pages)

O deploy é **automático via GitHub Actions**. Passo único de configuração:

1. No GitHub, vá em **Settings → Pages**.
2. Em **Source**, selecione **"GitHub Actions"**.
3. Faça merge/push na branch **`main`**. O workflow
   [`deploy.yml`](.github/workflows/deploy.yml) compila o app e publica.

O site ficará em `https://<usuario>.github.io/<repositorio>/`. Se renomear o
repositório, ajuste o `--base-href` em `deploy.yml`.

> Alternativas de hospedagem (mesmo build `build/web`): Netlify, Vercel,
> Cloudflare Pages, Firebase Hosting — basta servir a pasta `build/web`.

## 🧩 Como adicionar palavras

Edite [`lib/data/decks.dart`](lib/data/decks.dart):

```dart
Flashcard(moduleId: 'cores', it: 'rosso', pt: 'vermelho'),
Flashcard(moduleId: 'saudacoes', it: 'grazie', pt: 'obrigado',
    ptAlt: ['obrigada', 'obg']),
```

Para um módulo novo, adicione-o também em
[`lib/data/modules.dart`](lib/data/modules.dart).

## 📁 Estrutura

Veja [`CLAUDE.md`](CLAUDE.md) para a arquitetura completa, convenções e regras
de pontuação.

## 📜 Licença

MIT.
