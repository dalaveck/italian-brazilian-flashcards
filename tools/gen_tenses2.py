#!/usr/bin/env python3
"""Gera os DEMAIS tempos/modos verbais italianos <-> português, todas as pessoas
(~1000 cartões cada). Reaproveita a lista de verbos regulares `V` de
gen_tenses.py. Saída: lib/data/cards_tempos2.dart — não edite à mão.

Módulos gerados:
  verbos_passato_remoto        passato remoto            (parlai -> falei)
  verbos_trapassato            trapassato prossimo       (avevo parlato -> tinha falado)
  verbos_futuro_anteriore      futuro anteriore          (avrò parlato -> terei falado)
  verbos_condizionale          condizionale presente     (parlerei -> falaria)
  verbos_condizionale_passato  condizionale passato      (avrei parlato -> teria falado)
  verbos_cong_presente         congiuntivo presente      (che io parli -> que eu fale)
  verbos_cong_imperfetto       congiuntivo imperfetto    (che io parlassi -> que eu falasse)
  verbos_cong_passato          congiuntivo passato       (che io abbia parlato -> que eu tenha falado)
  verbos_cong_trapassato       congiuntivo trapassato    (che io avessi parlato -> que eu tivesse falado)
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from gen_tenses import (  # noqa: E402
    V, it_stem, it_participle, pt_stem, pt_pret, _ar_subj_base,
    IT_PRON, PT_PRON, PT_KEY, dart_list,
)

# ---------- italiano ----------
AVERE = {
    "imperf": ["avevo", "avevi", "aveva", "avevamo", "avevate", "avevano"],
    "fut": ["avrò", "avrai", "avrà", "avremo", "avrete", "avranno"],
    "cond": ["avrei", "avresti", "avrebbe", "avremmo", "avreste", "avrebbero"],
    "cong_pres": ["abbia", "abbia", "abbia", "abbiamo", "abbiate", "abbiano"],
    "cong_imp": ["avessi", "avessi", "avesse", "avessimo", "aveste", "avessero"],
}
PASSATO_REMOTO = {
    "are": ["ai", "asti", "ò", "ammo", "aste", "arono"],
    "ire": ["ii", "isti", "ì", "immo", "iste", "irono"],
    "isc": ["ii", "isti", "ì", "immo", "iste", "irono"],
}
CONDIZIONALE = ["ei", "esti", "ebbe", "emmo", "este", "ebbero"]
CONG_PRES = {
    "are": ["i", "i", "i", "iamo", "iate", "ino"],
    "ere": ["a", "a", "a", "iamo", "iate", "ano"],
    "ire": ["a", "a", "a", "iamo", "iate", "ano"],
    "isc": ["isca", "isca", "isca", "iamo", "iate", "iscano"],
}
CONG_IMP = {
    "are": ["assi", "assi", "asse", "assimo", "aste", "assero"],
    "ere": ["essi", "essi", "esse", "essimo", "este", "essero"],
    "ire": ["issi", "issi", "isse", "issimo", "iste", "issero"],
    "isc": ["issi", "issi", "isse", "issimo", "iste", "issero"],
}

# ---------- português ----------
PT_IRREG_PART = {
    "abrir": "aberto", "escrever": "escrito", "gastar": "gasto",
    "aceitar": "aceito",
}
TER = {
    "imperf": {"1sg": "tinha", "2sg": "tinhas", "3sg": "tinha", "1pl": "tínhamos", "3pl": "tinham"},
    "fut": {"1sg": "terei", "2sg": "terás", "3sg": "terá", "1pl": "teremos", "3pl": "terão"},
    "cond": {"1sg": "teria", "2sg": "terias", "3sg": "teria", "1pl": "teríamos", "3pl": "teriam"},
    "pres_subj": {"1sg": "tenha", "2sg": "tenhas", "3sg": "tenha", "1pl": "tenhamos", "3pl": "tenham"},
    "imp_subj": {"1sg": "tivesse", "2sg": "tivesses", "3sg": "tivesse", "1pl": "tivéssemos", "3pl": "tivessem"},
}


def pt_part(inf, cls):
    if inf in PT_IRREG_PART:
        return PT_IRREG_PART[inf]
    return pt_stem(inf) + ("ado" if cls == "ar" else "ido")


def pt_cond(inf):
    return {"1sg": inf + "ia", "2sg": inf + "ias", "3sg": inf + "ia",
            "1pl": inf + "íamos", "3pl": inf + "iam"}


def pt_pres_subj(inf, cls):
    if cls == "ar":
        b = _ar_subj_base(inf)
        return {"1sg": b + "e", "2sg": b + "es", "3sg": b + "e",
                "1pl": b + "emos", "3pl": b + "em"}
    s = pt_stem(inf)
    return {"1sg": s + "a", "2sg": s + "as", "3sg": s + "a",
            "1pl": s + "amos", "3pl": s + "am"}


def pt_imp_subj(inf, cls):
    s = pt_stem(inf)
    if cls == "ar":
        return {"1sg": s + "asse", "2sg": s + "asses", "3sg": s + "asse",
                "1pl": s + "ássemos", "3pl": s + "assem"}
    if cls == "er":
        return {"1sg": s + "esse", "2sg": s + "esses", "3sg": s + "esse",
                "1pl": s + "êssemos", "3pl": s + "essem"}
    return {"1sg": s + "isse", "2sg": s + "isses", "3sg": s + "isse",
            "1pl": s + "íssemos", "3pl": s + "issem"}


def card(module, level, it, pt, it_alt=None, pt_alt=None, hint=None):
    fields = [f"moduleId: '{module}'", f"level: CefrLevel.{level}",
              f"it: '{it}'", f"pt: '{pt}'"]
    if it_alt:
        fields.append(f"itAlt: {dart_list(sorted(set(it_alt)))}")
    if pt_alt:
        fields.append(f"ptAlt: {dart_list(sorted(set(pt_alt)))}")
    if hint:
        fields.append(f"hint: '{hint}'")
    return "  Flashcard(" + ", ".join(fields) + "),"


def main():
    out = {k: [] for k in [
        "PassatoRemoto", "Trapassato", "FuturoAnteriore", "Condizionale",
        "CondizionalePassato", "CongPresente", "CongImperfetto",
        "CongPassato", "CongTrapassato"]}

    def emit(bucket, module, level, it, pt, hint, it_bare, pt_bare, i, pt_2sg=None):
        ptalt = [pt_bare]
        if i == 1 and pt_2sg:
            ptalt += [pt_2sg]
        out[bucket].append(card(module, level, it, pt,
                                it_alt=[it_bare], pt_alt=ptalt, hint=hint))

    for it_inf, it_cls, pt_inf, pt_cls, part in V:
        stem = it_stem(it_inf)
        participio = it_participle(it_inf, it_cls, part)
        ptpart = pt_part(pt_inf, pt_cls)
        fut_stem = stem + ("ir" if it_cls in ("ire", "isc") else "er")
        pr = pt_pret(pt_inf, pt_cls)
        cond = pt_cond(pt_inf)
        psubj = pt_pres_subj(pt_inf, pt_cls)
        isubj = pt_imp_subj(pt_inf, pt_cls)

        for i in range(6):
            key = PT_KEY[i]
            itp, ptp = IT_PRON[i], PT_PRON[i]
            que = {"io": "que eu", "tu": "que você", "lui": "que ele",
                   "noi": "que nós", "voi": "que vocês", "loro": "que eles"}[itp]

            # passato remoto (só -are/-ire/-isc; -ere é irregular)
            if it_cls in PASSATO_REMOTO:
                f = stem + PASSATO_REMOTO[it_cls][i]
                emit("PassatoRemoto", "verbos_passato_remoto", "b2",
                     f"{itp} {f}", f"{ptp} {pr[key]}",
                     f"{pt_inf} — passato remoto", f, pr[key], i,
                     f"tu {pr['2sg']}")

            # condizionale presente
            f = fut_stem + CONDIZIONALE[i]
            emit("Condizionale", "verbos_condizionale", "b1",
                 f"{itp} {f}", f"{ptp} {cond[key]}",
                 f"{pt_inf} — condizionale presente", f, cond[key], i,
                 f"tu {cond['2sg']}")

            # congiuntivo presente
            f = stem + CONG_PRES[it_cls][i]
            emit("CongPresente", "verbos_cong_presente", "b2",
                 f"che {itp} {f}", f"{que} {psubj[key]}",
                 f"{pt_inf} — congiuntivo presente", f, psubj[key], i,
                 f"que tu {psubj['2sg']}")

            # congiuntivo imperfetto
            f = stem + CONG_IMP[it_cls][i]
            emit("CongImperfetto", "verbos_cong_imperfetto", "b2",
                 f"che {itp} {f}", f"{que} {isubj[key]}",
                 f"{pt_inf} — congiuntivo imperfetto", f, isubj[key], i,
                 f"que tu {isubj['2sg']}")

            # ----- compostos (avere + particípio) -----
            # trapassato prossimo
            aux = AVERE["imperf"][i]
            emit("Trapassato", "verbos_trapassato", "b1",
                 f"{itp} {aux} {participio}", f"{ptp} {TER['imperf'][key]} {ptpart}",
                 f"{pt_inf} — trapassato prossimo", f"{aux} {participio}",
                 f"{TER['imperf'][key]} {ptpart}", i,
                 f"tu {TER['imperf']['2sg']} {ptpart}")

            # futuro anteriore
            aux = AVERE["fut"][i]
            emit("FuturoAnteriore", "verbos_futuro_anteriore", "b2",
                 f"{itp} {aux} {participio}", f"{ptp} {TER['fut'][key]} {ptpart}",
                 f"{pt_inf} — futuro anteriore", f"{aux} {participio}",
                 f"{TER['fut'][key]} {ptpart}", i,
                 f"tu {TER['fut']['2sg']} {ptpart}")

            # condizionale passato
            aux = AVERE["cond"][i]
            emit("CondizionalePassato", "verbos_condizionale_passato", "b2",
                 f"{itp} {aux} {participio}", f"{ptp} {TER['cond'][key]} {ptpart}",
                 f"{pt_inf} — condizionale passato", f"{aux} {participio}",
                 f"{TER['cond'][key]} {ptpart}", i,
                 f"tu {TER['cond']['2sg']} {ptpart}")

            # congiuntivo passato
            aux = AVERE["cong_pres"][i]
            emit("CongPassato", "verbos_cong_passato", "c1",
                 f"che {itp} {aux} {participio}", f"{que} {TER['pres_subj'][key]} {ptpart}",
                 f"{pt_inf} — congiuntivo passato", f"{aux} {participio}",
                 f"{TER['pres_subj'][key]} {ptpart}", i,
                 f"que tu {TER['pres_subj']['2sg']} {ptpart}")

            # congiuntivo trapassato
            aux = AVERE["cong_imp"][i]
            emit("CongTrapassato", "verbos_cong_trapassato", "c1",
                 f"che {itp} {aux} {participio}", f"{que} {TER['imp_subj'][key]} {ptpart}",
                 f"{pt_inf} — congiuntivo trapassato", f"{aux} {participio}",
                 f"{TER['imp_subj'][key]} {ptpart}", i,
                 f"que tu {TER['imp_subj']['2sg']} {ptpart}")

    names = {
        "PassatoRemoto": "kCardsPassatoRemoto",
        "Trapassato": "kCardsTrapassato",
        "FuturoAnteriore": "kCardsFuturoAnteriore",
        "Condizionale": "kCardsCondizionale",
        "CondizionalePassato": "kCardsCondizionalePassato",
        "CongPresente": "kCardsCongPresente",
        "CongImperfetto": "kCardsCongImperfetto",
        "CongPassato": "kCardsCongPassato",
        "CongTrapassato": "kCardsCongTrapassato",
    }
    lines = ["import '../models/flashcard.dart';", "",
             "/// GERADO por tools/gen_tenses2.py — demais tempos/modos verbais",
             "/// (passato remoto, trapassato, futuro anteriore, condizionale e",
             "/// congiuntivo). Não edite à mão; rode o script e substitua."]
    for bucket, varname in names.items():
        lines.append("")
        lines.append(f"const List<Flashcard> {varname} = [")
        lines.extend(out[bucket])
        lines.append("];")

    path = "/home/user/italian-brazilian-flashcards/lib/data/cards_tempos2.dart"
    with open(path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")
    print({k: len(v) for k, v in out.items()},
          "TOTAL", sum(len(v) for v in out.values()))


if __name__ == "__main__":
    main()
