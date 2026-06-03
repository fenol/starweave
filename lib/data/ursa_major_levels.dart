import '../models/level_model.dart';
import 'levels/ursa_major_level_1.dart';
import 'levels/ursa_major_level_2.dart';
import 'levels/ursa_major_level_3.dart';
import 'levels/ursa_major_level_4.dart';
import 'levels/ursa_major_level_5.dart';
import 'levels/ursa_major_level_6.dart';
import 'levels/ursa_major_level_7.dart';

/// Реєстр всіх рівнів розділу «Велика Ведмедиця»
///
/// Зірки впорядковані від найменш яскравої (рівень 1) до найяскравішої (рівень 7).
/// Індекс у списку відповідає [ConstellationStar.levelIndex].
class UrsaMajorLevels {
  static final List<LevelData> all = [
    UrsaMajorLevel1.level, // 0 · δ Megrez  · 6×6  · path=6  · ЛЕГКО
    UrsaMajorLevel2.level, // 1 · γ Phecda  · 6×6  · path=7  · ЛЕГКО
    UrsaMajorLevel3.level, // 2 · β Merak   · 7×6  · path=8  · ЛЕГКО+
    UrsaMajorLevel4.level, // 3 · ζ Mizar   · 7×7  · path=9  · СЕРЕДНЬО
    UrsaMajorLevel5.level, // 4 · η Alkaid  · 7×7  · path=10 · СЕРЕДНЬО+
    UrsaMajorLevel6.level, // 5 · α Dubhe   · 8×7  · path=11 · СКЛАДНО
    UrsaMajorLevel7.level, // 6 · ε Alioth  · 8×8  · path=12 · СКЛАДНО
  ];

  /// Повертає дані рівня за індексом зірки (0–6).
  /// Повертає null якщо рівень ще не написаний.
  static LevelData? getByIndex(int levelIndex) {
    if (levelIndex < 0 || levelIndex >= all.length) return null;
    return all[levelIndex];
  }
}
