import '../models/level_model.dart';
import 'levels/perseus_level_1.dart';
import 'levels/perseus_level_2.dart';
import 'levels/perseus_level_3.dart';
import 'levels/perseus_level_4.dart';
import 'levels/perseus_level_5.dart';
import 'levels/perseus_level_6.dart';
import 'levels/perseus_level_7.dart';

/// Реєстр рівнів розділу «Персей»
class PerseusLevels {
  static final List<LevelData?> _all = [
    PerseusLevel1.level, // 0 · α Mirfak   · 9×11 · path=16 · СКЛАДНО
    PerseusLevel2.level, // 1 · β Algol     · 9×11 · path=17 · СКЛАДНО
    PerseusLevel3.level, // 2 · γ Gamma Per · 9×11 · path=18 · СКЛАДНО
    PerseusLevel4.level, // 3 · δ Delta Per · 9×11 · path=19 · СКЛАДНО
    PerseusLevel5.level, // 4 · ε Eps Per   · 9×11 · path=20 · СКЛАДНО
    PerseusLevel6.level, // 5 · ζ Zeta Per  · 9×11 · path=21 · СКЛАДНО
    PerseusLevel7.level, // 6 · η Eta Per   · 9×11 · path=22 · СКЛАДНО
  ];

  static LevelData? getByIndex(int levelIndex) {
    if (levelIndex < 0 || levelIndex >= _all.length) return null;
    return _all[levelIndex];
  }
}
