import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Idiomas da interface do sistema (não afeta o conteúdo dos cartões).
enum AppLang { pt, it }

/// Guarda e persiste o idioma da interface escolhido pelo usuário.
///
/// Importante: este idioma muda apenas os textos do sistema (rótulos, botões,
/// títulos). Ele **não** altera o sentido das traduções nem as respostas dos
/// cartões — serve para que falantes de italiano também consigam usar o app.
class AppLocale extends ChangeNotifier {
  AppLocale._();

  static final AppLocale instance = AppLocale._();

  static const String _prefsKey = 'app_lang';

  AppLang _lang = AppLang.pt;
  AppLang get lang => _lang;

  bool get isItalian => _lang == AppLang.it;

  /// Carrega o idioma salvo (chamado no `main()` antes do `runApp`).
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _lang = prefs.getString(_prefsKey) == 'it' ? AppLang.it : AppLang.pt;
    notifyListeners();
  }

  /// Define e persiste o idioma da interface.
  Future<void> setLang(AppLang lang) async {
    if (_lang == lang) return;
    _lang = lang;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, lang == AppLang.it ? 'it' : 'pt');
  }

  void toggle() {
    setLang(_lang == AppLang.it ? AppLang.pt : AppLang.it);
  }
}
