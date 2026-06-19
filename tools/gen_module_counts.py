#!/usr/bin/env python3
"""Gera lib/data/module_card_counts.dart.

Varre os arquivos de cartões internos (decks.dart + cards_*.dart) e conta os
cartões por (moduleId, nível CEFR). O resultado é usado pela HomeScreen para
mostrar quantos cartões existem na seleção SEM precisar carregar os decks
pesados (que ficam atrás de imports `deferred`).

Rode após alterar QUALQUER arquivo de cartões (inclusive os gerados):

    python3 tools/gen_module_counts.py

Não edite o .dart de saída à mão.
"""
import re
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "lib" / "data"

# Arquivos com cartões internos. A ordem não importa (a saída é ordenada).
SOURCES = [
    "decks.dart",
    "cards_a2.dart",
    "cards_b1.dart",
    "cards_b2.dart",
    "cards_c1.dart",
    "cards_conjugacoes.dart",
    "cards_essenciais.dart",
    "cards_tempos.dart",
    "cards_tempos2.dart",
]

LEVELS = ["a1", "a2", "b1", "b2", "c1"]

_card = re.compile(r"Flashcard\(")
_module = re.compile(r"moduleId:\s*'([a-z_]+)'")
_level = re.compile(r"level:\s*CefrLevel\.([a-z0-9]+)")


def main() -> None:
    counts: dict[str, dict[str, int]] = defaultdict(lambda: defaultdict(int))
    for name in SOURCES:
        text = (DATA / name).read_text(encoding="utf-8")
        for line in text.splitlines():
            if not _card.search(line):
                continue
            m = _module.search(line)
            if not m:
                continue
            module_id = m.group(1)
            lvl = _level.search(line)
            # Sem `level:` explícito => padrão do Flashcard (a1).
            level = lvl.group(1) if lvl else "a1"
            counts[module_id][level] += 1

    out = [
        "// GERADO por tools/gen_module_counts.py — não edite à mão.",
        "// Rode `python3 tools/gen_module_counts.py` após alterar os cartões.",
        "",
        "import '../models/flashcard.dart';",
        "",
        "/// Contagem de cartões internos por módulo e nível CEFR.",
        "///",
        "/// Permite à HomeScreen mostrar quantos cartões existem na seleção sem",
        "/// carregar os decks pesados (que ficam atrás de imports `deferred` em",
        "/// `card_repository.dart`). Não inclui os cartões do usuário.",
        "const Map<String, Map<CefrLevel, int>> kModuleCardCounts = {",
    ]
    for module_id in sorted(counts):
        per_level = counts[module_id]
        entries = ", ".join(
            f"CefrLevel.{lvl}: {per_level[lvl]}"
            for lvl in LEVELS
            if per_level.get(lvl)
        )
        out.append(f"  '{module_id}': {{{entries}}},")
    out.append("};")
    out.append("")

    (DATA / "module_card_counts.dart").write_text("\n".join(out), encoding="utf-8")
    total = sum(sum(v.values()) for v in counts.values())
    print(f"module_card_counts.dart: {len(counts)} módulos, {total} cartões.")


if __name__ == "__main__":
    main()
