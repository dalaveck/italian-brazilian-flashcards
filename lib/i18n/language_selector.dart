import 'package:flutter/material.dart';

import 'app_locale.dart';

/// Botão no canto superior direito para escolher o idioma da interface
/// (italiano ou português). Não altera o conteúdo dos cartões nem o sentido
/// das respostas — apenas os textos do sistema.
class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppLocale.instance,
      builder: (context, _) {
        final lang = AppLocale.instance.lang;
        final flag = lang == AppLang.it ? '🇮🇹' : '🇧🇷';
        final code = lang == AppLang.it ? 'IT' : 'PT';
        return PopupMenuButton<AppLang>(
          tooltip: lang == AppLang.it
              ? 'Lingua dell\'interfaccia'
              : 'Idioma da interface',
          onSelected: AppLocale.instance.setLang,
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: AppLang.pt,
              child: Text('🇧🇷  Português'),
            ),
            PopupMenuItem(
              value: AppLang.it,
              child: Text('🇮🇹  Italiano'),
            ),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(flag, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 6),
                Text(
                  code,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.arrow_drop_down, size: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
