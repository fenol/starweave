import '../models/level_model.dart';
import 'levels/auriga_level_1.dart';
import 'levels/auriga_level_2.dart';
import 'levels/auriga_level_3.dart';
import 'levels/auriga_level_4.dart';
import 'levels/auriga_level_5.dart';

class AurigaLevels {
  static final List<LevelData> all = [
    AurigaLevel1.level, // α Капелла
    AurigaLevel2.level, // β Менкалінан
    AurigaLevel3.level, // ε Альмааз
    AurigaLevel4.level, // ζ Садатоні
    AurigaLevel5.level, // θ Махасім
  ];

  static LevelData? getByIndex(int levelIndex) {
    if (levelIndex < 0 || levelIndex >= all.length) return null;
    return all[levelIndex];
  }
}
