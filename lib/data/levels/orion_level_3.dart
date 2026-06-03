import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 3 · ζ Alnitak · 10×10 · pathLength=12
/// Складність: СЕРЕДНЬО
/// Форма: діагональ праворуч-вгору, вертикальний крок, діагональ ліворуч-вгору,
///        горизонтально до лівого кута — "дах шатра"
/// Спектр: g→r→g→w→b→w→g→w→b→w→g→r
class OrionLevel3 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 3,
    totalLevels: 7,
    greekLetter: 'ζ',
    starName: 'Альнітак',
    starNameLatin: 'Alnitak',
    constellation: 'Оріон',
    goalText: 'Прокладіть шлях від А до В',
    pathLength: 12,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СЕРЕДНЬО',
    hint: 'ДВА ПОВОРОТА · ШЛЯХ ЙДЕ ВВЕРх ЗИҐЗАҐОМ',
    grid: _buildGrid(),
    startPos: (9, 0),
    endPos: (0, 0),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(10, null));

    // ── Правильний шлях ───────────────────────────────────────────────────
    _p(grid, 9, 0, g); // A — старт
    _p(grid, 8, 1, r);
    _p(grid, 7, 2, g);
    _p(grid, 6, 3, w);
    _p(grid, 5, 4, b);
    _p(grid, 4, 5, w); // ← вертикаль або діагональ — сюди
    _p(grid, 3, 5, g); // ← вертикальний крок
    _p(grid, 2, 4, w); // ← тепер діагональ ліворуч
    _p(grid, 1, 3, b);
    _p(grid, 0, 2, w);
    _p(grid, 0, 1, g); // ← горизонтально
    _p(grid, 0, 0, r); // B — фініш

    // ── Стратегічні пастки ────────────────────────────────────────────────
    _p(grid, 9, 1, r);  // adj A: g→r ✓ — не той напрямок
    _p(grid, 8, 0, r);  // adj step1: g→r ✓ — тупик вниз
    _p(grid, 8, 2, w);  // adj step2: r→w diff=2 — ЗАБЛОКОВАНО ← видима пастка
    _p(grid, 7, 1, w);  // adj step2: r→w diff=2 — заблоковано
    _p(grid, 7, 3, r);  // adj step3: g→r ✓ — продовжує діагональ
    _p(grid, 6, 4, b);  // adj step4: w→b ✓ — спокушає піти діагоналлю
    _p(grid, 6, 2, b);  // adj step4: w→b ✓ — відводить ліворуч
    _p(grid, 5, 5, w);  // adj step5: b→w ✓ — манить праворуч
    _p(grid, 5, 3, w);  // adj step5: b→w ✓ — ліворуч
    _p(grid, 4, 4, b);  // adj step6: w→b ✓
    _p(grid, 4, 6, g);  // adj step6: w→g ✓ — праворуч від шляху
    _p(grid, 3, 4, w);  // adj step7: g→w ✓
    _p(grid, 3, 6, r);  // adj step7: g→r ✓ — веде у бік
    _p(grid, 2, 3, b);  // adj step8: w→b ✓
    _p(grid, 2, 5, g);  // adj step8: w→g ✓ — веде від фінішу
    _p(grid, 1, 2, w);  // adj step9: b→w ✓
    _p(grid, 1, 4, g);  // adj step9: b→g diff=2 — ЗАБЛОКОВАНО
    _p(grid, 0, 3, b);  // adj step10: w→b ✓ — праворуч від кінця шляху

    // ── Фільтрні зірки ────────────────────────────────────────────────────
    _p(grid, 9, 3, b);  _p(grid, 9, 5, r);  _p(grid, 9, 7, w);  _p(grid, 9, 9, g);
    _p(grid, 8, 4, g);  _p(grid, 8, 6, b);  _p(grid, 8, 8, r);
    _p(grid, 7, 5, r);  _p(grid, 7, 7, g);  _p(grid, 7, 9, w);
    _p(grid, 6, 6, w);  _p(grid, 6, 8, b);  _p(grid, 6, 9, r);
    _p(grid, 5, 7, g);  _p(grid, 5, 9, b);
    _p(grid, 4, 8, r);  _p(grid, 4, 9, w);
    _p(grid, 3, 7, b);  _p(grid, 3, 8, w);  _p(grid, 3, 9, g);
    _p(grid, 2, 6, r);  _p(grid, 2, 8, g);  _p(grid, 2, 9, b);
    _p(grid, 1, 6, w);  _p(grid, 1, 7, r);  _p(grid, 1, 8, b); _p(grid, 1, 9, g);
    _p(grid, 0, 4, r);  _p(grid, 0, 6, g);  _p(grid, 0, 7, w); _p(grid, 0, 9, b);

    return grid; // 12+18+30 = 60/100 = 60%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
