import 'package:shared_preferences/shared_preferences.dart';

/// Persiste o melhor desempenho do usuário (recorde) entre sessões.
///
/// Usa `shared_preferences`, que no Flutter Web grava em `localStorage`.
class ScoreStore {
  static const _kBestScore = 'best_score';
  static const _kBestAccuracy = 'best_accuracy';
  static const _kTotalSessions = 'total_sessions';
  static const _kTotalCorrect = 'total_correct';

  Future<int> bestScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kBestScore) ?? 0;
  }

  Future<double> bestAccuracy() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_kBestAccuracy) ?? 0;
  }

  Future<int> totalSessions() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kTotalSessions) ?? 0;
  }

  Future<int> totalCorrect() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kTotalCorrect) ?? 0;
  }

  /// Registra o resultado de uma sessão. Retorna `true` se bateu o recorde.
  Future<bool> record({
    required int score,
    required double accuracy,
    required int correct,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final previousBest = prefs.getInt(_kBestScore) ?? 0;

    await prefs.setInt(
      _kTotalSessions,
      (prefs.getInt(_kTotalSessions) ?? 0) + 1,
    );
    await prefs.setInt(
      _kTotalCorrect,
      (prefs.getInt(_kTotalCorrect) ?? 0) + correct,
    );

    final isRecord = score > previousBest;
    if (isRecord) {
      await prefs.setInt(_kBestScore, score);
    }
    final previousAcc = prefs.getDouble(_kBestAccuracy) ?? 0;
    if (accuracy > previousAcc) {
      await prefs.setDouble(_kBestAccuracy, accuracy);
    }
    return isRecord;
  }
}
