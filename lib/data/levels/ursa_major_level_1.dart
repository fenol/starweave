import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 1 · δ Megrez · 6×6 · pathLength=6
/// Складність: ЛЕГКО
/// Форма: чиста діагональ (bottom-right → top-left)
/// Спектр: red → gold → white → blue → white → gold
class UrsaMajorLevel1 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 1,
    totalLevels: 7,
    greekLetter: 'δ',
    starName: 'Мегрец',
    starNameLatin: 'Megrez',
    constellation: 'Велика Ведмедиця',
    goalText: 'Прокладіть шлях від А до В',
    pathLength: 6,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'ЛЕГКО',
    hint: 'ЛИШЕ СУСІДНІ КЛАСИ · ±1',
    grid: _buildGrid(),
    startPos: (5, 5),
    endPos: (0, 0),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(6, (_) => List<GridStar?>.filled(6, null));

    // ── Правильний шлях ───────────────────────────────────────────────────
    // r→g→w→b→w→g  (кожен крок діагональ вгору-ліворуч)
    _p(grid, 5, 5, r); // A — старт
    _p(grid, 4, 4, g);
    _p(grid, 3, 3, w);
    _p(grid, 2, 2, b);
    _p(grid, 1, 1, w);
    _p(grid, 0, 0, g); // B — фініш

    // ── Стратегічні пастки (поряд зі шляхом) ─────────────────────────────
    _p(grid, 5, 4, g); // adj A: r→g ✓ але не той напрямок
    _p(grid, 4, 5, g); // adj A: r→g ✓ але не той напрямок
    _p(grid, 4, 3, w); // adj step2: g→w ✓ тупик
    _p(grid, 3, 4, r); // adj step2: g→r ✓ тупик
    _p(grid, 3, 2, g); // adj step3: w→g ✓ не той шлях
    _p(grid, 2, 3, b); // adj step3: w→b ✓ тупик
    _p(grid, 2, 1, w); // adj step4: b→w ✓ не той шлях
    _p(grid, 1, 2, w); // adj step4: b→w ✓ тупик
    _p(grid, 1, 0, b); // adj step5: w→b ✓ → від b до B(g) diff=2 тупик!
    _p(grid, 0, 1, w); // adj B: g→w ✓ але вже фініш

    // ── Фільтрні зірки (рівномірне заповнення) ───────────────────────────
    _p(grid, 5, 3, w);
    _p(grid, 5, 2, b);
    _p(grid, 5, 1, r);
    _p(grid, 4, 2, r);
    _p(grid, 3, 5, b);
    _p(grid, 2, 5, r);
    _p(grid, 1, 4, g);
    _p(grid, 0, 3, r);

    return grid; // 6+10+8 = 24/36 = 66.7%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
