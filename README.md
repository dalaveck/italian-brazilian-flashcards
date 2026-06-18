# 🇮🇹 ⇄ 🇧🇷 Flashcards Italiano · Português

App de **flashcards** para estudar vocabulário e verbos **italiano ⇄ português
brasileiro**, feito em **Flutter Web**. Você escolhe os módulos, o sentido da
tradução, **digita a resposta**, ganha **pontos** e pode **cronometrar** a
sessão.

> Hospedado na **Vercel** (veja a seção de deploy abaixo).

## ✨ Recursos

- **+2700 cartões** organizados por **nível CEFR (A1 → C1)** e por tópico:
  - **+1100 de conjugação verbal** cobrindo as 6 pessoas (io, tu, lui/lei,
    noi, voi, loro) no presente, imperfeito e futuro;
  - **+1000 de vocabulário essencial** (adjetivos, substantivos no singular
    **e** plural, verbos, advérbios, pronomes e conectores).
- **Filtro por nível (A1–C1)** e por **módulo/área** — combine como quiser.
- **Dois sentidos:** Italiano → Português, Português → Italiano ou **Misto**.
- **Módulos** (ou todos): verbos (presente, infinitivo, avançados),
  preposições, artigos, substantivos, adjetivos, números, cores, família,
  comida, saudações, tempo, corpo, casa, roupas, animais, cidade/lugares,
  transporte, compras, profissões, educação, natureza, saúde, tecnologia,
  emoções, advérbios, conjunções, conceitos abstratos e expressões idiomáticas.
- **Resposta digitada** com correção tolerante (ignora acentos, maiúsculas,
  pontuação e artigo inicial; aceita sinônimos).
- **Cronômetro** opcional com bônus de velocidade.
- **Pontuação** com bônus de sequência (combo) e **recordes salvos** no
  navegador.
- Escolha do **número de perguntas** (10, 15, 20, 30 ou todas) e embaralhamento.
- Tela de **resultados** com precisão, acertos/erros, melhor sequência e tempo.
- **Crie seus próprios cartões** (módulo, italiano, português, sinônimos e
  dica). Ficam **salvos no navegador** e continuam lá quando você volta; entram
  normalmente nas sessões junto com os cartões internos.

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

## ▲ Publicar na Vercel

O projeto já vem pronto para a Vercel (veja [`vercel.json`](vercel.json) e
[`vercel-build.sh`](vercel-build.sh)). O Vercel não traz o Flutter
pré-instalado, então o script de build baixa o SDK e compila o app.

**Pela interface da Vercel (recomendado):**

1. Em [vercel.com](https://vercel.com), clique em **Add New → Project** e
   importe este repositório do GitHub.
2. Não é preciso configurar nada: a Vercel lê o `vercel.json`
   (build = `bash vercel-build.sh`, output = `build/web`).
3. Clique em **Deploy**. O site fica em `https://<seu-projeto>.vercel.app`.

**Pela CLI:**

```bash
npm i -g vercel
vercel        # pré-visualização
vercel --prod # produção
```

> O app roda na **raiz** do domínio na Vercel, então o `--base-href` é `/`
> (padrão). Para fixar a versão do Flutter no build, defina a variável de
> ambiente `FLUTTER_VERSION` no painel da Vercel (padrão: `3.44.2`).
>
> O mesmo `build/web` também serve em Netlify, Cloudflare Pages ou Firebase
> Hosting, caso queira trocar de provedor.

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
