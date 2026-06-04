import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 1 · δ Mintaka · 10×10 · pathLength=10
/// Складність: СЕРЕДНЬО
/// Форма: діагональ вгору-праворуч із одним вертикальним кроком посередині
/// Спектр: b→w→g→r→g→w→b→w→g→r
class OrionLevel1 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 1,
    totalLevels: 7,
    greekLetter: 'α',
    starName: 'Бетельгейзе',
    starNameLatin: 'Betelgeuse',
    constellation: 'Оріон',
    goalText: 'Знайди шлях від А до В',
    pathLength: 10,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СЕРЕДНЬО',
    hint: 'ДІАГОНАЛЬ ВГОРУ · ОДИН КРОК ВЕРТИКАЛЬНО',
    grid: _buildGrid(),
    startPos: (9, 0),
    endPos: (0, 8),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(10, null));

    // ── Правильний шлях ───────────────────────────────────────────────────
    _p(grid, 9, 0, b); // A — старт
    _p(grid, 8, 1, w);
    _p(grid, 7, 2, g);
    _p(grid, 6, 3, r);
    _p(grid, 5, 3, g); // ← вертикальний крок (пастка: всі чекають діагоналі)
    _p(grid, 4, 4, w);
    _p(grid, 3, 5, b);
    _p(grid, 2, 6, w);
    _p(grid, 1, 7, g);
    _p(grid, 0, 8, r); // B — фініш

    // ── Стратегічні пастки ────────────────────────────────────────────────
    _p(grid, 9, 1, w);  // adj A: b→w ✓ — веде не туди
    _p(grid, 8, 0, w);  // adj A: b→w ✓ — тупик вниз
    _p(grid, 8, 2, g);  // adj step2: w→g ✓ — продовжує діагональ мимо
    _p(grid, 7, 1, b);  // adj step2: w→b ✓ — відволікає ліворуч
    _p(grid, 7, 3, r);  // adj step3: g→r ✓ — продовжує діагональ, але тупик
    _p(grid, 6, 4, g);  // adj step4: r→g ✓ — спокушає продовжити діагональ
    _p(grid, 5, 4, r);  // adj step5: g→r ✓ — від r важко дотягтись до B
    _p(grid, 5, 2, w);  // adj step5: g→w ✓ — веде ліворуч від шляху
    _p(grid, 4, 3, g);  // adj step6: w→g ✓
    _p(grid, 4, 5, b);  // adj step6: w→b ✓ — веде від B
    _p(grid, 3, 4, w);  // adj step7: b→w ✓
    _p(grid, 3, 6, w);  // adj step7: b→w ✓ — через одну від B
    _p(grid, 2, 5, b);  // adj step8: w→b ✓
    _p(grid, 2, 7, g);  // adj step8: w→g ✓ — веде повз B
    _p(grid, 1, 8, r);  // adj step9: g→r ✓ — хибна мета поряд з B
    _p(grid, 0, 7, g);  // adj B: r→g ✓ — відволікає від фінішу

    // ── Фільтрні зірки ────────────────────────────────────────────────────
    _p(grid, 9, 3, g);  _p(grid, 9, 5, b);  _p(grid, 9, 7, r);
    _p(grid, 8, 4, r);  _p(grid, 8, 6, g);  _p(grid, 8, 8, w);
    _p(grid, 7, 5, w);  _p(grid, 7, 7, b);  _p(grid, 7, 9, g);
    _p(grid, 6, 6, b);  _p(grid, 6, 8, w);  _p(grid, 6, 9, g);
    _p(grid, 5, 6, b);  _p(grid, 5, 8, r);  _p(grid, 5, 9, w);
    _p(grid, 4, 7, g);  _p(grid, 4, 9, r);
    _p(grid, 3, 2, g);  _p(grid, 3, 8, b);  _p(grid, 3, 9, r);
    _p(grid, 2, 2, r);  _p(grid, 2, 4, g);  _p(grid, 2, 9, b);
    _p(grid, 1, 1, b);  _p(grid, 1, 3, g);  _p(grid, 1, 5, r); _p(grid, 1, 9, w);
    _p(grid, 0, 1, w);  _p(grid, 0, 3, b);  _p(grid, 0, 5, r); _p(grid, 0, 9, g);

    return grid; // 10+16+30 = 56/100 = 56%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
