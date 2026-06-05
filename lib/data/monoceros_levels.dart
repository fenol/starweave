import '../models/level_model.dart';
import 'levels/monoceros_level_1.dart';
import 'levels/monoceros_level_2.dart';
import 'levels/monoceros_level_3.dart';
import 'levels/monoceros_level_4.dart';
import 'levels/monoceros_level_5.dart';

class MonocerosLevels {
  static final List<LevelData> all = [
    MonocerosLevel1.level, // α Альфа Єдин.
    MonocerosLevel2.level, // β Бета Єдин.
    MonocerosLevel3.level, // γ Гамма Єдин.
    MonocerosLevel4.level, // δ Дельта Єдин.
    MonocerosLevel5.level, // ε Єпсілон Єдин.
  ];

  static LevelData? getByIndex(int levelIndex) {
    if (levelIndex < 0 || levelIndex >= all.length) return null;
    return all[levelIndex];
  }
}
