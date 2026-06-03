import '../../models/star_model.dart';
import '../../models/level_model.dart';

/// Рівень 2 · ε Alnilam · 10×10 · pathLength=12
/// Складність: СЕРЕДНЬО
/// Форма: діагональ вгору-ліворуч, потім вертикально вгору, потім горизонтально
/// Спектр: r→g→w→b→w→g→r→g→w→b→w→g
class OrionLevel2 {
  static const b = StarSpectrum.blue;
  static const w = StarSpectrum.white;
  static const g = StarSpectrum.gold;
  static const r = StarSpectrum.red;

  static LevelData get level => LevelData(
    levelNumber: 2,
    totalLevels: 7,
    greekLetter: 'ε',
    starName: 'Альнілам',
    starNameLatin: 'Alnilam',
    constellation: 'Оріон',
    goalText: 'Прокладіть шлях від А до В',
    pathLength: 12,
    targetBrightness: null,
    solutionCount: 1,
    difficulty: 'СЕРЕДНЬО',
    hint: 'ДІАГОНАЛЬ · ПОТІМ ПРЯМО ВГОРУ · ПОТІМ ЛІВОРУЧ',
    grid: _buildGrid(),
    startPos: (9, 9),
    endPos: (0, 3),
  );

  static List<List<GridStar?>> _buildGrid() {
    final grid = List.generate(10, (_) => List<GridStar?>.filled(10, null));

    // ── Правильний шлях ───────────────────────────────────────────────────
    _p(grid, 9, 9, r); // A — старт
    _p(grid, 8, 8, g);
    _p(grid, 7, 7, w);
    _p(grid, 6, 6, b);
    _p(grid, 5, 5, w);
    _p(grid, 4, 5, g); // ← вертикальний крок (пастка діагоналі)
    _p(grid, 3, 5, r);
    _p(grid, 2, 5, g);
    _p(grid, 1, 5, w);
    _p(grid, 0, 5, b);
    _p(grid, 0, 4, w); // ← горизонтальний поворот
    _p(grid, 0, 3, g); // B — фініш

    // ── Стратегічні пастки ────────────────────────────────────────────────
    _p(grid, 9, 8, g);  // adj A: r→g ✓ — продовження по рядку
    _p(grid, 8, 9, g);  // adj A: r→g ✓ — вниз, тупик
    _p(grid, 8, 7, w);  // adj step2: g→w ✓
    _p(grid, 7, 8, b);  // adj step2: g→b diff=2 — ЗАБЛОКОВАНО ← видима пастка
    _p(grid, 7, 6, b);  // adj step3: w→b ✓ — іде в бік
    _p(grid, 6, 7, w);  // adj step3: w→w diff=0 — заблоковано
    _p(grid, 6, 5, w);  // adj step4: b→w ✓ — спокушає продовжити діагональ
    _p(grid, 5, 6, g);  // adj step5: w→g ✓
    _p(grid, 5, 4, g);  // adj step5: w→g ✓ — теж ±1, але не вертикаль
    _p(grid, 4, 4, w);  // adj step6: g→w ✓ — діагональ від поясу
    _p(grid, 4, 6, r);  // adj step6: g→r ✓ — виглядає правильним але відводить
    _p(grid, 3, 4, g);  // adj step7: r→g ✓
    _p(grid, 3, 6, g);  // adj step7: r→g ✓ — симетрична пастка
    _p(grid, 2, 4, b);  // adj step8: g→b diff=2 — ЗАБЛОКОВАНО
    _p(grid, 2, 6, w);  // adj step8: g→w ✓
    _p(grid, 1, 4, r);  // adj step9: w→r diff=2 — ЗАБЛОКОВАНО ← видима пастка
    _p(grid, 0, 6, w);  // adj step10: b→w ✓ — від b горизонталь
    _p(grid, 0, 2, r);  // adj B: g→r ✓ — хибна мета лівіше

    // ── Фільтрні зірки ────────────────────────────────────────────────────
    _p(grid, 9, 0, b);  _p(grid, 9, 2, w);  _p(grid, 9, 4, g);  _p(grid, 9, 6, b);
    _p(grid, 8, 1, r);  _p(grid, 8, 3, g);  _p(grid, 8, 5, b);  _p(grid, 8, 6, r);
    _p(grid, 7, 0, g);  _p(grid, 7, 2, r);  _p(grid, 7, 4, g);  _p(grid, 7, 9, r);
    _p(grid, 6, 1, w);  _p(grid, 6, 3, r);  _p(grid, 6, 8, g);  _p(grid, 6, 9, b);
    _p(grid, 5, 0, r);  _p(grid, 5, 2, b);  _p(grid, 5, 7, r);  _p(grid, 5, 9, g);
    _p(grid, 4, 0, g);  _p(grid, 4, 2, w);  _p(grid, 4, 7, b);  _p(grid, 4, 9, w);
    _p(grid, 3, 0, b);  _p(grid, 3, 2, r);  _p(grid, 3, 7, w);  _p(grid, 3, 9, r);
    _p(grid, 2, 0, w);  _p(grid, 2, 2, g);  _p(grid, 2, 7, b);  _p(grid, 2, 9, g);
    _p(grid, 1, 0, g);  _p(grid, 1, 2, b);  _p(grid, 1, 6, r);  _p(grid, 1, 7, g);
    _p(grid, 0, 0, r);  _p(grid, 0, 1, g);  _p(grid, 0, 7, b);  _p(grid, 0, 9, w);

    return grid; // 12+18+36 = 66/100 = 66%
  }

  static void _p(List<List<GridStar?>> g, int row, int col, StarSpectrum s) {
    g[row][col] = GridStar(row: row, col: col, spectrum: s);
  }
}
