#!/usr/bin/env python3
"""Gera flashcards de verbos italianos <-> português em 4 tempos/modos, cobrindo
todas as pessoas verbais, com ~1000 cartões em cada módulo:

  - verbos_passato     -> passato prossimo (avere + particípio) ~ pretérito perfeito
  - verbos_imperfetto  -> imperfetto                              ~ pretérito imperfeito
  - verbos_futuro      -> futuro semplice                         ~ futuro do presente
  - verbos_imperativo  -> imperativo                              ~ imperativo

Apenas verbos REGULARES (em italiano e português nesses tempos) são usados, para
garantir correção. Particípios irregulares do italiano são fornecidos
explicitamente; mudanças ortográficas do português (-car/-gar/-çar) são tratadas
por regra. Todos os verbos escolhidos usam o auxiliar AVERE no passato prossimo
(particípio invariável). Saída: lib/data/cards_tempos.dart — não edite à mão.
"""

# (it_inf, it_cls, pt_inf, pt_cls, participio_it_ou_None)
# it_cls: are|ere|ire|isc   pt_cls: ar|er|ir
V = [
    # ---- -are / -ar (regulares, avere) ----
    ("parlare", "are", "falar", "ar", None),
    ("guardare", "are", "olhar", "ar", None),
    ("ascoltare", "are", "escutar", "ar", None),
    ("aspettare", "are", "esperar", "ar", None),
    ("comprare", "are", "comprar", "ar", None),
    ("portare", "are", "levar", "ar", None),
    ("trovare", "are", "encontrar", "ar", None),
    ("pensare", "are", "pensar", "ar", None),
    ("chiamare", "are", "chamar", "ar", None),
    ("usare", "are", "usar", "ar", None),
    ("amare", "are", "amar", "ar", None),
    ("cantare", "are", "cantar", "ar", None),
    ("lavare", "are", "lavar", "ar", None),
    ("provare", "are", "provar", "ar", None),
    ("visitare", "are", "visitar", "ar", None),
    ("mostrare", "are", "mostrar", "ar", None),
    ("salutare", "are", "cumprimentar", "ar", None),
    ("desiderare", "are", "desejar", "ar", None),
    ("ricordare", "are", "lembrar", "ar", None),
    ("domandare", "are", "perguntar", "ar", None),
    ("lavorare", "are", "trabalhar", "ar", None),
    ("cucinare", "are", "cozinhar", "ar", None),
    ("telefonare", "are", "telefonar", "ar", None),
    ("prestare", "are", "emprestar", "ar", None),
    ("prenotare", "are", "reservar", "ar", None),
    ("affittare", "are", "alugar", "ar", None),
    ("firmare", "are", "assinar", "ar", None),
    ("controllare", "are", "controlar", "ar", None),
    ("misurare", "are", "medir", "ar", None),
    ("pesare", "are", "pesar", "ar", None),
    ("contare", "are", "contar", "ar", None),
    ("calcolare", "are", "calcular", "ar", None),
    ("preparare", "are", "preparar", "ar", None),
    ("presentare", "are", "apresentar", "ar", None),
    ("invitare", "are", "convidar", "ar", None),
    ("regalare", "are", "presentear", "ar", None),
    ("mandare", "are", "enviar", "ar", None),
    ("ringraziare", "are", "agradecer", "ar", None),
    ("aiutare", "are", "ajudar", "ar", None),
    ("sperare", "are", "esperar", "ar", None),
    ("dubitare", "are", "duvidar", "ar", None),
    ("ordinare", "are", "ordenar", "ar", None),
    ("completare", "are", "completar", "ar", None),
    ("terminare", "are", "terminar", "ar", None),
    ("fermare", "are", "parar", "ar", None),
    ("girare", "are", "girar", "ar", None),
    ("alzare", "are", "levantar", "ar", None),
    ("abbassare", "are", "abaixar", "ar", None),
    ("mescolare", "are", "misturar", "ar", None),
    ("versare", "are", "derramar", "ar", None),
    ("comandare", "are", "comandar", "ar", None),
    ("conquistare", "are", "conquistar", "ar", None),
    ("esplorare", "are", "explorar", "ar", None),
    ("ingannare", "are", "enganar", "ar", None),
    ("guidare", "are", "guiar", "ar", None),
    ("allenare", "are", "treinar", "ar", None),
    ("riposare", "are", "descansar", "ar", None),
    ("nuotare", "are", "nadar", "ar", None),
    ("ballare", "are", "dançar", "ar", None),
    ("camminare", "are", "caminhar", "ar", None),
    ("abitare", "are", "morar", "ar", None),
    ("incontrare", "are", "encontrar", "ar", None),
    ("dichiarare", "are", "declarar", "ar", None),
    ("considerare", "are", "considerar", "ar", None),
    ("rispettare", "are", "respeitar", "ar", None),
    ("accettare", "are", "aceitar", "ar", None),
    ("rifiutare", "are", "recusar", "ar", None),
    ("salvare", "are", "salvar", "ar", None),
    ("evitare", "are", "evitar", "ar", None),
    ("limitare", "are", "limitar", "ar", None),
    ("aumentare", "are", "aumentar", "ar", None),
    ("migliorare", "are", "melhorar", "ar", None),
    ("peggiorare", "are", "piorar", "ar", None),
    ("sviluppare", "are", "desenvolver", "er", None),
    ("realizzare", "are", "realizar", "ar", None),
    ("organizzare", "are", "organizar", "ar", None),
    ("utilizzare", "are", "utilizar", "ar", None),
    ("analizzare", "are", "analisar", "ar", None),
    ("votare", "are", "votar", "ar", None),
    ("governare", "are", "governar", "ar", None),
    ("amministrare", "are", "administrar", "ar", None),
    ("fotografare", "are", "fotografar", "ar", None),
    ("filmare", "are", "filmar", "ar", None),
    ("registrare", "are", "registrar", "ar", None),
    ("suonare", "are", "tocar", "ar", None),
    ("recitare", "are", "recitar", "ar", None),
    ("spazzare", "are", "varrer", "er", None),
    ("abbinare", "are", "combinar", "ar", None),
    ("raccontare", "are", "contar", "ar", None),
    ("raccomandare", "are", "recomendar", "ar", None),
    ("dominare", "are", "dominar", "ar", None),
    ("immaginare", "are", "imaginar", "ar", None),
    ("esaminare", "are", "examinar", "ar", None),
    ("eliminare", "are", "eliminar", "ar", None),
    ("indovinare", "are", "adivinhar", "ar", None),
    ("allontanare", "are", "afastar", "ar", None),
    ("avvicinare", "are", "aproximar", "ar", None),
    ("abbandonare", "are", "abandonar", "ar", None),
    ("perdonare", "are", "perdoar", "ar", None),
    ("funzionare", "are", "funcionar", "ar", None),
    ("abituare", "are", "acostumar", "ar", None),
    ("continuare", "are", "continuar", "ar", None),
    ("valutare", "are", "avaliar", "ar", None),
    ("adattare", "are", "adaptar", "ar", None),
    ("trattare", "are", "tratar", "ar", None),
    ("testare", "are", "testar", "ar", None),
    ("celebrare", "are", "celebrar", "ar", None),
    ("formare", "are", "formar", "ar", None),
    ("informare", "are", "informar", "ar", None),
    ("trasformare", "are", "transformar", "ar", None),
    ("confermare", "are", "confirmar", "ar", None),
    ("profumare", "are", "perfumar", "ar", None),
    ("fumare", "are", "fumar", "ar", None),
    ("liberare", "are", "libertar", "ar", None),
    ("operare", "are", "operar", "ar", None),
    ("superare", "are", "superar", "ar", None),
    ("separare", "are", "separar", "ar", None),
    ("riparare", "are", "reparar", "ar", None),
    ("comparare", "are", "comparar", "ar", None),
    ("penetrare", "are", "penetrar", "ar", None),
    ("trascinare", "are", "arrastar", "ar", None),
    ("tirare", "are", "puxar", "ar", None),
    ("spostare", "are", "deslocar", "ar", None),
    ("posare", "are", "pousar", "ar", None),
    ("gridare", "are", "gritar", "ar", None),
    ("saltare", "are", "pular", "ar", None),
    ("dimostrare", "are", "demonstrar", "ar", None),
    ("collaborare", "are", "colaborar", "ar", None),
    ("elaborare", "are", "elaborar", "ar", None),
    ("decorare", "are", "decorar", "ar", None),
    ("ignorare", "are", "ignorar", "ar", None),
    ("adorare", "are", "adorar", "ar", None),
    ("esagerare", "are", "exagerar", "ar", None),
    ("generare", "are", "gerar", "ar", None),
    ("tollerare", "are", "tolerar", "ar", None),
    ("moderare", "are", "moderar", "ar", None),
    ("numerare", "are", "numerar", "ar", None),
    ("recuperare", "are", "recuperar", "ar", None),
    ("cooperare", "are", "cooperar", "ar", None),
    ("illustrare", "are", "ilustrar", "ar", None),
    ("concentrare", "are", "concentrar", "ar", None),
    ("frustrare", "are", "frustrar", "ar", None),
    ("imitare", "are", "imitar", "ar", None),
    ("agitare", "are", "agitar", "ar", None),
    ("ereditare", "are", "herdar", "ar", None),
    ("esitare", "are", "hesitar", "ar", None),
    ("causare", "are", "causar", "ar", None),
    ("accusare", "are", "acusar", "ar", None),
    ("scusare", "are", "desculpar", "ar", None),
    ("affrontare", "are", "enfrentar", "ar", None),
    ("montare", "are", "montar", "ar", None),
    ("scontare", "are", "descontar", "ar", None),
    ("abusare", "are", "abusar", "ar", None),
    ("assicurare", "are", "assegurar", "ar", None),
    ("procurare", "are", "procurar", "ar", None),
    # ---- -ere / participio explícito ----
    ("credere", "ere", "acreditar", "ar", "creduto"),
    ("ricevere", "ere", "receber", "er", "ricevuto"),
    ("temere", "ere", "temer", "er", "temuto"),
    ("battere", "ere", "bater", "er", "battuto"),
    ("vendere", "ere", "vender", "er", "venduto"),
    ("cedere", "ere", "ceder", "er", "ceduto"),
    ("prendere", "ere", "pegar", "ar", "preso"),
    ("scrivere", "ere", "escrever", "er", "scritto"),
    ("chiudere", "ere", "fechar", "ar", "chiuso"),
    ("mettere", "ere", "colocar", "ar", "messo"),
    ("spendere", "ere", "gastar", "ar", "speso"),
    ("difendere", "ere", "defender", "er", "difeso"),
    ("decidere", "ere", "decidir", "ir", "deciso"),
    ("dividere", "ere", "dividir", "ir", "diviso"),
    ("rispondere", "ere", "responder", "er", "risposto"),
    ("rompere", "ere", "quebrar", "ar", "rotto"),
    ("discutere", "ere", "discutir", "ir", "discusso"),
    ("permettere", "ere", "permitir", "ir", "permesso"),
    ("spingere", "ere", "empurrar", "ar", "spinto"),
    ("nascondere", "ere", "esconder", "er", "nascosto"),
    ("aggiungere", "ere", "adicionar", "ar", "aggiunto"),
    ("raggiungere", "ere", "alcançar", "ar", "raggiunto"),
    ("accendere", "ere", "acender", "er", "acceso"),
    ("piangere", "ere", "chorar", "ar", "pianto"),
    # ---- -ire / -isc ----
    ("aprire", "ire", "abrir", "ir", "aperto"),
    ("capire", "isc", "entender", "er", None),
    ("pulire", "isc", "limpar", "ar", None),
    ("garantire", "isc", "garantir", "ir", None),
    ("unire", "isc", "unir", "ir", None),
]

IT_PRON = ["io", "tu", "lui", "noi", "voi", "loro"]
PT_PRON = ["eu", "você", "ele", "nós", "vocês", "eles"]
PT_KEY = ["1sg", "3sg", "3sg", "1pl", "3pl", "3pl"]

# --- italiano ---
IT_IMPERF = {
    "are": ["avo", "avi", "ava", "avamo", "avate", "avano"],
    "ere": ["evo", "evi", "eva", "evamo", "evate", "evano"],
    "ire": ["ivo", "ivi", "iva", "ivamo", "ivate", "ivano"],
    "isc": ["ivo", "ivi", "iva", "ivamo", "ivate", "ivano"],
}
IT_FUT = ["ò", "ai", "à", "emo", "ete", "anno"]
IT_AUX = ["ho", "hai", "ha", "abbiamo", "avete", "hanno"]
# imperativo: tu, Lei, noi, voi, loro
IT_IMP = {
    "are": ["a", "i", "iamo", "ate", "ino"],
    "ere": ["i", "a", "iamo", "ete", "ano"],
    "ire": ["i", "a", "iamo", "ite", "ano"],
    "isc": ["isci", "isca", "iamo", "ite", "iscano"],
}
IMP_PERSON_PT = ["tu", "Lei/você", "noi", "voi", "loro"]


def collapse(s):
    return s.replace("ii", "i")


def it_stem(inf):
    return inf[:-3]


def it_participle(inf, cls, part):
    if part:
        return part
    stem = it_stem(inf)
    if cls == "are":
        return stem + "ato"
    return stem + "ito"  # ire / isc


# --- português ---
def pt_stem(inf):
    return inf[:-2]


def pt_imperf(inf, cls):
    s = pt_stem(inf)
    if cls == "ar":
        return {"1sg": s + "ava", "2sg": s + "avas", "3sg": s + "ava",
                "1pl": s + "ávamos", "3pl": s + "avam"}
    return {"1sg": s + "ia", "2sg": s + "ias", "3sg": s + "ia",
            "1pl": s + "íamos", "3pl": s + "iam"}


def pt_futuro(inf):
    return {"1sg": inf + "ei", "2sg": inf + "ás", "3sg": inf + "á",
            "1pl": inf + "emos", "3pl": inf + "ão"}


def _ar_1sg_pret(inf):
    if inf.endswith("car"):
        return inf[:-3] + "quei"
    if inf.endswith("gar"):
        return inf[:-3] + "guei"
    if inf.endswith("çar"):
        return inf[:-3] + "cei"
    return inf[:-2] + "ei"


def pt_pret(inf, cls):
    s = pt_stem(inf)
    if cls == "ar":
        return {"1sg": _ar_1sg_pret(inf), "2sg": s + "aste", "3sg": s + "ou",
                "1pl": s + "amos", "3pl": s + "aram"}
    if cls == "er":
        return {"1sg": s + "i", "2sg": s + "este", "3sg": s + "eu",
                "1pl": s + "emos", "3pl": s + "eram"}
    return {"1sg": s + "i", "2sg": s + "iste", "3sg": s + "iu",
            "1pl": s + "imos", "3pl": s + "iram"}


def _ar_subj_base(inf):
    # base para 3sg do subjuntivo (-ar -> e), tratando ortografia
    if inf.endswith("car"):
        return inf[:-3] + "qu"
    if inf.endswith("gar"):
        return inf[:-3] + "gu"
    if inf.endswith("çar"):
        return inf[:-3] + "c"
    return inf[:-2]


def pt_imperative(inf, cls):
    """Retorna lista [tu, você, noi/nós, voi, loro] em português."""
    s = pt_stem(inf)
    if cls == "ar":
        tu = s + "a"               # 3ª sing. presente
        base = _ar_subj_base(inf)  # subjuntivo
        voce = base + "e"
        nos = base + "emos"
        vocs = base + "em"
    else:
        tu = s + "e"
        voce = s + "a"
        nos = s + "amos"
        vocs = s + "am"
    return [tu, voce, nos, voce_alt(voce, nos, vocs)[0], vocs]


def voce_alt(a, b, c):
    return [c]  # voi/loro usam a forma de "vocês"


def dart_list(items):
    return "[" + ", ".join("'" + s.replace("'", "\\'") + "'" for s in items) + "]"


def card(module, level, it, pt, it_alt=None, pt_alt=None, hint=None):
    fields = [
        f"moduleId: '{module}'",
        f"level: CefrLevel.{level}",
        f"it: '{it}'",
        f"pt: '{pt}'",
    ]
    if it_alt:
        fields.append(f"itAlt: {dart_list(sorted(set(it_alt)))}")
    if pt_alt:
        fields.append(f"ptAlt: {dart_list(sorted(set(pt_alt)))}")
    if hint:
        fields.append(f"hint: '{hint}'")
    return "  Flashcard(" + ", ".join(fields) + "),"


def main():
    passato, imperf, futuro, imper = [], [], [], []

    for it_inf, it_cls, pt_inf, pt_cls, part in V:
        stem = it_stem(it_inf)
        participio = it_participle(it_inf, it_cls, part)
        pt_pr = pt_pret(pt_inf, pt_cls)
        pt_im = pt_imperf(pt_inf, pt_cls)
        pt_fu = pt_futuro(pt_inf)
        it_imp_end = IT_IMP[it_cls]
        imperf_end = IT_IMPERF[it_cls]
        fut_stem = stem + ("ir" if it_cls in ("ire", "isc") else "er")

        for i in range(6):
            key = PT_KEY[i]
            # passato prossimo
            it_pp = f"{IT_PRON[i]} {IT_AUX[i]} {participio}"
            pt_pp = f"{PT_PRON[i]} {pt_pr[key]}"
            pp_alt = [pt_pr[key]]
            if i == 1:
                pp_alt += [f"tu {pt_pr['2sg']}", pt_pr["2sg"]]
            passato.append(card("verbos_passato", "b1", it_pp, pt_pp,
                                 it_alt=[f"{IT_AUX[i]} {participio}"],
                                 pt_alt=pp_alt, hint=f"{pt_inf} — passato prossimo"))
            # imperfetto
            it_if = f"{IT_PRON[i]} {stem}{imperf_end[i]}"
            pt_if = f"{PT_PRON[i]} {pt_im[key]}"
            if_alt = [pt_im[key]]
            if i == 1:
                if_alt += [f"tu {pt_im['2sg']}", pt_im["2sg"]]
            imperf.append(card("verbos_imperfetto", "b1", it_if, pt_if,
                               it_alt=[f"{stem}{imperf_end[i]}"],
                               pt_alt=if_alt, hint=f"{pt_inf} — imperfetto"))
            # futuro semplice
            it_fu = f"{IT_PRON[i]} {fut_stem}{IT_FUT[i]}"
            pt_fut = f"{PT_PRON[i]} {pt_fu[key]}"
            fu_alt = [pt_fu[key]]
            if i == 1:
                fu_alt += [f"tu {pt_fu['2sg']}", pt_fu["2sg"]]
            futuro.append(card("verbos_futuro", "b1", it_fu, pt_fut,
                              it_alt=[f"{fut_stem}{IT_FUT[i]}"],
                              pt_alt=fu_alt, hint=f"{pt_inf} — futuro semplice"))

        # imperativo (5 pessoas)
        pt_imp = pt_imperative(pt_inf, pt_cls)
        for j in range(5):
            it_form = collapse(stem + it_imp_end[j])
            imper.append(card("verbos_imperativo", "b1", it_form, pt_imp[j],
                            it_alt=None,
                            pt_alt=None,
                            hint=f"{pt_inf} — imperativo ({IMP_PERSON_PT[j]})"))

    out_lines = ["import '../models/flashcard.dart';", ""]
    out_lines.append("/// GERADO por tools/gen_tenses.py — verbos italianos <-> português em")
    out_lines.append("/// passato prossimo, imperfetto, futuro semplice e imperativo (todas as")
    out_lines.append("/// pessoas). Não edite à mão; rode o script e substitua o arquivo.")
    for name, lst in [
        ("kCardsPassato", passato),
        ("kCardsImperfetto", imperf),
        ("kCardsFuturo", futuro),
        ("kCardsImperativo", imper),
    ]:
        out_lines.append("")
        out_lines.append(f"const List<Flashcard> {name} = [")
        out_lines.extend(lst)
        out_lines.append("];")

    out = "/home/user/italian-brazilian-flashcards/lib/data/cards_tempos.dart"
    with open(out, "w", encoding="utf-8") as f:
        f.write("\n".join(out_lines) + "\n")
    print(f"passato={len(passato)} imperfetto={len(imperf)} "
          f"futuro={len(futuro)} imperativo={len(imper)}")


if __name__ == "__main__":
    main()
