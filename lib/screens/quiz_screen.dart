import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../i18n/strings.dart';
import '../models/flashcard.dart';
import '../state/quiz_config.dart';
import '../state/quiz_session.dart';
import 'results_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.config});

  final QuizConfig config;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final QuizSession _session;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _ticker;
  bool _showHint = false;

  @override
  void initState() {
    super.initState();
    _session = QuizSession(widget.config);
    if (widget.config.timerEnabled) {
      _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() {});
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    _session.abort();
    _session.dispose();
    super.dispose();
  }

  void _submit() {
    if (_session.answered) {
      _next();
      return;
    }
    if (_controller.text.trim().isEmpty) return;
    _session.submit(_controller.text);
    setState(() => _showHint = false);
  }

  void _next() {
    _session.next();
    _controller.clear();
    setState(() => _showHint = false);
    if (_session.finished) {
      _goToResults();
    } else {
      _focusNode.requestFocus();
    }
  }

  void _skip() {
    if (_session.answered) return;
    _session.skip();
    setState(() {});
  }

  void _goToResults() {
    _ticker?.cancel();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ResultsScreen(session: _session, config: widget.config),
      ),
    );
  }

  Future<bool> _confirmExit() async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.exitTitle),
        content: Text(S.exitContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(S.continueLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(S.exit),
          ),
        ],
      ),
    );
    return leave ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldLeave = await _confirmExit();
        if (!mounted) return;
        if (shouldLeave) Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              final shouldLeave = await _confirmExit();
              if (!mounted) return;
              if (shouldLeave) Navigator.of(context).pop();
            },
          ),
          title: AnimatedBuilder(
            animation: _session,
            builder: (_, __) => Text(
              '${_session.position} / ${_session.total}',
            ),
          ),
          actions: [
            if (widget.config.timerEnabled)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.timer_outlined, size: 18),
                      const SizedBox(width: 4),
                      Text(_formatDuration(_session.elapsed)),
                    ],
                  ),
                ),
              ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: AnimatedBuilder(
                animation: _session,
                builder: (context, _) => _buildBody(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);
    final question = _session.current;
    if (question == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final outcome = _session.lastOutcome;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // barra de progresso + pontuação
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: _session.total == 0
                        ? 0
                        : _session.position / _session.total,
                    minHeight: 8,
                    backgroundColor: Colors.white12,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _ScorePill(score: _session.score, streak: _session.streak),
            ],
          ),
          const SizedBox(height: 24),

          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: .15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${S.translateFrom(S.languageName(italian: !question.askingItalian))} • '
                        '${question.card.level.label} · '
                        '${S.module(question.card.moduleId)}',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Card(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 36),
                        alignment: Alignment.center,
                        child: Text(
                          question.prompt,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      S.answerIn(S.languageName(italian: question.askingItalian)),
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: Colors.white54),
                    ),
                    if (_showHint && question.card.hint != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        '💡 ${question.card.hint}',
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.amberAccent),
                      ),
                    ],
                    const SizedBox(height: 20),
                    if (outcome != null)
                      _FeedbackBox(
                        correct: outcome.correct,
                        expected: outcome.expected,
                        alternatives: question.acceptedAnswers.length > 1
                            ? question.acceptedAnswers.sublist(1)
                            : const [],
                        points: outcome.pointsAwarded,
                      ),
                  ],
                ),
              ),
            ),
          ),

          // campo de resposta
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            enabled: outcome == null,
            textInputAction: TextInputAction.done,
            autocorrect: false,
            enableSuggestions: false,
            textCapitalization: TextCapitalization.none,
            inputFormatters: [LengthLimitingTextInputFormatter(60)],
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              hintText: S.inputHint,
              prefixIcon: const Icon(Icons.keyboard_alt_outlined),
              suffixIcon: (question.card.hint != null && outcome == null)
                  ? IconButton(
                      tooltip: S.hintTooltip,
                      icon: const Icon(Icons.lightbulb_outline),
                      onPressed: () => setState(() => _showHint = true),
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (outcome == null)
                Expanded(
                  flex: 2,
                  child: OutlinedButton(
                    onPressed: _skip,
                    child: Text(S.skip),
                  ),
                ),
              if (outcome == null) const SizedBox(width: 12),
              Expanded(
                flex: 3,
                child: FilledButton(
                  onPressed: _submit,
                  child: Text(
                    outcome == null
                        ? S.answer
                        : (_session.position == _session.total
                            ? S.seeResult
                            : S.next),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String _formatDuration(Duration d) {
  final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
  final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$m:$s';
}

class _ScorePill extends StatelessWidget {
  const _ScorePill({required this.score, required this.streak});

  final int score;
  final int streak;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$score ${S.pts}',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (streak > 1)
          Text(
            S.streak(streak),
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Colors.orangeAccent),
          ),
      ],
    );
  }
}

class _FeedbackBox extends StatelessWidget {
  const _FeedbackBox({
    required this.correct,
    required this.expected,
    required this.alternatives,
    required this.points,
  });

  final bool correct;
  final String expected;
  final List<String> alternatives;
  final int points;

  @override
  Widget build(BuildContext context) {
    final color = correct ? Colors.greenAccent : Colors.redAccent;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: .5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                correct ? Icons.check_circle : Icons.cancel,
                color: color,
              ),
              const SizedBox(width: 8),
              Text(
                correct ? S.correct : S.almost,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              if (correct && points > 0)
                Text(
                  '+$points',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          if (!correct) ...[
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: S.answerLabel),
                  TextSpan(
                    text: expected,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
          if (alternatives.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              S.alsoAccepted(alternatives.join(', ')),
              style: const TextStyle(color: Colors.white60, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}
