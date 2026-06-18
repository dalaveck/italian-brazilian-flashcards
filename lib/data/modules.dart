import 'package:flutter/material.dart';

/// Metadados de um módulo/área de estudo.
class StudyModule {
  const StudyModule({
    required this.id,
    required this.label,
    required this.icon,
  });

  final String id;
  final String label;
  final IconData icon;
}

/// Lista de módulos disponíveis (ordem usada na tela inicial).
const List<StudyModule> kModules = [
  StudyModule(
    id: 'verbos_presente',
    label: 'Verbos no presente',
    icon: Icons.bolt_outlined,
  ),
  StudyModule(
    id: 'verbos_infinitivo',
    label: 'Verbos (infinitivo)',
    icon: Icons.play_circle_outline,
  ),
  StudyModule(
    id: 'preposicoes',
    label: 'Preposições',
    icon: Icons.compare_arrows,
  ),
  StudyModule(
    id: 'artigos',
    label: 'Artigos',
    icon: Icons.short_text,
  ),
  StudyModule(
    id: 'substantivos',
    label: 'Substantivos comuns',
    icon: Icons.category_outlined,
  ),
  StudyModule(
    id: 'adjetivos',
    label: 'Adjetivos',
    icon: Icons.palette_outlined,
  ),
  StudyModule(
    id: 'numeros',
    label: 'Números',
    icon: Icons.pin_outlined,
  ),
  StudyModule(
    id: 'cores',
    label: 'Cores',
    icon: Icons.color_lens_outlined,
  ),
  StudyModule(
    id: 'familia',
    label: 'Família',
    icon: Icons.family_restroom,
  ),
  StudyModule(
    id: 'comida',
    label: 'Comida e bebida',
    icon: Icons.restaurant_outlined,
  ),
  StudyModule(
    id: 'saudacoes',
    label: 'Saudações e expressões',
    icon: Icons.waving_hand_outlined,
  ),
  StudyModule(
    id: 'tempo',
    label: 'Tempo e dias',
    icon: Icons.calendar_today_outlined,
  ),
  StudyModule(
    id: 'personalizados',
    label: 'Meus cartões',
    icon: Icons.star_outline,
  ),
];

String moduleLabel(String id) {
  return kModules
      .firstWhere(
        (m) => m.id == id,
        orElse: () => const StudyModule(
          id: '?',
          label: 'Outro',
          icon: Icons.help_outline,
        ),
      )
      .label;
}
