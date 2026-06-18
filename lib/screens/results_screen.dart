import 'package:flutter/material.dart';

import '../services/score_store.dart';
import '../state/quiz_config.dart';
import '../state/quiz_session.dart';
import 'quiz_screen.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({
    super.key,
    required this.session,
    required this.config,
  });

  final QuizSession session;
  final QuizConfig config;

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final ScoreStore _store = ScoreStore();
  bool _isRecord = false;

  @override
  void initState() {
    super.initState();
    _save();
  }

  Future<void> _save() async {
    final record = await _store.record(
      score: widget.session.score,
      accuracy: widget.session.accuracy,
      correct: widget.session.correct,
    );
    if (!mounted) return;
    setState(() => _isRecord = record);
  }

  String _medal(double accuracy) {
    if (accuracy >= 0.9) return '🥇';
    if (accuracy >= 0.7) return '🥈';
    if (accuracy >= 0.5) return '🥉';
    return '📈';
  }

  String _message(double accuracy) {
    if (accuracy >= 0.9) return 'Eccellente! Desempenho excelente!';
    if (accuracy >= 0.7) return 'Molto bene! Muito bom!';
    if (accuracy >= 0.5) return 'Bene! Continue praticando.';
    return 'Coraggio! A prática leva à perfeição.';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = widget.session;
    final accuracyPct = (s.accuracy * 100).round();
    final wrong = s.total - s.correct;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    _medal(s.accuracy),
                    style: const TextStyle(fontSize: 72),
                  ),
                ),
                Center(
                  child: Text(
                    'Sessão concluída',
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    _message(s.accuracy),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white70),
                  ),
                ),
                if (_isRecord) ...[
                  const SizedBox(height: 12),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: .15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Colors.amber.withValues(alpha: .6)),
                      ),
                      child: const Text(
                        '🏆 Novo recorde de pontuação!',
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 28),

                Center(
                  child: Text(
                    '${s.score}',
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                Center(
                  child: Text('pontos', style: theme.textTheme.bodyMedium),
                ),
                const SizedBox(height: 24),

                Row(
                  children: [
                    _StatCard(
                      icon: Icons.check_circle_outline,
                      label: 'Acertos',
                      value: '${s.correct}/${s.total}',
                      color: Colors.greenAccent,
                    ),
                    const SizedBox(width: 12),
                    _StatCard(
                      icon: Icons.percent,
                      label: 'Precisão',
                      value: '$accuracyPct%',
                      color: theme.colorScheme.primary,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _StatCard(
                      icon: Icons.cancel_outlined,
                      label: 'Erros',
                      value: '$wrong',
                      color: Colors.redAccent,
                    ),
                    const SizedBox(width: 12),
                    _StatCard(
                      icon: Icons.local_fire_department_outlined,
                      label: 'Melhor seq.',
                      value: '${s.bestStreak}',
                      color: Colors.orangeAccent,
                    ),
                  ],
                ),
                if (widget.config.timerEnabled) ...[
                  const SizedBox(height: 12),
                  _StatCard(
                    icon: Icons.timer_outlined,
                    label: 'Tempo total',
                    value: _formatLong(s.elapsed),
                    color: Colors.lightBlueAccent,
                    fullWidth: true,
                  ),
                ],
                const SizedBox(height: 28),

                FilledButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => QuizScreen(config: widget.config),
                      ),
                    );
                  },
                  icon: const Icon(Icons.replay),
                  label: const Text('Jogar de novo'),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () =>
                      Navigator.of(context).popUntil((r) => r.isFirst),
                  icon: const Icon(Icons.tune),
                  label: const Text('Alterar configurações'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _formatLong(Duration d) {
  final m = d.inMinutes.remainder(60);
  final sec = d.inSeconds.remainder(60);
  if (d.inMinutes > 0) return '${m}min ${sec}s';
  return '${sec}s';
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.fullWidth = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final card = Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
    return fullWidth ? SizedBox(width: double.infinity, child: card) : Expanded(child: card);
  }
}
