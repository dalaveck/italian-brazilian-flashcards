import 'package:flutter/material.dart';

import '../data/modules.dart';
import '../models/flashcard.dart';
import '../state/card_repository.dart';

/// Tela para criar, listar e remover flashcards do próprio usuário.
class CustomCardsScreen extends StatefulWidget {
  const CustomCardsScreen({super.key});

  @override
  State<CustomCardsScreen> createState() => _CustomCardsScreenState();
}

class _CustomCardsScreenState extends State<CustomCardsScreen> {
  final CardRepository _repo = CardRepository.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus cartões')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openEditor,
        icon: const Icon(Icons.add),
        label: const Text('Novo cartão'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: AnimatedBuilder(
              animation: _repo,
              builder: (context, _) {
                final cards = _repo.customCards;
                if (cards.isEmpty) {
                  return const _EmptyState();
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                  itemCount: cards.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, i) {
                    final card = cards[cards.length - 1 - i]; // mais recentes no topo
                    return _CardTile(
                      card: card,
                      onEdit: () => _openEditor(existing: card),
                      onDelete: () => _confirmDelete(card),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openEditor({Flashcard? existing}) async {
    final result = await showModalBottomSheet<Flashcard>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _CardEditor(existing: existing),
    );
    if (result == null) return;
    if (existing == null) {
      await _repo.add(result);
    } else {
      await _repo.update(result);
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(existing == null ? 'Cartão adicionado!' : 'Cartão atualizado!'),
      ),
    );
  }

  Future<void> _confirmDelete(Flashcard card) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir cartão?'),
        content: Text('"${card.it}" → "${card.pt}"'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (ok == true && card.id != null) {
      await _repo.remove(card.id!);
    }
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🗂️', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          Text(
            'Nenhum cartão seu ainda',
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Toque em "Novo cartão" para criar seus próprios flashcards. '
            'Eles ficam salvos e aparecem na próxima vez que você abrir o app.',
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _CardTile extends StatelessWidget {
  const _CardTile({
    required this.card,
    required this.onEdit,
    required this.onDelete,
  });

  final Flashcard card;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
        title: Text(
          '${card.it}  →  ${card.pt}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            moduleLabel(card.moduleId),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'Editar',
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: Colors.redAccent,
              tooltip: 'Excluir',
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

/// Formulário (bottom sheet) para criar ou editar um cartão.
class _CardEditor extends StatefulWidget {
  const _CardEditor({this.existing});

  final Flashcard? existing;

  @override
  State<_CardEditor> createState() => _CardEditorState();
}

class _CardEditorState extends State<_CardEditor> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _it;
  late final TextEditingController _pt;
  late final TextEditingController _itAlt;
  late final TextEditingController _ptAlt;
  late final TextEditingController _hint;
  late String _moduleId;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _it = TextEditingController(text: e?.it ?? '');
    _pt = TextEditingController(text: e?.pt ?? '');
    _itAlt = TextEditingController(text: e?.itAlt.join(', ') ?? '');
    _ptAlt = TextEditingController(text: e?.ptAlt.join(', ') ?? '');
    _hint = TextEditingController(text: e?.hint ?? '');
    _moduleId = e?.moduleId ?? 'personalizados';
  }

  @override
  void dispose() {
    _it.dispose();
    _pt.dispose();
    _itAlt.dispose();
    _ptAlt.dispose();
    _hint.dispose();
    super.dispose();
  }

  List<String> _splitAlts(String raw) {
    return raw
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final existing = widget.existing;
    final card = Flashcard(
      id: existing?.id ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      moduleId: _moduleId,
      it: _it.text.trim(),
      pt: _pt.text.trim(),
      itAlt: _splitAlts(_itAlt.text),
      ptAlt: _splitAlts(_ptAlt.text),
      hint: _hint.text.trim().isEmpty ? null : _hint.text.trim(),
    );
    Navigator.pop(context, card);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isEditing = widget.existing != null;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 20 + bottomInset),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              isEditing ? 'Editar cartão' : 'Novo cartão',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: _moduleId,
                      decoration: const InputDecoration(labelText: 'Módulo'),
                      items: [
                        for (final m in kModules)
                          DropdownMenuItem(
                            value: m.id,
                            child: Text(m.label),
                          ),
                      ],
                      onChanged: (v) =>
                          setState(() => _moduleId = v ?? 'personalizados'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _it,
                      textCapitalization: TextCapitalization.none,
                      decoration: const InputDecoration(
                        labelText: 'Italiano *',
                        hintText: 'ex.: gatto',
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Informe a palavra em italiano'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _pt,
                      decoration: const InputDecoration(
                        labelText: 'Português *',
                        hintText: 'ex.: gato',
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Informe a tradução em português'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _ptAlt,
                      decoration: const InputDecoration(
                        labelText: 'Outras respostas em português (opcional)',
                        hintText: 'separe por vírgula',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _itAlt,
                      decoration: const InputDecoration(
                        labelText: 'Outras respostas em italiano (opcional)',
                        hintText: 'separe por vírgula',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _hint,
                      decoration: const InputDecoration(
                        labelText: 'Dica (opcional)',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save_outlined),
              label: Text(isEditing ? 'Salvar alterações' : 'Adicionar cartão'),
            ),
          ],
        ),
      ),
    );
  }
}
