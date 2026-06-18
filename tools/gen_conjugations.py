#!/usr/bin/env python3
"""Gera flashcards de conjugação verbal (italiano <-> português) cobrindo as 6
pessoas, nos tempos presente, imperfeito e futuro.

Para garantir correção em volume, usamos APENAS verbos regulares cujas formas
são previsíveis nos dois idiomas (nenhum verbo com mudança de radical ou
irregularidade nos tempos gerados). Saída: lib/data/cards_conjugacoes.dart.

Mapeamento de pessoas (IT -> PT-BR):
  io   -> eu      (1ª sing.)
  tu   -> você    (forma de 3ª sing.; alternativa aceita: "tu" + 2ª sing.)
  lui  -> ele     (3ª sing.)
  noi  -> nós     (1ª plur.)
  voi  -> vocês   (forma de 3ª plur.)
  loro -> eles    (3ª plur.)
"""

# (infinitivo_it, classe_it, infinitivo_pt, classe_pt)
# classe_it: are | ere | ire | isc      classe_pt: ar | er | ir
VERBS = [
    # -are / -ar
    ("parlare", "are", "falar", "ar"),
    ("lavorare", "are", "trabalhar", "ar"),
    ("comprare", "are", "comprar", "ar"),
    ("guardare", "are", "olhar", "ar"),
    ("aspettare", "are", "esperar", "ar"),
    ("abitare", "are", "morar", "ar"),
    ("amare", "are", "amar", "ar"),
    ("cantare", "are", "cantar", "ar"),
    ("lavare", "are", "lavar", "ar"),
    ("portare", "are", "levar", "ar"),
    ("trovare", "are", "encontrar", "ar"),
    ("pensare", "are", "pensar", "ar"),
    ("chiamare", "are", "chamar", "ar"),
    ("entrare", "are", "entrar", "ar"),
    ("ascoltare", "are", "escutar", "ar"),
    ("domandare", "are", "perguntar", "ar"),
    ("ricordare", "are", "lembrar", "ar"),
    ("camminare", "are", "caminhar", "ar"),
    ("visitare", "are", "visitar", "ar"),
    ("provare", "are", "provar", "ar"),
    ("usare", "are", "usar", "ar"),
    ("prestare", "are", "emprestar", "ar"),
    ("mostrare", "are", "mostrar", "ar"),
    ("salutare", "are", "cumprimentar", "ar"),
    ("telefonare", "are", "telefonar", "ar"),
    ("nuotare", "are", "nadar", "ar"),
    ("saltare", "are", "pular", "ar"),
    ("desiderare", "are", "desejar", "ar"),
    ("cucinare", "are", "cozinhar", "ar"),
    ("tornare", "are", "voltar", "ar"),
    ("arrivare", "are", "chegar", "ar"),
    ("insegnare", "are", "ensinar", "ar"),
    ("sognare", "are", "sonhar", "ar"),
    ("passare", "are", "passar", "ar"),
    ("cenare", "are", "jantar", "ar"),
    ("pranzare", "are", "almoçar", "ar"),
    # -ere (PT classe variada)
    ("vendere", "ere", "vender", "er"),
    ("ricevere", "ere", "receber", "er"),
    ("temere", "ere", "temer", "er"),
    ("battere", "ere", "bater", "er"),
    ("credere", "ere", "acreditar", "ar"),
    ("correre", "ere", "correr", "er"),
    ("cedere", "ere", "ceder", "er"),
    ("scrivere", "ere", "escrever", "er"),
    ("prendere", "ere", "pegar", "ar"),
    ("rispondere", "ere", "responder", "er"),
    ("chiudere", "ere", "fechar", "ar"),
    ("mettere", "ere", "colocar", "ar"),
    ("spendere", "ere", "gastar", "ar"),
    ("difendere", "ere", "defender", "er"),
    ("decidere", "ere", "decidir", "ir"),
    ("insistere", "ere", "insistir", "ir"),
    ("esistere", "ere", "existir", "ir"),
    ("dividere", "ere", "dividir", "ir"),
    ("permettere", "ere", "permitir", "ir"),
    ("discutere", "ere", "discutir", "ir"),
    # -ire / -isc
    ("partire", "ire", "partir", "ir"),
    ("aprire", "ire", "abrir", "ir"),
    ("capire", "isc", "entender", "er"),
    ("finire", "isc", "terminar", "ar"),
    ("spedire", "isc", "enviar", "ar"),
    ("unire", "isc", "unir", "ir"),
    ("pulire", "isc", "limpar", "ar"),
    ("garantire", "isc", "garantir", "ir"),
]

# ----- Italiano -----
IT_PRESENT = {
    "are": ["o", "i", "a", "iamo", "ate", "ano"],
    "ere": ["o", "i", "e", "iamo", "ete", "ono"],
    "ire": ["o", "i", "e", "iamo", "ite", "ono"],
    "isc": ["isco", "isci", "isce", "iamo", "ite", "iscono"],
}
IT_IMPERF = {
    "are": ["avo", "avi", "ava", "avamo", "avate", "avano"],
    "ere": ["evo", "evi", "eva", "evamo", "evate", "evano"],
    "ire": ["ivo", "ivi", "iva", "ivamo", "ivate", "ivano"],
    "isc": ["ivo", "ivi", "iva", "ivamo", "ivate", "ivano"],
}
IT_FUT_END = ["ò", "ai", "à", "emo", "ete", "anno"]
IT_PRON = ["io", "tu", "lui", "noi", "voi", "loro"]


def it_forms(inf, cls):
    stem = inf[:-3]  # remove -are/-ere/-ire
    present = [stem + e for e in IT_PRESENT[cls]]
    imperf = [stem + e for e in IT_IMPERF[cls]]
    fut_stem = stem + ("ir" if cls in ("ire", "isc") else "er")
    fut = [fut_stem + e for e in IT_FUT_END]
    return {"presente": present, "imperfeito": imperf, "futuro": fut}


# ----- Português (BR) -----
PT_PRESENT = {
    "ar": {"1sg": "o", "2sg": "as", "3sg": "a", "1pl": "amos", "3pl": "am"},
    "er": {"1sg": "o", "2sg": "es", "3sg": "e", "1pl": "emos", "3pl": "em"},
    "ir": {"1sg": "o", "2sg": "es", "3sg": "e", "1pl": "imos", "3pl": "em"},
}
PT_IMPERF = {
    "ar": {"1sg": "ava", "2sg": "avas", "3sg": "ava", "1pl": "ávamos", "3pl": "avam"},
    "er": {"1sg": "ia", "2sg": "ias", "3sg": "ia", "1pl": "íamos", "3pl": "iam"},
    "ir": {"1sg": "ia", "2sg": "ias", "3sg": "ia", "1pl": "íamos", "3pl": "iam"},
}
PT_FUT = {"1sg": "ei", "2sg": "ás", "3sg": "á", "1pl": "emos", "3pl": "ão"}


def pt_forms(inf, cls):
    stem = inf[:-2]
    def build(table, suffix_on_inf=False):
        base = inf if suffix_on_inf else stem
        return {k: base + v for k, v in table.items()}
    return {
        "presente": build(PT_PRESENT[cls]),
        "imperfeito": build(PT_IMPERF[cls]),
        "futuro": build(PT_FUT, suffix_on_inf=True),
    }


# pessoa -> (pron_it_idx, pron_pt, chave_forma_pt)
PERSONS = [
    ("eu", "1sg"),
    ("você", "3sg"),
    ("ele", "3sg"),
    ("nós", "1pl"),
    ("vocês", "3pl"),
    ("eles", "3pl"),
]

LEVEL = {"presente": "a2", "imperfeito": "b1", "futuro": "b1"}


def dart_list(items):
    return "[" + ", ".join("'" + s.replace("'", "\\'") + "'" for s in items) + "]"


def main():
    lines = []
    lines.append("import '../models/flashcard.dart';")
    lines.append("")
    lines.append("/// Cartões de CONJUGAÇÃO verbal (italiano <-> português), cobrindo as 6")
    lines.append("/// pessoas (io, tu, lui/lei, noi, voi, loro) nos tempos presente, imperfeito")
    lines.append("/// e futuro. GERADO automaticamente por tools/gen_conjugations.py — não")
    lines.append("/// edite à mão; rode o script e substitua o arquivo.")
    lines.append("const List<Flashcard> kCardsConjugacoes = [")

    total = 0
    for it_inf, it_cls, pt_inf, pt_cls in VERBS:
        itf = it_forms(it_inf, it_cls)
        ptf = pt_forms(pt_inf, pt_cls)
        for tense in ("presente", "imperfeito", "futuro"):
            for i, (pt_pron, pt_key) in enumerate(PERSONS):
                it_text = f"{IT_PRON[i]} {itf[tense][i]}"
                pt_bare = ptf[tense][pt_key]
                pt_text = f"{pt_pron} {pt_bare}"

                pt_alt = {pt_bare}
                it_alt = {itf[tense][i]}
                if i == 1:  # tu -> você (aceitar também "tu" + 2ª pessoa)
                    tu_form = ptf[tense]["2sg"]
                    pt_alt.add(f"tu {tu_form}")
                    pt_alt.add(tu_form)

                level = LEVEL[tense]
                fields = [
                    "moduleId: 'verbos_conjugacao'",
                    f"level: CefrLevel.{level}",
                    f"it: '{it_text}'",
                    f"pt: '{pt_text}'",
                ]
                if it_alt:
                    fields.append(f"itAlt: {dart_list(sorted(it_alt))}")
                if pt_alt:
                    fields.append(f"ptAlt: {dart_list(sorted(pt_alt))}")
                fields.append(f"hint: '{pt_inf} — {tense}'")
                lines.append("  Flashcard(" + ", ".join(fields) + "),")
                total += 1

    lines.append("];")
    lines.append("")

    out = "/home/user/italian-brazilian-flashcards/lib/data/cards_conjugacoes.dart"
    with open(out, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))
    print(f"Gerados {total} cartões em {out}")


if __name__ == "__main__":
    main()
