import '../models/level_model.dart';
import 'levels/cassiopeia_level_1.dart';
import 'levels/cassiopeia_level_2.dart';
import 'levels/cassiopeia_level_3.dart';
import 'levels/cassiopeia_level_4.dart';
import 'levels/cassiopeia_level_5.dart';

class CassiopeiaLevels {
  static final List<LevelData> all = [
    CassiopeiaLevel1.level, // 0 · β Каф     · 8×10 · path=14 · ЛЕГКО
    CassiopeiaLevel2.level, // 1 · α Шедар   · 8×10 · path=15 · ЛЕГКО
    CassiopeiaLevel3.level, // 2 · γ Наві    · 8×10 · path=16 · СКЛАДНІШЕ
    CassiopeiaLevel4.level, // 3 · δ Рухба   · 8×10 · path=18 · СКЛАДНО
    CassiopeiaLevel5.level, // 4 · ε Сегін   · 8×10 · path=20 · СКЛАДНО
  ];

  static LevelData? getByIndex(int levelIndex) {
    if (levelIndex < 0 || levelIndex >= all.length) return null;
    return all[levelIndex];
  }
}
