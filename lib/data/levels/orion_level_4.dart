import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 4 · γ Bellatrix · 12×12 · pathLength=14
/// Складність: СКЛАДНО
/// Форма: S-крива — діагональ праворуч-вгору, потім розворот вгору-ліворуч
/// Спектр: b→w→g→r→g→w→b→w→g→w→b→w→g→r
class OrionLevel4 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 4,
    totalLevels: 7,
    greekLetter: 'γ',
    starName: 'Беллатрікс',
    starNameLatin: 'Bellatrix',
    constellation: 'Оріон',
    goalText: 'Прокладіть шлях від А до В',
    pathLength: 14,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'S-КРИВА · ШЛЯХ ПОВЕРТАЄ ПОСЕРЕДИНІ',
    grid: _buildGrid(),
    startPos: (11, 0),
    endPos: (0, 1),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(12, (_) => List<GridStar?>.filled(12, null));

    // ── Правильний шлях ───────────────────────────────────────────────────
    _p(grid, 11, 0, b); // A — старт
    _p(grid, 10, 1, w);
    _p(grid, 9, 2, g);
    _p(grid, 8, 3, r);
    _p(grid, 7, 4, g);
    _p(grid, 6, 5, w);
    _p(grid, 5, 6, b); // ← пік S-кривої
    _p(grid, 4, 6, w); // ← вертикальний розворот
    _p(grid, 3, 6, g);
    _p(grid, 2, 5, w); // ← тепер діагональ ліворуч-вгору
    _p(grid, 1, 4, b);
    _p(grid, 0, 3, w);
    _p(grid, 0, 2, g); // ← горизонтально до B
    _p(grid, 0, 1, r); // B — фініш

    // ── Стратегічні пастки ────────────────────────────────────────────────
    _p(grid, 11, 1, w);  // adj A
    _p(grid, 10, 0, w);  // adj A: веде вниз
    _p(grid, 10, 2, g);  _p(grid, 9, 1, w);  // adj step2
    _p(grid, 9, 3, r);   _p(grid, 8, 2, g);  // adj step3
    _p(grid, 8, 4, g);   _p(grid, 7, 3, r);  // adj step4: r→g ✓ — спокушає
    _p(grid, 7, 5, w);   _p(grid, 6, 4, b);  // adj step5
    _p(grid, 6, 6, b);   _p(grid, 5, 5, w);  // adj step6: b→w ✓ — перед розворотом
    _p(grid, 5, 7, w);   _p(grid, 4, 7, g);  // adj step7-8
    _p(grid, 3, 7, r);   _p(grid, 3, 5, r);  // adj step9: g→r ✓ — розгалуження
    _p(grid, 2, 6, b);   _p(grid, 2, 4, b);  // adj step10: w→b ✓
    _p(grid, 1, 5, w);   _p(grid, 1, 3, w);  // adj step11: b→w ✓
    _p(grid, 0, 4, g);   _p(grid, 0, 0, g);  // adj step12: w→g ✓ та adj B

    // ── Фільтрні зірки ────────────────────────────────────────────────────
    _p(grid, 11, 3, r); _p(grid, 11, 5, g); _p(grid, 11, 7, b); _p(grid, 11, 9, w);
    _p(grid, 11, 11, r);
    _p(grid, 10, 4, b); _p(grid, 10, 6, r); _p(grid, 10, 8, g); _p(grid, 10, 10, w);
    _p(grid, 9, 5, w);  _p(grid, 9, 7, b);  _p(grid, 9, 9, r);  _p(grid, 9, 11, g);
    _p(grid, 8, 6, g);  _p(grid, 8, 8, w);  _p(grid, 8, 10, b);
    _p(grid, 7, 7, r);  _p(grid, 7, 9, g);  _p(grid, 7, 11, w);
    _p(grid, 6, 8, r);  _p(grid, 6, 10, g); _p(grid, 6, 11, b);
    _p(grid, 5, 9, g);  _p(grid, 5, 11, r);
    _p(grid, 4, 8, b);  _p(grid, 4, 10, r); _p(grid, 4, 11, w);
    _p(grid, 3, 9, w);  _p(grid, 3, 10, b); _p(grid, 3, 11, g);
    _p(grid, 2, 9, g);  _p(grid, 2, 10, r); _p(grid, 2, 11, b);
    _p(grid, 1, 8, r);  _p(grid, 1, 9, w);  _p(grid, 1, 10, g); _p(grid, 1, 11, b);
    _p(grid, 0, 6, b);  _p(grid, 0, 7, w);  _p(grid, 0, 8, g);  _p(grid, 0, 9, r);

    return grid; // 14+20+35 = 69/144 = 48%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
