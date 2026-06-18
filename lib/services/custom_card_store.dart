import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/flashcard.dart';

/// Persiste os flashcards criados pelo usuário.
///
/// No Flutter Web, `shared_preferences` grava em `localStorage`, então os
/// cartões continuam disponíveis quando o usuário retorna ao app.
class CustomCardStore {
  static const _key = 'custom_cards_v1';

  Future<List<Flashcard>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return [];
    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map((e) => Flashcard.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> save(List<Flashcard> cards) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(cards.map((c) => c.toJson()).toList());
    await prefs.setString(_key, raw);
  }
}
