import '../models/level_model.dart';
import 'levels/orion_level_1.dart';
import 'levels/orion_level_2.dart';
import 'levels/orion_level_3.dart';
import 'levels/orion_level_4.dart';
import 'levels/orion_level_5.dart';
import 'levels/orion_level_6.dart';
import 'levels/orion_level_7.dart';

/// Реєстр всіх рівнів розділу «Оріон»
class OrionLevels {
  static final List<LevelData> all = [
    OrionLevel1.level, // 0 · δ Mintaka    · 10×10 · path=10 · СЕРЕДНЬО
    OrionLevel2.level, // 1 · ε Alnilam    · 10×10 · path=12 · СЕРЕДНЬО
    OrionLevel3.level, // 2 · ζ Alnitak    · 10×10 · path=12 · СЕРЕДНЬО
    OrionLevel4.level, // 3 · γ Bellatrix  · 12×12 · path=14 · СКЛАДНО
    OrionLevel5.level, // 4 · κ Saiph      · 12×12 · path=15 · СКЛАДНО
    OrionLevel6.level, // 5 · α Betelgeuse · 12×12 · path=16 · СКЛАДНО
    OrionLevel7.level, // 6 · β Rigel      · 12×12 · path=18 · СКЛАДНО
  ];

  /// Повертає дані рівня за індексом зірки (0–6).
  static LevelData? getByIndex(int levelIndex) {
    if (levelIndex < 0 || levelIndex >= all.length) return null;
    return all[levelIndex];
  }
}
