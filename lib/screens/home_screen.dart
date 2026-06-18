import 'package:flutter/material.dart';

import '../data/modules.dart';
import '../models/flashcard.dart';
import '../services/score_store.dart';
import '../state/card_repository.dart';
import '../state/quiz_config.dart';
import 'custom_cards_screen.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<String> _selected = {...kModules.map((m) => m.id)};
  final Set<CefrLevel> _levels = {...CefrLevel.values};
  Direction _direction = Direction.itToPt;
  int _count = 15;
  bool _timer = true;
  bool _shuffle = true;

  final ScoreStore _store = ScoreStore();
  int _bestScore = 0;
  int _totalSessions = 0;

  static const List<int> _countOptions = [10, 15, 20, 30, 0];

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final best = await _store.bestScore();
    final sessions = await _store.totalSessions();
    if (!mounted) return;
    setState(() {
      _bestScore = best;
      _totalSessions = sessions;
    });
  }

  bool get _allSelected => _selected.length == kModules.length;

  int get _availableCards =>
      CardRepository.instance.cardsForSelection(_selected, _levels).length;

  void _toggleLevel(CefrLevel level) {
    setState(() {
      if (_levels.contains(level)) {
        _levels.remove(level);
      } else {
        _levels.add(level);
      }
    });
  }

  Future<void> _openCustomCards() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CustomCardsScreen()),
    );
    if (mounted) setState(() {}); // atualiza a contagem de cartões disponíveis
  }

  void _toggleAll() {
    setState(() {
      if (_allSelected) {
        _selected.clear();
      } else {
        _selected
          ..clear()
          ..addAll(kModules.map((m) => m.id));
      }
    });
  }

  void _toggleModule(String id) {
    setState(() {
      if (_selected.contains(id)) {
        _selected.remove(id);
      } else {
        _selected.add(id);
      }
    });
  }

  Future<void> _start() async {
    if (_selected.isEmpty || _levels.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione ao menos um módulo e um nível.'),
        ),
      );
      return;
    }
    if (_availableCards == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nenhum cartão para essa combinação de módulos e níveis.'),
        ),
      );
      return;
    }
    final config = QuizConfig(
      moduleIds: {..._selected},
      levels: {..._levels},
      direction: _direction,
      questionCount: _count,
      timerEnabled: _timer,
      shuffle: _shuffle,
    );
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => QuizScreen(config: config)),
    );
    _loadStats(); // atualiza recorde ao voltar
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              children: [
                const _Header(),
                const SizedBox(height: 16),
                _StatsBar(bestScore: _bestScore, sessions: _totalSessions),
                const SizedBox(height: 24),

                const _SectionTitle('Sentido da tradução'),
                const SizedBox(height: 8),
                _DirectionSelector(
                  value: _direction,
                  onChanged: (d) => setState(() => _direction = d),
                ),
                const SizedBox(height: 24),

                const _SectionTitle('Nível (A1–C1)'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    for (final level in CefrLevel.values)
                      FilterChip(
                        selected: _levels.contains(level),
                        onSelected: (_) => _toggleLevel(level),
                        label: Text(level.label),
                        tooltip: level.description,
                      ),
                  ],
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _SectionTitle('Módulos / áreas'),
                    TextButton.icon(
                      onPressed: _toggleAll,
                      icon: Icon(
                        _allSelected
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        size: 20,
                      ),
                      label: Text(_allSelected ? 'Limpar' : 'Todos'),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final m in kModules)
                      _ModuleChip(
                        module: m,
                        selected: _selected.contains(m.id),
                        onTap: () => _toggleModule(m.id),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '$_availableCards cartões disponíveis na seleção',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white60,
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _openCustomCards,
                  icon: const Icon(Icons.library_add_outlined),
                  label: const Text('Criar / gerenciar meus cartões'),
                ),
                const SizedBox(height: 24),

                const _SectionTitle('Número de perguntas'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    for (final opt in _countOptions)
                      ChoiceChip(
                        label: Text(opt == 0 ? 'Todas' : '$opt'),
                        selected: _count == opt,
                        onSelected: (_) => setState(() => _count = opt),
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _timer,
                  onChanged: (v) => setState(() => _timer = v),
                  title: const Text('Cronometrar a sessão'),
                  subtitle: const Text(
                    'Mostra o tempo e dá bônus de velocidade',
                  ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _shuffle,
                  onChanged: (v) => setState(() => _shuffle = v),
                  title: const Text('Embaralhar perguntas'),
                ),
                const SizedBox(height: 24),

                FilledButton.icon(
                  onPressed: _start,
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Iniciar sessão'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('🇮🇹', style: TextStyle(fontSize: 28)),
            const SizedBox(width: 6),
            Icon(Icons.swap_horiz, color: theme.colorScheme.primary),
            const SizedBox(width: 6),
            const Text('🇧🇷', style: TextStyle(fontSize: 28)),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Flashcards Italiano ⇄ Português',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Digite a resposta, ganhe pontos e marque seu tempo.',
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}

class _StatsBar extends StatelessWidget {
  const _StatsBar({required this.bestScore, required this.sessions});

  final int bestScore;
  final int sessions;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _stat(context, '🏆 Recorde', '$bestScore pts'),
            Container(width: 1, height: 32, color: Colors.white12),
            _stat(context, '📚 Sessões', '$sessions'),
          ],
        ),
      ),
    );
  }

  Widget _stat(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(label, style: theme.textTheme.bodySmall),
        const SizedBox(height: 2),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }
}

class _DirectionSelector extends StatelessWidget {
  const _DirectionSelector({required this.value, required this.onChanged});

  final Direction value;
  final ValueChanged<Direction> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Direction>(
      segments: const [
        ButtonSegment(value: Direction.itToPt, label: Text('IT → PT')),
        ButtonSegment(value: Direction.ptToIt, label: Text('PT → IT')),
        ButtonSegment(value: Direction.mixed, label: Text('Misto')),
      ],
      selected: {value},
      showSelectedIcon: false,
      onSelectionChanged: (s) => onChanged(s.first),
    );
  }
}

class _ModuleChip extends StatelessWidget {
  const _ModuleChip({
    required this.module,
    required this.selected,
    required this.onTap,
  });

  final StudyModule module;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: selected,
      onSelected: (_) => onTap(),
      avatar: Icon(
        module.icon,
        size: 18,
        color: selected ? Theme.of(context).colorScheme.primary : null,
      ),
      label: Text(module.label),
    );
  }
}
