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
    id: 'corpo',
    label: 'Corpo humano',
    icon: Icons.accessibility_new,
  ),
  StudyModule(
    id: 'casa',
    label: 'Casa e móveis',
    icon: Icons.chair_outlined,
  ),
  StudyModule(
    id: 'roupas',
    label: 'Roupas',
    icon: Icons.checkroom,
  ),
  StudyModule(
    id: 'animais',
    label: 'Animais',
    icon: Icons.pets,
  ),
  StudyModule(
    id: 'lugares',
    label: 'Cidade e lugares',
    icon: Icons.location_city,
  ),
  StudyModule(
    id: 'transporte',
    label: 'Transporte e viagem',
    icon: Icons.directions_bus_outlined,
  ),
  StudyModule(
    id: 'compras',
    label: 'Compras e dinheiro',
    icon: Icons.shopping_cart_outlined,
  ),
  StudyModule(
    id: 'profissoes',
    label: 'Profissões e trabalho',
    icon: Icons.work_outline,
  ),
  StudyModule(
    id: 'educacao',
    label: 'Educação e estudos',
    icon: Icons.school_outlined,
  ),
  StudyModule(
    id: 'natureza',
    label: 'Natureza e clima',
    icon: Icons.cloud_outlined,
  ),
  StudyModule(
    id: 'saude',
    label: 'Saúde e corpo',
    icon: Icons.local_hospital_outlined,
  ),
  StudyModule(
    id: 'tecnologia',
    label: 'Tecnologia',
    icon: Icons.devices_outlined,
  ),
  StudyModule(
    id: 'emocoes',
    label: 'Sentimentos e emoções',
    icon: Icons.mood,
  ),
  StudyModule(
    id: 'verbos_avancados',
    label: 'Verbos avançados',
    icon: Icons.flash_on,
  ),
  StudyModule(
    id: 'adverbios',
    label: 'Advérbios',
    icon: Icons.speed,
  ),
  StudyModule(
    id: 'conjuncoes',
    label: 'Conjunções e conectores',
    icon: Icons.link,
  ),
  StudyModule(
    id: 'abstratos',
    label: 'Conceitos abstratos',
    icon: Icons.psychology_outlined,
  ),
  StudyModule(
    id: 'expressoes',
    label: 'Expressões idiomáticas',
    icon: Icons.format_quote,
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
