import '../models/level_model.dart';
import 'levels/canis_major_level_1.dart';
import 'levels/canis_major_level_2.dart';
import 'levels/canis_major_level_3.dart';
import 'levels/canis_major_level_4.dart';
import 'levels/canis_major_level_5.dart';
import 'levels/canis_major_level_6.dart';

class CanisMajorLevels {
  static final List<LevelData> all = [
    CanisMajorLevel1.level, // α Сіріус
    CanisMajorLevel2.level, // β Мірзам
    CanisMajorLevel3.level, // γ Муліфейн
    CanisMajorLevel4.level, // δ Везен
    CanisMajorLevel5.level, // ε Адхара
    CanisMajorLevel6.level, // η Алюдра
  ];

  static LevelData? getByIndex(int levelIndex) {
    if (levelIndex < 0 || levelIndex >= all.length) return null;
    return all[levelIndex];
  }
}
