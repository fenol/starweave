import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 6 · α Betelgeuse · 12×12 · pathLength=16
/// Складність: СКЛАДНО
/// Форма: зиґзаґ по правому краю донизу, потім горизонталь вліво
///        — "падіння Бетельгейзе"
/// Спектр: r→g→w→b→w→g→r→g→w→b→w→g→r→g→w→b
class OrionLevel6 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 6,
    totalLevels: 7,
    greekLetter: 'α',
    starName: 'Бетельгейзе',
    starNameLatin: 'Betelgeuse',
    constellation: 'Оріон',
    goalText: 'Прокладіть шлях від А до В',
    pathLength: 16,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СКЛАДНО',
    hint: 'ЗИҐЗАҐ ПО ПРАВОМУ КРАЮ · ПОТІМ ЛІВОРУЧ',
    grid: _buildGrid(),
    startPos: (0, 11),
    endPos: (11, 4),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(12, (_) => List<GridStar?>.filled(12, null));

    // ── Правильний шлях ───────────────────────────────────────────────────
    // Зиґзаґ: ліворуч-вниз, потім праворуч-вниз, повторити
    _p(grid, 0, 11, r); // A — старт (правий верхній кут)
    _p(grid, 1, 10, g);
    _p(grid, 2, 9, w);
    _p(grid, 3, 8, b);  // ← тепер зиґзаґ назад праворуч
    _p(grid, 4, 9, w);
    _p(grid, 5, 10, g);
    _p(grid, 6, 11, r); // ← правий край знову
    _p(grid, 7, 10, g); // ← знову ліворуч
    _p(grid, 8, 9, w);
    _p(grid, 9, 8, b);
    _p(grid, 10, 8, w); // ← вертикальний крок вниз
    _p(grid, 11, 8, g);
    _p(grid, 11, 7, r); // ← горизонталь до B
    _p(grid, 11, 6, g);
    _p(grid, 11, 5, w);
    _p(grid, 11, 4, b); // B — фініш

    // ── Стратегічні пастки ────────────────────────────────────────────────
    _p(grid, 0, 10, g);   // adj A: r→g ✓
    _p(grid, 1, 11, g);   // adj step1: r→g ✓ — веде по краю
    _p(grid, 1, 9, w);    // adj step2: g→w ✓
    _p(grid, 2, 10, g);   // adj step2: g→g diff=0 — заблоковано
    _p(grid, 2, 8, b);    // adj step3: w→b ✓
    _p(grid, 3, 9, w);    // adj step4: b→w ✓ — шлях повертає сюди, але це пастка
    _p(grid, 3, 7, w);    // adj step4: b→w ✓ — продовжити вниз-ліворуч
    _p(grid, 4, 8, b);    // adj step5: w→b ✓
    _p(grid, 4, 10, g);   // adj step5: w→g ✓ — праворуч
    _p(grid, 5, 9, r);    // adj step6: g→r ✓ — пастка зворотна діагональ
    _p(grid, 5, 11, r);   // adj step6: g→r ✓ — правий край
    _p(grid, 6, 10, g);   // adj step7: r→g ✓ — спокушає продовжити вгору
    _p(grid, 7, 11, r);   // adj step7: r→r diff=0 — заблоковано (однаковий спектр)
    _p(grid, 7, 9, w);    // adj step8: g→w ✓ — конкурує з правильним кроком
    _p(grid, 8, 10, g);   // adj step8 alt
    _p(grid, 8, 8, b);    // adj step9: w→b ✓ — потрапляє в тупик
    _p(grid, 9, 9, w);    // adj step10: b→w ✓ — манить праворуч
    _p(grid, 9, 7, w);    // adj step10: b→w ✓ — лівіше від шляху
    _p(grid, 10, 7, g);   // adj step11: w→g ✓ — відводить від горизонталі
    _p(grid, 11, 9, r);   // adj step12: g→r ✓ — праворуч від B
    _p(grid, 11, 3, w);   // adj B: b→w ✓ — лівіше B

    // ── Фільтрні зірки ────────────────────────────────────────────────────
    _p(grid, 0, 0, b);  _p(grid, 0, 2, g);  _p(grid, 0, 4, r);  _p(grid, 0, 6, w);
    _p(grid, 0, 8, g);
    _p(grid, 1, 0, w);  _p(grid, 1, 2, b);  _p(grid, 1, 4, g);  _p(grid, 1, 6, r);
    _p(grid, 2, 0, r);  _p(grid, 2, 2, w);  _p(grid, 2, 4, b);  _p(grid, 2, 6, g);
    _p(grid, 3, 0, g);  _p(grid, 3, 2, r);  _p(grid, 3, 4, w);  _p(grid, 3, 6, b);
    _p(grid, 4, 0, b);  _p(grid, 4, 2, g);  _p(grid, 4, 4, r);  _p(grid, 4, 6, w);
    _p(grid, 5, 0, w);  _p(grid, 5, 2, b);  _p(grid, 5, 4, g);  _p(grid, 5, 6, r);
    _p(grid, 5, 7, b);  _p(grid, 5, 8, w);
    _p(grid, 6, 0, r);  _p(grid, 6, 2, w);  _p(grid, 6, 4, b);  _p(grid, 6, 6, g);
    _p(grid, 6, 7, w);  _p(grid, 6, 8, r);  _p(grid, 6, 9, g);
    _p(grid, 7, 0, g);  _p(grid, 7, 2, r);  _p(grid, 7, 4, w);  _p(grid, 7, 6, b);
    _p(grid, 8, 0, b);  _p(grid, 8, 2, g);  _p(grid, 8, 4, w);  _p(grid, 8, 6, r);
    _p(grid, 9, 0, w);  _p(grid, 9, 2, b);  _p(grid, 9, 4, g);  _p(grid, 9, 6, r);
    _p(grid, 10, 0, g); _p(grid, 10, 2, r); _p(grid, 10, 4, b); _p(grid, 10, 6, w);
    _p(grid, 10, 9, b); _p(grid, 10, 10, r); _p(grid, 10, 11, g);
    _p(grid, 11, 0, r); _p(grid, 11, 1, g); _p(grid, 11, 2, w); _p(grid, 11, 10, w);
    _p(grid, 11, 11, b);

    return grid; // 16+21+46 = 83/144 = 58%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
