import '../models/level_model.dart';
import 'levels/gemini_level_1.dart';
import 'levels/gemini_level_2.dart';
import 'levels/gemini_level_3.dart';
import 'levels/gemini_level_4.dart';
import 'levels/gemini_level_5.dart';
import 'levels/gemini_level_6.dart';
import 'levels/gemini_level_7.dart';
import 'levels/gemini_level_8.dart';

class GeminiLevels {
  static final List<LevelData> _all = [
    GeminiLevel1.level, // 0 · α Кастор  · 8×10 · path=21 · СКЛАДНО
    GeminiLevel2.level, // 1 · β Поллукс · 8×10 · path=20 · СКЛАДНО
    GeminiLevel3.level, // 2 · γ Альхена · 8×10 · path=25 · СКЛАДНО
    GeminiLevel4.level, // 3 · δ Васат   · 8×10 · path=22 · СКЛАДНО
    GeminiLevel5.level, // 4 · ε Мебсута · 8×10 · path=24 · СКЛАДНО
    GeminiLevel6.level, // 5 · ζ Мекбута · 8×10 · path=23 · СКЛАДНО
    GeminiLevel7.level, // 6 · η Пропус  · 8×10 · path=26 · СКЛАДНО
    GeminiLevel8.level, // 7 · μ Тейат   · 8×10 · path=26 · СКЛАДНО
  ];

  static LevelData? getByIndex(int levelIndex) {
    if (levelIndex < 0 || levelIndex >= _all.length) return null;
    return _all[levelIndex];
  }
}
