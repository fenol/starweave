import '../models/level_model.dart';
import 'levels/taurus_level_1.dart';
import 'levels/taurus_level_2.dart';
import 'levels/taurus_level_3.dart';
import 'levels/taurus_level_4.dart';
import 'levels/taurus_level_5.dart';
import 'levels/taurus_level_6.dart';
import 'levels/taurus_level_7.dart';
import 'levels/taurus_level_8.dart';
import 'levels/taurus_level_9.dart';

class TaurusLevels {
  static final List<LevelData> all = [
    TaurusLevel1.level, // α Альдебаран
    TaurusLevel2.level, // β Ельнат
    TaurusLevel3.level, // γ Гіад I
    TaurusLevel4.level, // δ Гіад II
    TaurusLevel5.level, // ε Айн
    TaurusLevel6.level, // ζ Зета Тельця
    TaurusLevel7.level, // η Альціона
    TaurusLevel8.level, // θ Тета Тельця
    TaurusLevel9.level, // λ Лямбда Тельця
  ];

  static LevelData? getByIndex(int levelIndex) {
    if (levelIndex < 0 || levelIndex >= all.length) return null;
    return all[levelIndex];
  }
}
